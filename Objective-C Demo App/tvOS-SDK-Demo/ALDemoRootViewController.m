//
//  ALDemoRootViewController.m
//  tvOS-SDK-Demo
//
//  Created by Thomas So on 11/13/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoRootViewController.h"
#import "ALSdk.h"

@implementation ALDemoRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"";
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 340.0f, 100.0f)];
    logo.center = self.navigationController.navigationBar.center;
    logo.image = [UIImage imageNamed: @"NavLogo"];

    // Don't use navigationItem.titleView for sizing purposes
    [self.navigationController.navigationBar addSubview: logo];
    
    [self addFooterLabel];
}

- (void)addFooterLabel
{
    UILabel *footer = [[UILabel alloc] init];
    footer.font = [UIFont systemFontOfSize: 30.0f];
    footer.numberOfLines = 0;
    
    NSString *appVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *sdkVersion = [ALSdk version];
    NSString *sdkKey = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"AppLovinSdkKey"];
    NSString *text = [NSString stringWithFormat: @"App Version: %@\nSDK Version: %@\nLanguage: Objective-C\n\nSDK Key: %@", appVersion, sdkVersion, sdkKey];
    
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.alignment =  NSTextAlignmentCenter;
    style.minimumLineHeight = 20.0f;
    footer.attributedText = [[NSAttributedString alloc] initWithString: text attributes: @{NSParagraphStyleAttributeName : style}];
    
    CGRect frame = footer.frame;
    frame.size.height = [footer sizeThatFits: CGSizeMake(CGRectGetWidth(footer.frame), CGFLOAT_MAX)].height + 60.0f;
    footer.frame = frame;
    self.tableView.tableFooterView = footer;
}

#pragma mark - Collection View Delegate

- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
    [context.previouslyFocusedView viewWithTag: 1].alpha = 0.0f;
    [context.nextFocusedView       viewWithTag: 1].alpha = 1.0f;
}

@end
