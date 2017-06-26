//
//  NSString+path.m
//  多线程Day3 - (列表异步加载网络图片)
//
//  Created by 郑克哥哥 on 2017/6/23.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

- (NSString *)appendCachePath{
    
    //cache文件路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    //获取文件缓存名字(哪个字符串对象调用该方法,那么self就是哪个字符对象)
    NSString *name = [self lastPathComponent];
    
    //cache文件路径和文件缓存名字name拼接文件缓存的全路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:name];
    
    //返回文件缓存全路径
    return filePath;
}
@end
