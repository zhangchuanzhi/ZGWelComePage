//
//  ZGWelComeVC.h
//  ZGDemo
//
//  Created by offcn_zcz32036 on 2018/4/24.
//  Copyright © 2018年 cn. All rights reserved.
//
/**

 本框架提供ZGWelcomeIsLaunchDefaultKey, 来判断是否首次启动, 用于以下第一种需求

 两种需求:
 1.应用程序第一次安装app后首次启动进入欢迎页, 第二次启动及app更新后都不需要进入欢迎页.
 NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
 // 通过key值判断是否首次启动app
 if ([userDefault boolForKey:ZGWelcomeIsLaunchDefaultKey] != YES) {
 // 是第一次使用, 进入欢迎页控制器
 ......

 }else{

 // 不是第一次使用, 进入登录控制器或者首页
 ......

 }

 2.应用程序第一次安装app后首次启动以及app更新后首次启动 都进入欢迎页
 // 通过版本号值判断是否首次启动app
 NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
 NSString *curVersion = dict[@"CFBundleShortVersionString"];
 NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"versionKey"];

 if ([curVersion isEqualToString:lastVersion]) {
 // 进入主控制器
 ......

 } else {
 if (curVersion) {
 [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:@"versionKey"];
 [[NSUserDefaults standardUserDefaults] synchronize];
 }
 // 进入欢迎页控制器
 ......

 }

 */
#import <UIKit/UIKit.h>
/// 可通过NSUserDefault取得这个key的bool值, 判断是否第一次启动app,
/// 不等于YES时候表示是第一次启动, 否则不是第一次启动
static NSString *ZGWelcomeIsLaunchDefaultKey = @"isLaunch";
@interface ZGWelComeVC : UIViewController
/// 翻页小圆点, 可自行设置它的参数
@property (nonatomic, weak)UIPageControl *pageControl;
/// "立即体验"按钮, 可自行设置位置及样式参数, 默认是"立即体验"
@property (nonatomic, weak)UIButton *showRootControllerBtn;
- (ZGWelComeVC *)initWithImageNameArray:(NSArray *)imageArr rootViewController:(UIViewController *)rootVC;
@end
