//
//  DownloadOperation.m
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/23.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import "DownloadOperation.h"

@interface DownloadOperation ()

/**
 不需要被外界访问
 */
//接收外界传入图片的地址
@property(nonatomic,copy)NSString *URLString;

//接收外界传入的回调的代码块
@property(nonatomic,copy)void(^finishedBlock)(UIImage *image);


@end


/**
 下载图片
 1.图片地址
 2.需要图片的回调代码块
 */

@implementation DownloadOperation

+ (instancetype)downLoadOperationWithURLString:(NSString *)URLString finish:(void (^)(UIImage *))finishedBlock{
    
    
    //创建自定义操作,只能调用系统的实例化方法new
    DownloadOperation *op = [DownloadOperation new];
    
    //记录全局的图片地址
    op.URLString = URLString;
    
    //记录全局回调的代码块
    op.finishedBlock = finishedBlock;
    
    return op;
}

//操作的入口方法:默认在子线程异步执行的,队列调度操作执行后,才会进入main方法
- (void)main{
    
    NSLog(@"传入 = %@",self.URLString);
    
    NSURL *url = [NSURL URLWithString:_URLString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    //图片下载结束,xuyao使用代码块把图片回调给外界
    if(self.finishedBlock != nil){
        
        //刷新UI,回到主线程:在哪个线程调用的,那么就在哪个线程执行;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedBlock(image);
        }];
        
    }
    
    
    
}



@end
