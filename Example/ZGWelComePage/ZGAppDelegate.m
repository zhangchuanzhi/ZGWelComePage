//
//  ZGAppDelegate.m
//  ZGWelComePage
//
//  Created by zhangchuanzhi on 04/24/2018.
//  Copyright (c) 2018 zhangchuanzhi. All rights reserved.
//

#import "ZGAppDelegate.h"
#import "ZGWelComeVC.h"
@implementation ZGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UIViewController *homeVC = [[UIViewController alloc] init];
    homeVC.view.backgroundColor = [UIColor redColor];
    // 通过版本号值判断是否首次启动app
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    NSString *curVersion = dict[@"CFBundleShortVersionString"];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"versionKey"];

    if ([curVersion isEqualToString:lastVersion]) {
        // 进入主控制器
        self.window.rootViewController = homeVC;

    } else {
        if (curVersion) {
            [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:@"versionKey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        // 进入欢迎页控制器
        NSArray *imgArr = @[@"welcome1", @"welcome2", @"welcome3"];
        ZGWelComeVC *welcomeVC = [[ZGWelComeVC alloc] initWithImageNameArray:imgArr rootViewController:homeVC];
        self.window.rootViewController = welcomeVC;

    }
    //    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //
    //    UIViewController *homeVC = [[UIViewController alloc] init];
    //    homeVC.view.backgroundColor = [UIColor redColor];
    //
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    // 通过取SHWelcomeIsLaunchDefaultKey的值来判断是否首次启动app
    //    if ([defaults boolForKey:SHWelcomeIsLaunchDefaultKey] != YES) {
    //        // 是第一次启动
    //        NSArray *imgArr = @[@"welcome1", @"welcome2", @"welcome3"];
    //        ZGWelComeVC *welcomeVC = [[ZGWelComeVC alloc] initWithImageNameArray:imgArr rootViewController:homeVC];
    //        self.window.rootViewController = welcomeVC;
    //    }else{
    //        // 不是第一次启动
    //        self.window.rootViewController = homeVC;
    //    }
    //
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
