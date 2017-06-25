//
//  WebImageManager.h
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/25.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownloadOperation.h"

@interface WebImageManager : NSObject

+ (instancetype)sharedManager;

//单例下载的主方法 
- (void)downloadImageWithURLString:(NSString *)URLString completion:(void(^)(UIImage *image))completionBlock;

- (void)cancelLastOperation:(NSString *)lastURLString ;

@end
