//
//  DownloadOperation.h
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/23.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+path.h"

@interface DownloadOperation : NSOperation


/**
 创建操作和下载图片的主方法
 第一个参数:图片地址
 第二个参数:下载完成的回调
 返回:自定义的下载操作
 */
+ (instancetype)downLoadOperationWithURLString:(NSString *)URLString finish:(void(^)(UIImage *image))finishedBlock;

@end
