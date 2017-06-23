//
//  DownloadOperation.h
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/23.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadOperation : NSOperation

//接收外界传入图片的地址
@property(nonatomic,copy)NSString *URLString;

//接收外界传入的回调的代码块
@property(nonatomic,copy)void(^imageBlock)(UIImage *);

@end
