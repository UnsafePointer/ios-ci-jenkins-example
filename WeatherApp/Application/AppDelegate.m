//
//  AppDelegate.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/23/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

- (void)setupAppearance;

@end

@implementation AppDelegate
{
}

#pragma mark - Application Life Cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupAppearance];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

#pragma mark - Private Methods

- (void)setupAppearance
{
    [[self window] setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
