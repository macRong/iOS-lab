//
//  YLDownloadCache.h
//  YLDownloadKit
//
//  Created by Eric Yuan on 13-5-19.
//  Copyright (c) 2013年 Eric Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLDownloadCache : NSObject

@property (nonatomic, assign)NSInteger maxCacheAge;
@property (nonatomic, assign)unsigned long long maxCacheSize;

+ (id)sharedInstance;

- (id)initWithNamespace:(NSString*)ns;

- (void)storeData:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk complete:(void (^)(void))complete;

- (void)queryDiskCacheForKey:(NSString*)key done:(void (^)(NSData* data))doneBlock;

- (NSData*)dataFromDiskCacheForKey:(NSString*)key;

- (NSData*)dataFromMemoryCacheForKey:(NSString*)key;

- (void)removeDataForKey:(NSString*)key fromDisk:(BOOL)fromDisk;

// clear all disk cache
- (void)clearDisk;

- (void)clearMemory;

// remove all expired caches from disk
- (void)cleanDisk;

- (unsigned long long)getSize;

- (NSInteger)getDiskCount;

- (NSString*)cachePathForKey:(NSString*)key;

@end
