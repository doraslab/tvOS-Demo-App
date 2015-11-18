//
//  ALDemoBaseViewController.m
//  tvOS-SDK-Demo
//
//  Created by Thomas So on 11/13/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoBaseViewController.h"
#import "ALDebugLog.h"

@implementation ALDemoBaseViewController

- (UIView *)preferredFocusedView
{
    return self.requestedFocusView;
}

- (void)setRequestedFocusView:(UIView *)requestedFocusView
{
    _requestedFocusView = requestedFocusView;
    [self setNeedsFocusUpdate];
}

#pragma mark - Logging

- (void)log:(nonnull NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ( self.adStatusLabel )
        {
            self.adStatusLabel.text = message;
        }
        ALLog(@"[%@] : %@", NSStringFromClass([self class]), message);        
    });
}

@end
