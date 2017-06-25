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

@property(nonatomic,strong)NSArray *appList;

@property(nonatomic,strong)NSOperationQueue *queue;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //准备队列
    _queue = [NSOperationQueue new];
    
    //NSString *URLString = @"http://pic.58pic.com/58pic/13/61/00/61a58PICtPr_1024.jpg";
    
   
    
    [self loadData];
    
}

//测试DownloadOperation,点击屏幕随机获取图片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取随机数,进行数据强转 uint32_t --> int类型
    int random = arc4random_uniform((uint32_t)self.appList.count);
    
    //获取随机模型
    appModel *app = self.appList[random];
    
    //获取随机图片的地址,交给DownloadOperation去下载
    //创建自定义操作
    DownloadOperation *op = [DownloadOperation downLoadOperationWithURLString:app.icon finish:^(UIImage *image) {
//        NSLog(@"%@ %@",image,[NSThread currentThread]);
        self.iconImageView.image = image;
    }];
    
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
