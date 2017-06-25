//
//  ViewController.m
//  多线程Day4 - (仿SDWebImage)
//
//  Created by 郑克哥哥 on 2017/6/23.
//  Copyright © 2017年 郑克哥哥. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "appModel.h"

@interface ViewController ()

//模型数组
@property(nonatomic,strong)NSArray *appList;

//队列
@property(nonatomic,strong)NSOperationQueue *queue;

//图片控件
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

//操作缓存池
@property(nonatomic,strong)NSMutableDictionary *opCachePool;

//记录上一个图片的地址
@property(nonatomic,copy)NSString *lastURLString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实例化队列
    _queue = [NSOperationQueue new];
    
    //NSString *URLString = @"http://pic.58pic.com/58pic/13/61/00/61a58PICtPr_1024.jpg";
    
   //实例化操作缓存池
    _opCachePool = [[NSMutableDictionary alloc] init];
    
    [self loadData];
    
}

//测试DownloadOperation,点击屏幕随机获取图片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取随机数,进行数据强转 uint32_t --> int类型
    int random = arc4random_uniform((uint32_t)self.appList.count);
    
    //获取随机模型
    appModel *app = self.appList[random];
    
    //在进入下载前,判断连续传入的地址是否一样,如果不一样,就把前一个下载操作取消
    if (![app.icon isEqualToString:_lastURLString] && _lastURLString != nil) {
        
        //取出上一个图片的下载操作,调用cancel方法取消
        DownloadOperation *lastOp = [self.opCachePool objectForKey:_lastURLString];
        
        [lastOp cancel];
        
        //取消掉的操作,直接从缓存池中移除
        [self.opCachePool removeObjectForKey:_lastURLString];
    }
    
    
    //记录上次图片地址
    _lastURLString = app.icon;
    
    //获取随机图片的地址,交给DownloadOperation去下载
    //创建自定义操作
    DownloadOperation *op = [DownloadOperation downLoadOperationWithURLString:app.icon finish:^(UIImage *image) {

        self.iconImageView.image = image;
        
        //图片下载结束后,移除对应的下载操作
        [self.opCachePool removeObjectForKey:app.icon];
    }];
    
    //添加操作到缓存池
    [self.opCachePool setObject:op forKey:app.icon];
    
    
    //把自定义操作添加到队列
    [self.queue addOperation:op];
    
}

- (void)loadData{
    
    //获取JSON数据:测试DownloadOperation数据的来源
    NSString *URLString = @"https://raw.githubusercontent.com/zhengKe1023/zhengke/master/apps.json";
    
    
    [[AFHTTPSessionManager manager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //AFN会自动的对JSON数据进行反序列化:responseObject就是JSON反序列化完成后的结果

        
        NSArray *dictArr = responseObject;
        
        self.appList =  [NSArray yy_modelArrayWithClass:[appModel class] json:dictArr];
        
        NSLog(@"%@",self.appList);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}




@end
