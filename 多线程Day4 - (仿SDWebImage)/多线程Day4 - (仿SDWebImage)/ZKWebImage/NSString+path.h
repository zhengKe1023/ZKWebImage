//
//  NSString+path.h
//  多线程Day3 - (列表异步加载网络图片)
//
//  Created by 郑克哥哥 on 2017/6/23.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (path)

//获取cache文件夹内部文件的全路径
- (NSString *)appendCachePath;

@end
