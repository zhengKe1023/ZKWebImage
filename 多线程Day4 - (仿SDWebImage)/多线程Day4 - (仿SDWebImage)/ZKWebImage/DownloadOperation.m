//
//  DownloadOperation.m
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/23.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation

//操作的入口方法:默认在子线程异步执行的,队列调度操作执行后,才会进入main方法
- (void)main{
    
    NSLog(@"main = %@",[NSThread currentThread]);
    
}

@end
