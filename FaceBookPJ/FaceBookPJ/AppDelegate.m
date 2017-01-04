//
//  AppDelegate.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/11/25.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "AppDelegate.h"

#import "SHLOLAllHeroViewC.h"
#import "SHNavigationViewC.h"

#import "WindowWithStatusBarUnderlay.h"

#import "Chameleon.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration>  _Nonnull configuration) {
//        configuration.applicationId = @"app";
//        configuration.server = @"http://localhost:1337/parse";
//    }]];
    
    self.window = [[WindowWithStatusBarUnderlay alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    
    _window.rootViewController = [self setupTabBarController];
    
    // Nav Bar appearance
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor flatBlueColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    // iOS8 hides the status bar in landscape orientation, this forces the status bar hidden status to NO
    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [Chameleon setGlobalThemeUsingPrimaryColor:FlatCoffee withSecondaryColor:FlatGray andContentStyle:UIContentStyleContrast];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(UITabBarController *)setupTabBarController{
//    SHTimelineViewC *asdkHomeFeedVC = [[SHTimelineViewC alloc]init];
    SHLOLAllHeroViewC *asdkVC = [[SHLOLAllHeroViewC alloc]init];
    SHNavigationViewC *asdkHomeFeedNavCtrl  = [[SHNavigationViewC alloc] initWithRootViewController:asdkVC];
    asdkHomeFeedNavCtrl.navigationBar.translucent = NO;
    asdkHomeFeedNavCtrl.tabBarItem               = [[UITabBarItem alloc] initWithTitle:@"ASDK" image:[UIImage imageNamed:@"home"] tag:0];
//    asdkHomeFeedNavCtrl.hidesBarsOnSwipe         = YES;
    
    UITabBarController *tabBarController        = [[UITabBarController alloc] init];
    tabBarController.viewControllers             = @[asdkHomeFeedNavCtrl];
    tabBarController.selectedViewController      = asdkHomeFeedNavCtrl;
    tabBarController.delegate                    = self;
    tabBarController.tabBar.translucent = NO;
    return tabBarController;
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
