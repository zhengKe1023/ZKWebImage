//
//  WebImageManager.m
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/25.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import "WebImageManager.h"

@interface WebImageManager ()

//队列
@property(nonatomic,strong)NSOperationQueue *queue;

//操作缓存池
@property(nonatomic,strong)NSMutableDictionary *opCachePool;

//图片缓存池
@property(nonatomic,strong)NSMutableDictionary *imageMemCache;

@end

@implementation WebImageManager


/**
 单例设计模式
 */
+ (instancetype)sharedManager{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [self new];
        
        
    });
    
    return instance;
}

//实例化方法
- (instancetype)init{
    
    if(self = [super init]){
        
        
        self.queue = [NSOperationQueue new];
        
        self.opCachePool = [[NSMutableDictionary alloc] init];
        
        self.imageMemCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/**
 参数1:图片地址
 参数2:下载完成的回调
 */
- (void)downloadImageWithURLString:(NSString *)URLString completion:(void (^)(UIImage *))completionBlock{
    
    //在下载图片之前判断是否有缓存
    if ([self checkCache:URLString]) {
        
        if (completionBlock != nil) {
            
            completionBlock([self.imageMemCache objectForKey:URLString]);
            return;
        }
    }
    

    
    //在建立下载之前判断一下下载操作是否存在,如果存在就不要进行重复下载
    if([self.opCachePool objectForKey:URLString] != nil){
        
        return;
    }
    
    
    //获取随机图片的地址,交给DownloadOperation去下载
    //创建自定义操作
    DownloadOperation *op = [DownloadOperation downLoadOperationWithURLString:URLString finish:^(UIImage *image) {
        
        
        //把单例拿到的图片回调控制器
        if(completionBlock != nil){
            
            completionBlock(image);
        }
        
        //实现内存缓存
        if (image != nil) {
            
            [self.imageMemCache setObject:image forKey:URLString];
        }
        
        //图片下载结束后,移除对应的下载操作
        [self.opCachePool removeObjectForKey:URLString];
    }];
    
    //添加操作到缓存池
    [self.opCachePool setObject:op forKey:URLString];
    
    
    //把自定义操作添加到队列
    [self.queue addOperation:op];
    
}

- (BOOL)checkCache:(NSString *)URLString{
    
    //判断是否从内存中加载
    if ([self.imageMemCache objectForKey:URLString]) {
        
        NSLog(@"内存中加载....");
        return YES;
    }
    //判断是否从沙盒中加载
    UIImage *CacheImage = [UIImage imageWithContentsOfFile:[URLString appendCachePath]];
    
    if(CacheImage != nil){
        
        NSLog(@"沙盒中加载...");
        
        [self.imageMemCache setObject:CacheImage forKey:URLString];
        
        return YES;
    }
    
    return NO;
}

- (void)cancelLastOperation:(NSString *)lastURLString{
    
    //取出上一个图片的下载操作,调用cancel方法取消
    DownloadOperation *lastOp = [self.opCachePool objectForKey:lastURLString];
    
    [lastOp cancel];
    
    //取消掉的操作,直接从缓存池中移除
    [self.opCachePool removeObjectForKey:lastURLString];
}
@end
