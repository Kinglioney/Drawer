//
//  AppDelegate.m
//  侧滑抽屉效果
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "LeftViewController.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController *drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //1、初始化控制器
    UIViewController *centerVC = [[ViewController alloc]init];
    UIViewController *leftVC = [[LeftViewController alloc]init];

    //2、初始化导航控制器
    UINavigationController *centerNvaVC = [[UINavigationController alloc]initWithRootViewController:centerVC];
    UINavigationController *leftNvaVC = [[UINavigationController alloc]initWithRootViewController:leftVC];


    //3、使用MMDrawerController
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:centerNvaVC leftDrawerViewController:leftNvaVC rightDrawerViewController:nil];

    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = 200.0;
    //self.drawerController.maximumRightDrawerWidth = 200.0;
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    [[MMExampleDrawerVisualStateManager sharedManager]setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    //6、初始化窗口、设置根控制器、显示窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
