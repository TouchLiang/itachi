//
//  QYViewController.m
//  LLSDWebImageBeta
//
//  Created by qingyun on 14-10-30.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "QYViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"

#import "QYTestController.h"


@interface QYViewController ()

@property (nonatomic, strong) UISlider *slider;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // slider
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 220, 300, 30)];
//    _slider.minimumValue = 0;
    [_slider setThumbImage:[UIImage imageNamed:@"blackpoint"] forState:UIControlStateNormal];
    [self.view addSubview:_slider];
    
    // 实例化SDImageCache对象
    SDImageCache *imageCache  = [SDImageCache sharedImageCache];
    
    // 实例化SDWebImageDownloader对象
    SDWebImageDownloader *imageDownloader = [SDWebImageDownloader sharedDownloader];
    [imageDownloader downloadImageWithURL:[NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/w%3D2048/sign=ffb8293d8735e5dd902ca2df42fea6ef/810a19d8bc3eb13583807ed4a41ea8d3fd1f441e.jpg"] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@">>>>>%s",__func__);
        NSLog(@"<><><><>%d,%d",receivedSize,expectedSize);
        self.slider.maximumValue = expectedSize;
        self.slider.value = receivedSize;
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        NSLog(@"------%@",error);
//        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 250, 300, 200)];
//        [imageView2 setImage:image];
//        [self.view addSubview:imageView2];
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(10, 250, 300, 200);
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }];
    
	
    // 打印沙盒路径
    NSLog(@"沙盒路径:%@",NSHomeDirectory());
    
    // 设置一个UIImageView展示图片
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 300, 200)];
    NSLog(@"before: image=%@", imageView1.image);
    
    [imageView1 setImageWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/album/crop%3D0%2C110%2C800%2C331%3Bh%3D240/sign=8e4c5faafe039245b5fabb4fbaa488f3/43a7d933c895d143e0c94d4471f082025aaf071d.jpg"] placeholderImage:[UIImage imageNamed:@"0.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        NSLog(@"%d",cacheType);
        
        // SDImageCache 方法调用
//        [imageCache clearDisk];
//        [imageCache cleanDisk];
        NSLog(@"after: image=%@", imageView1.image);
        imageView1.layer.cornerRadius = 20;
        imageView1.layer.masksToBounds = YES;
        NSLog(@"<<<<<<<<<<<<<<");
        

    }];
     

    [self.view addSubview:imageView1];
    NSLog(@">>>>>>>>>>>>>");


    
    // 使用处理图像的类的方法
    

    
    
}

- (void)onButtonTapped:(UIButton *)sender
{
    NSLog(@"You have touched the button");
    QYTestController *testCtrl = [[QYTestController alloc] init];
    testCtrl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:testCtrl animated:YES completion:^{
    }];
    // 清理磁盘
//    [[SDImageCache sharedImageCache] clearDisk];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
