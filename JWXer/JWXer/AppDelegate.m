//
//  AppDelegate.m
//  JWXer
//
//  Created by scjy on 16/1/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "AppDelegate.h"
#import "JWHomeViewController.h"
#import "JWMineViewController.h"
#import "JWCourseViewController.h"
#import "JWUserInfo.h"

#import "UIColor+HexColor.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    JWUserInfo * userInfo = [JWUserInfo shareUserInfo];
    userInfo = [userInfo getInfo];
    NSLog(@"userID=%@",userInfo.userID);
    
    JWHomeViewController * homeViewController = [[JWHomeViewController alloc]init];
//    取消渲染色
//    UIImage * homeSelectImage = [UIImage imageNamed:@"shouye2"];
//    homeSelectImage = [homeSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"shouye"] selectedImage:[UIImage imageNamed:@"shouye2"]];
    
    JWCourseViewController * courseViewController = [[JWCourseViewController alloc]init];
    courseViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"课程" image:[UIImage imageNamed:@"kecheng"] selectedImage:[UIImage imageNamed:@"kecheng2"]];
    
    JWMineViewController * mineViewController = [[JWMineViewController alloc]init];
    mineViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"wode"] selectedImage:[UIImage imageNamed:@"wode2"]];
    
    
    
    UITabBarController * jwTabViewController = [[UITabBarController alloc]init];
    
    jwTabViewController.tabBar.barTintColor = [UIColor colorWithHexString:@"#ffffff"];
    
    jwTabViewController.viewControllers = @[homeViewController,courseViewController,mineViewController];
    jwTabViewController.delegate = self;
    
    jwTabViewController.selectedIndex = 2;
    
    self.window.rootViewController = jwTabViewController;
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 0) {
        JWHomeViewController * homeVC = (JWHomeViewController *)viewController;
        homeVC.getSelectedCount = ^(NSString * selectCount){
            tabBarController.selectedIndex = [selectCount integerValue];
            };
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
