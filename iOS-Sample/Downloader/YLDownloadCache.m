//
//  YLDownloadCache.m
//  YLDownloadKit
//
//  Created by Eric Yuan on 13-5-19.
//  Copyright (c) 2013年 Eric Yuan. All rights reserved.
//

#import "YLDownloadCache.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7;

@interface YLDownloadCache ()

@property (nonatomic, strong)NSCache* memCache;
@property (nonatomic, strong)NSString* diskCachePath;
@property (nonatomic)dispatch_queue_t ioQueue;

@end

@implementation YLDownloadCache

+ (id)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = self.new;
    });
    
    return instance;
}

- (id)init
{
    return [self initWithNamespace:@"default"];
}

- (id)initWithNamespace:(NSString *)ns
{
    if (self = [super init]) {
        NSString* fullNameSpace = [@"li.yuan.YLDownloadKit." stringByAppendingString:ns];
        _ioQueue = dispatch_queue_create("li.yuan.YLDownloadKit", DISPATCH_QUEUE_SERIAL);
        
        _maxCacheAge = kDefaultCacheMaxCacheAge;
        
        _memCache = [[NSCache alloc] init];
        _memCache.name = fullNameSpace;
        
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCachePath = [paths[0] stringByAppendingPathComponent:fullNameSpace];  
        
#if TARGET_OS_IPHONE
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanDisk)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
#endif
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private method
- (NSString*)cachePathForKey:(NSString*)key
{
    const char* str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString* filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x.mp4",
                         r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return [self.diskCachePath stringByAppendingPathComponent:filename];
}

#pragma mark - public
- (void)storeData:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk complete:(void (^)(void))complete
{
    if (!data || !key) {
        return;
    }
    
    [self.memCache setObject:data forKey:key];
    
    if (toDisk) {
        dispatch_async(self.ioQueue, ^{
            NSData* myData = data;
            if (myData) {
                NSFileManager* fileManager = NSFileManager.new;
                
                if (![fileManager fileExistsAtPath:_diskCachePath]) {
                    [fileManager createDirectoryAtPath:_diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
                }
                
                [fileManager createFileAtPath:[self cachePathForKey:key] contents:myData attributes:nil];
                complete();
            }
        });
    }
}

- (NSData*)dataFromMemoryCacheForKey:(NSString *)key
{
    return [self.memCache objectForKey:key];
}

- (NSData*)dataFromDiskCacheForKey:(NSString *)key
{
    NSData* data = [self dataFromMemoryCacheForKey:key];
    if (data) return data;
    
    NSData* diskData = [self diskDataForKey:key];
    if (diskData) {
        [self.memCache setObject:diskData forKey:key];
    }
    return diskData;
}

- (NSData*)diskDataForKey:(NSString*)key
{
    NSString* path = [self cachePathForKey:key];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    return data;
}

- (void)queryDiskCacheForKey:(NSString *)key done:(void (^)(NSData *))doneBlock
{
    if (!doneBlock) {
        return;
    }
    
    if (!key) {
        doneBlock(nil);
        return;
    }
    
    dispatch_async(self.ioQueue, ^{
        @autoreleasepool {
            NSData* data = [self.memCache objectForKey:key];
            if (nil == data) {
                NSData* data = [self diskDataForKey:key];
                if (data) {
                    [self.memCache setObject:data forKey:key];
                }
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                doneBlock(data);
            });
        }
    });
}

- (void)removeDataForKey:(NSString *)key fromDisk:(BOOL)fromDisk
{
    if (key == nil) {
        return;
    }
    
    [self.memCache removeObjectForKey:key];
    
    if (fromDisk) {
        dispatch_async(self.ioQueue, ^{
            [NSFileManager.new removeItemAtPath:[self cachePathForKey:key] error:nil];
        });
    }
}

- (void)clearMemory
{
    [self.memCache removeAllObjects];
}

- (void)clearDisk
{
    dispatch_async(self.ioQueue, ^{
        
        [NSFileManager.new removeItemAtPath:self.diskCachePath error:nil];
        [NSFileManager.new createDirectoryAtPath:self.diskCachePath
                     withIntermediateDirectories:YES
                                      attributes:nil
                                           error:NULL];
    });
}

- (void)cleanDisk
{
    dispatch_async(self.ioQueue, ^{
        NSFileManager* manage = NSFileManager.new;
        NSURL* diskCacheURL = [NSURL fileURLWithPath:self.diskCachePath isDirectory:YES];
        NSArray* resourceKeys = @[NSURLIsDirectoryKey, NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey];
        
        NSDirectoryEnumerator* fileEnumerator = [manage enumeratorAtURL:diskCacheURL
                                             includingPropertiesForKeys:resourceKeys
                                                                options:NSDirectoryEnumerationSkipsHiddenFiles
                                                           errorHandler:NULL];
        
        NSDate* expirationDate = [NSDate dateWithTimeIntervalSinceNow:-self.maxCacheAge];
        NSMutableDictionary* cacheFiles = [NSMutableDictionary dictionary];
        unsigned long long currentCacheSize = 0;
        
        for (NSURL* fileURL in fileEnumerator) {
            NSDictionary* resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:NULL];
            
            if ([resourceValues[NSURLIsDirectoryKey] boolValue]) {
                continue;
            }
            
            NSDate* modificationDate = resourceValues[NSURLContentModificationDateKey];
            if ([[modificationDate laterDate:expirationDate] isEqualToDate:expirationDate]) {
                [manage removeItemAtURL:fileURL error:nil];
                continue;
            }
            
            NSNumber* totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
            currentCacheSize += [totalAllocatedSize unsignedLongLongValue];
            [cacheFiles setObject:resourceValues forKey:fileURL];
        }
        
                   if (self.maxCacheSize > 0 && currentCacheSize > self.maxCacheSize) {
                       const unsigned long long desiredCacheSize = self.maxCacheSize / 2;
                       
                       NSArray* sortedFile = [cacheFiles keysSortedByValueWithOptions:NSSortConcurrent
                                                                      usingComparator:^NSComparisonResult(id obj1, id obj2) {
                                                                          return [obj1[NSURLContentModificationDateKey] compare:obj2[NSURLContentModificationDateKey]];
                       }];
                       
                       for (NSURL* fileURL in sortedFile) {
                           if ([manage removeItemAtURL:fileURL error:nil]) {
                               NSDictionary* resourceValues = cacheFiles[fileURL];
                               NSNumber* totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
                               currentCacheSize -= [totalAllocatedSize unsignedLongLongValue];
                               
                               if (currentCacheSize < desiredCacheSize) {
                                   break;
                               }
                           }
                       }
                   }
    });
}

- (unsigned long long)getSize
{
    unsigned long long size = 0;
    NSDirectoryEnumerator* fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:self.diskCachePath];
    for (NSString* fileName in fileEnumerator) {
        NSString* filePath = [self.diskCachePath stringByAppendingPathComponent:fileName];
        NSDictionary* attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    
    return size;
}

- (int)getDiskCount
{
    int count = 0;
    NSDirectoryEnumerator* fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:self.diskCachePath];
    for (NSString* fileName in fileEnumerator) {
        count += 1;
    }
    
    return count;
}

@end
