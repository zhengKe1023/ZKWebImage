//
//  UIImageView+WebImage.h
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/26.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebImageManager.h"

@interface UIImageView (WebImage)

@property(nonatomic,copy)NSString *lastURLString;

- (void)zk_setImageWithURLString:(NSString *)URLString;
@end
