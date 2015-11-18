//
//  ALDemoBaseViewController.h
//  tvOS-SDK-Demo
//
//  Created by Thomas So on 11/13/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALDemoBaseViewController : UIViewController

@property (nonatomic, strong, nonnull) IBOutlet UILabel *adStatusLabel;
@property (nonatomic, strong, nonnull) IBOutlet UIButton *loadButton;
@property (nonatomic, strong, nonnull) IBOutlet UIButton *showButton;

@property (nonatomic,   weak, nullable) IBOutlet UIView *requestedFocusView;

- (void)log:(nonnull NSString *)message;

@end
