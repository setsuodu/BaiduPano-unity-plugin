//
//  PanoControlViewController.m
//  PanoramaViewDemo
//
//  Created by baidu on 15/4/10.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "PanoControlViewController.h"
#import <BaiduPanoSDK/BaiduPanoramaView.h>

@interface PanoControlViewController ()<BaiduPanoramaViewDelegate>

@property(strong, nonatomic) BaiduPanoramaView  *panoramaView;

@end

@implementation PanoControlViewController

UIView * unityView = nil; //内存指针

- (void)customPano:(double)latitude View:(double)longitude
{
    //NSLog(@"==>> customPanoView");
    
    //CGRect frame = CGRectMake(0, 0, 360, 240);
    CGRect frame = self.view.bounds; //全屏
    
    // key 为在百度LBS平台上统一申请的接入密钥ak 字符串
    self.panoramaView = [[BaiduPanoramaView alloc] initWithFrame:frame key:@"6nqO5DGg2RspziRZAQoPnUv2WaDD8En8"];
    
    // 为全景设定一个代理
    self.panoramaView.delegate = self;
    
    if(self.panoramaView == nil) {
        NSLog(@"panoramaView == nil");
    }
    
    //[self.view addSubview:self.panoramaView];
    unityView = UnityGetGLView();
    [unityView addSubview:self.panoramaView];
    
    CGRect cbtnFrame = CGRectMake(0, 100, 50, 30);
    UIButton *testBtn = [self createButton:@"返回" target:@selector(onTestBtn) frame:cbtnFrame];
    [self.panoramaView addSubview:testBtn];
    
    // 设定全景的清晰度， 默认为middle
    [self.panoramaView setPanoramaImageLevel:ImageDefinitionHigh];
    
    // 设定全景的pid， 这是指定显示某地的全景，也可以通过百度坐标进行显示全景
    //[self.panoramaView setPanoramaWithLon:116.40391285827147 lat:39.91403075654526];
    [self.panoramaView setPanoramaWithLon:longitude lat:latitude];
}

- (UIButton *)createButton:(NSString *)title target:(SEL)selector frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ) {
        [button setBackgroundColor:[UIColor whiteColor]];
    } else {
        [button setBackgroundColor:[UIColor clearColor]];
    }
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)onTestBtn {
    //[self.panoramaView setCustomOverlayAnchor:@"54321" x:0.5f y:0.1f];
    NSLog(@"this is a button");
    [self.panoramaView removeFromSuperview];
}

@end

#ifdef __cplusplus
extern "C" {
#endif
    
    PanoControlViewController * controller = nil;
    
    // ..
    void InitPano(double lat, double lon)
    {
        if(controller == nil) {
            controller = [[PanoControlViewController alloc] init];
        }
        
        NSLog(@"from unity -> (%f,%f)", lat, lon);
        
        controller.title = @"全景图控制";
        [controller customPano:lat View:lon];
    }
    
#ifdef __cplusplus
}
#endif

