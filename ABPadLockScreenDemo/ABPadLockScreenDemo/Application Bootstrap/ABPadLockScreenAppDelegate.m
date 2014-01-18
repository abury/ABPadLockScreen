//
//  ABPadLockScreenAppDelegate.m
//  ABPadLockScreen
//
//  Created by Aron Bury on 9/09/11.
//  Copyright 2011 Aron's IT Consultancy. All rights reserved.
//

#import "ABPadLockScreenAppDelegate.h"
#import "ExampleViewController.h"

@implementation ABPadLockScreenAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ExampleViewController *YVC = [[ExampleViewController alloc] init];
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:YVC];
    self.window.rootViewController = navCon;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end