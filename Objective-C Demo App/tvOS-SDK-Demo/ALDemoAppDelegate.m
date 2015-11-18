//
//  ALDemoAppDelegate.m
//  tvOS-SDK-Demo
//
//  Created by Thomas on 11/13/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoAppDelegate.h"
#import "ALSdk.h"

@implementation ALDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initializing our SDK at launch is very important as it'll start preloading ads in the background.
    [ALSdk initializeSdk];
    
    [[UINavigationBar appearance] setTranslucent: NO];
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed: 10.0f/255.0f green: 131.0f/255.f blue: 170.0f/255.0f alpha: 1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor: [UIColor whiteColor]];
    
    return YES;
}

@end
