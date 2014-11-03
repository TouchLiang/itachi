//
//  QYTempController.m
//  LLSDWebImageBeta
//
//  Created by liangfeitao on 14-11-1.
//  Copyright (c) 2014年 liangfeitao. All rights reserved.
//

#import "QYTempController.h"
#import "UIButton+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImagePrefetcher.h"
#import "SDImageCache.h"
#import <AudioToolbox/AudioToolbox.h>

@interface QYTempController ()<SDWebImageManagerDelegate>

@end

@implementation QYTempController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark SDWebImageManagerDelegate
- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL
{
//    NSLog(@"%@", NSStringFromCGSize(image.size));
//    NSData *imageDate = UIImageJPEGRepresentation(image,  .1f);
//    UIImage *tempImg = [UIImage imageWithData:imageDate];
//        NSLog(@"%@", NSStringFromCGSize(tempImg.size));
    
    
    
    // 对图片进行操作
    CGSize sizeTemp = CGSizeMake(image.size.width/ 2, image.size.height/ 2);
    UIGraphicsBeginImageContext(sizeTemp);
    [image drawInRect:CGRectMake(0, 0, sizeTemp.width, sizeTemp.height)];
    UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  temp;
    
    
//    return tempImg;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SDImageCache sharedImageCache] clearDisk];
    // 实例化一个SDWebImageManager对象 并设置代理
    SDWebImageManager *imageManager = [SDWebImageManager sharedManager];
    
    imageManager.delegate = self;
    
    [self setupAbutton];
    [self setupImageView];
    
}

- (void)setupAbutton
{
    CGFloat buttonTestW = 100;
    CGFloat buttonTestH = 40;
    CGFloat buttonTestX = (320 - 100)/2;
    CGFloat buttonTestY = self.view.bounds.size.height * 0.8;
    UIButton *buttonTest = [[UIButton alloc] initWithFrame:CGRectMake(buttonTestX, buttonTestY, buttonTestW, buttonTestH)];
    [buttonTest setBackgroundImageWithURL:[NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/gxtcjsnjqqq.jpg"] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"e850352ac65c1038d0eb27cbb0119313b07e8926"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    }];
    [buttonTest addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonTest];
}

- (void)setupImageView
{
    UIImageView *imageViewTemp = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 300, 200)];
    [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/dmhzwlufei.jpg"] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        NSLog(@"The manager downloading error%@",error);
        [imageViewTemp setImage:image];
    }];
    
    [self.view addSubview:imageViewTemp];
}

- (void)buttonTapped:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
