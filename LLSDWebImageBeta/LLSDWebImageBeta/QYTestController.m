//
//  QYTestController.m
//  LLSDWebImageBeta
//
//  Created by qingyun on 14-10-31.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import "QYTestController.h"
#import "SDWebImageManager.h"
#import "UIButton+WebCache.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "SDWebImagePrefetcher.h"

@interface QYTestController ()<SDWebImageManagerDelegate>

@end

@implementation QYTestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// SDWebImageManager代理方法，通过URL改变图片
- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL
{
    NSLog(@"%@,%@",image,imageURL);
    UIImage *image2 = [UIImage imageNamed:@"qclbjn-9562203589"];
    NSURL *url = [NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/gxdwlddtnbd.jpg"];
    imageURL = url;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {

    }];
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // SDWebImagePrefetcher 方法

    
    // 实例化一个SDWebImageCache对象
//    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    
    // 实例化一个SDWebImageManager对象
    SDWebImageManager *imageManager = [SDWebImageManager sharedManager];
//    imageManager.imageDownloader.maxConcurrentDownloads = 0;

//    imageManager.delegate = self;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 300, 200)];
    
//    UIImage *managerImage = [imageManager downloadWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/ca1349540923dd54fb466161d309b3de9c824886.jpg"] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {}];
    [imageManager downloadWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/ca1349540923dd54fb466161d309b3de9c824886.jpg"] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        NSLog(@"currentdowncount:%d",[SDWebImageDownloader sharedDownloader].currentDownloadCount);
        NSLog(@"receivedSize:%d",receivedSize);
    
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//        - (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL;

        
        [button setImage:image forState:UIControlStateNormal];
        NSLog(@"currentdowncount:%d",[SDWebImageDownloader sharedDownloader].currentDownloadCount);
//        [[SDImageCache sharedImageCache] storeImage:image forKey:@"buttonImage"];
        [[SDImageCache sharedImageCache] storeImage:image forKey:@"buttonImage" toDisk:YES];
    }];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 300, 200)];
//    [button setImageWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/ca1349540923dd54fb466161d309b3de9c824886.jpg"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGFloat buttonW = 100;
    CGFloat buttonH = 40;
    CGFloat buttonX = (self.view.bounds.size.width - buttonW)/2;
    CGFloat buttonY = self.view.bounds.size.height*0.8;
    
    UIButton *buttonBeta = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    [buttonBeta setBackgroundImageWithURL:[NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/syfj-12069188552.jpg"] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"qclbjn-9562203589"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
    
    /**
     *  button 添加方法
     */
//    [buttonBeta addTarget:self action:@selector(buttonBetaTapped:) forControlEvents:UIControlEventTouchUpInside];
    [buttonBeta addTarget:self action:@selector(buttonBetaDraged:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBeta];
    
}

- (void)buttonBetaDraged:(UIButton *)sender
{
    NSLog(@"You have draged the button");
    QYTempController *tempCtrl = [[QYTempController alloc] init];
    tempCtrl.modalTransitionStyle = UIModalPresentationFormSheet;
    [self presentViewController:tempCtrl animated:YES completion:^{
    }];
}

- (void)buttonBetaTapped:(UIButton *)sender
{
//    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
//    [[SDImageCache sharedImageCache] removeImageForKey:@"buttonImage"fromDisk:YES];
    [[SDImageCache sharedImageCache] clearMemory];
    NSLog(@"%d张图片",[[SDImageCache sharedImageCache] getDiskCount]);
    NSLog(@"%d字节",[[SDImageCache sharedImageCache] getSize]);
}

- (void)onButtonTouched:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
