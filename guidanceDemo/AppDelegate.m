//
//  AppDelegate.m
//  guidanceDemo
//
//  Created by 露萍沈 on 16/4/7.
//  Copyright © 2016年 SLP. All rights reserved.
//

#import "AppDelegate.h"
#import "TJGuideViewController.h"
#import "ViewController.h"

#define FIRST_LAUNCH_KEY  @"firstLaunch"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:FIRST_LAUNCH_KEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FIRST_LAUNCH_KEY];
        
        //如果是第一次，使用guideVC作为根视图
        TJGuideViewController *guideVC = [[TJGuideViewController alloc] init];
        self.window.rootViewController = guideVC;
    } else {
        
        //TODO 如果不是第一次就切换到首页视图
        UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *VC = [SB instantiateViewControllerWithIdentifier:@"ViewController"];
        self.window.rootViewController = VC;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)loadMainView
{
    //TODO 将首页加载到window上面来
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *VC = [SB instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.window addSubview:VC.view];
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
