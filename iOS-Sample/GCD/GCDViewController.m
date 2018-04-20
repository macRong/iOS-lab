//
//  GCDViewController.m
//  iOS-Sample
//
//  Created by 荣守振 on 2018/4/15.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "GCDViewController.h"
#import "Person.h"

@interface GCDViewController ()

@end

@implementation GCDViewController


- (void)dealloc
{
    [super dealloc];
    NSLog(@"GCDViewController.dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    NSString *str  = nil;
    NSArray *arr = @[str];
}

//barrier（访问数据库或者文件的时候 ，读-写锁）
- (void)barrier
{
    dispatch_queue_t t = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(t, ^{
        
        NSLog(@"1");
    });
    dispatch_async(t, ^{
        NSLog(@"2");
    });
    dispatch_barrier_async(t, ^{
        NSLog(@"barrier");
    });
    dispatch_async(t, ^{
        sleep(2);
        NSLog(@"3");
    });
    dispatch_async(t, ^{
        
        NSLog(@"4");
    });
    sleep(2);
    NSLog(@"end");
}

//group
- (void)group{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t t = dispatch_get_global_queue(0, 0);

    dispatch_group_enter(group);
    dispatch_group_async(group, t, ^{
        dispatch_async(t, ^{
            sleep(2);
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, t, ^{
        dispatch_async(t, ^{
            NSLog(@"2");
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_notify(group, t, ^{
        NSLog(@"1，2任务都完成");
    });
}

#pragma mark - 嵌套
//同步主队列
- (void)syncMain{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务1");
    });
    
    NSLog(@"end");
    
}
//异步主队列
- (void)asyncMain{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"任务1");
    });
    
    NSLog(@"end");
    
}
//异步串行嵌套（同步）
- (void)asyncSerials{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{//block1
        NSLog(@"1");
        dispatch_async(queue, ^{//block2
            NSLog(@"2");
        });
        
    });
    
    NSLog(@"end");
    
}
//异步串行嵌套（异步）
- (void)asyncSeriala{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"1--%@",[NSThread currentThread]);
        dispatch_async(queue, ^{
            NSLog(@"2--%@",[NSThread currentThread]);
        });
        
        NSLog(@"3--%@",[NSThread currentThread]);
    });
    
    NSLog(@"end");
    
}
//同步串行嵌套（异步）
- (void)syncSeriala{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"1");
        dispatch_async(queue, ^{
            
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    
    NSLog(@"end");
    
}
//异步并发嵌套（同步）
- (void)asyncConcurrents{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
        dispatch_sync(queue, ^{
            NSLog(@"2");
        });
        
        NSLog(@"3");
    });
    
    NSLog(@"end");
    
}
//异步并发嵌套（异步）
- (void)asyncConcurrenta{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
        dispatch_async(queue, ^{
            NSLog(@"2");
        });
        
        NSLog(@"3");
    });
    
    NSLog(@"end");
    
}
//同步并发嵌套（同步）
- (void)syncConcurrents{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"1");
        dispatch_sync(queue, ^{
            NSLog(@"2");
        });
        
        NSLog(@"3");
    });
    
    NSLog(@"end");
    
}
//同步并发嵌套（异步）(2的顺序是不可控的，但是end一定会在13后面)

- (void)syncConcurrenta{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{//block1
        NSLog(@"1");
        dispatch_async(queue, ^{//block2
            sleep(2);
            NSLog(@"2");
        });
        
        NSLog(@"3");
    });
    
    NSLog(@"end");
    
}
//同步并发
- (void)syncConcurrent{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"任务1");
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"任务2");
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3");
    });
    NSLog(@"end");
    
}
//异步并发
- (void)asyncConcurrent{
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"任务1");
    });
    dispatch_async(queue, ^{
        
        NSLog(@"任务2");
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3");
    });
    
    NSLog(@"end");
    
}
//异步串行
- (void)asyncSerial{
    NSLog(@"begin");
    NSLog(@"begin--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"任务1");
        NSLog(@"1--%@",[NSThread currentThread]);
        
    });
    dispatch_async(queue, ^{
        NSLog(@"2--%@",[NSThread currentThread]);
        
        NSLog(@"任务2");
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3");
        NSLog(@"3--%@",[NSThread currentThread]);
        
    });
    NSLog(@"end");
    NSLog(@"end--%@",[NSThread currentThread]);
    
    
}
//同步串行
- (void)syncSerial{
    
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"任务1");
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2");
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务3");
    });
    NSLog(@"end");
    
}

@end
