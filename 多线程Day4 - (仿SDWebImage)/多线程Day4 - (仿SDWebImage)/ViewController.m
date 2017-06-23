//
//  ViewController.m
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/23.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //准备队列
    NSOperationQueue *queue = [NSOperationQueue new];
    
    //创建自定义操作,只能调用系统的实例化方法new
    DownloadOperation *op = [DownloadOperation new];
    
    //把自定义操作添加到队列
    [queue addOperation:op];
     
    
    
}



@end
