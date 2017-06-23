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
    
    //向操作中添加网络地址
    op.URLString = @"http://pic.58pic.com/58pic/13/61/00/61a58PICtPr_1024.jpg";
    
    //用于回调图片对象的代码块
    [op setImageBlock:^(UIImage *image){
        
        NSLog(@"%@ %@",image,[NSThread currentThread]);
        
    }];
    
    
    //把自定义操作添加到队列
    [queue addOperation:op];
     
    
    
}



@end
