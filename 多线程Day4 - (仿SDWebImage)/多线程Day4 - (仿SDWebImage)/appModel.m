//
//  appModel.m
//  多线程Day3 - (列表异步加载网络图片)
//
//  Created by 郑克哥哥 on 2017/6/22.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import "appModel.h"

@implementation appModel
- (NSString *)description{
    
    return [NSString stringWithFormat:@"%@ %@ %@",self.name,self.download,self.icon];
}
@end
