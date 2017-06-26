//
//  UIImageView+WebImage.m
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/26.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import "UIImageView+WebImage.h"
/**
 分类定义的属性不能实现setter和getter方法(待解决);
 */

@implementation UIImageView (WebImage)

- (void)zk_setImageWithURLString:(NSString *)URLString{
    
    //在进入下载前,判断连续传入的地址是否一样,如果不一样,就把前一个下载操作取消
    if (![URLString isEqualToString:self.lastURLString] && self.lastURLString != nil) {
        
        //单例接管取消操作
        [[WebImageManager sharedManager] cancelLastOperation:self.lastURLString];
    }
    
    //记录上次图片地址
    self.lastURLString = URLString;
    
    //单例接管下载操作
    [[WebImageManager sharedManager] downloadImageWithURLString:URLString completion:^(UIImage *image) {
        
        self.image = image;
    }];
    
}
@end
