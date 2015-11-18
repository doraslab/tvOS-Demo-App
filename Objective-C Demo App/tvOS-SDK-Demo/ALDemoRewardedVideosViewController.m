//
//  ALDemoRewardedVideosViewController.m
//  tvOS-SDK-Demo
//
//  Created by Thomas So on 11/13/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoRewardedVideosViewController.h"
#import "ALIncentivizedInterstitialAd.h"

@interface ALDemoRewardedVideosViewController ()<ALAdLoadDelegate, ALAdRewardDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@end

@implementation ALDemoRewardedVideosViewController

//
// IMPORTANT: Before integrating Rewarded Video into your application, please be sure it is turned 'ON' in the Manage Apps section.
//

#pragma mark - IB Action Methods

- (IBAction)showRewardedVideo:(id)sender
{
    // Unlike interstitials, you need to preload each rewarded video before it can be displayed.
    if ([ALIncentivizedInterstitialAd isReadyForDisplay])
    {
        // Optional: Assign delegates
        [ALIncentivizedInterstitialAd shared].adDisplayDelegate = self;
        [ALIncentivizedInterstitialAd shared].adVideoPlaybackDelegate = self;
        
        [ALIncentivizedInterstitialAd showAndNotify: self];
    }
    else
    {
        // Ideally, the SDK preloads ads when you initialize it in application:didFinishLaunchingWithOptions: of the app delegate
        [self preloadRewardedVideo: nil];
    }
}

// Unlike interstitials, you need to preload each rewarded video before it can be displayed.
- (IBAction)preloadRewardedVideo:(id)sender
{
    [self log: @"Preloading..."];
    [[ALIncentivizedInterstitialAd shared] preloadAndNotify: self];
}

#pragma mark - Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self log: @"Rewarded video loaded"];
    
    self.showButton.enabled = YES;
    [self setRequestedFocusView: self.showButton];
}

- (void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    [self log: [NSString stringWithFormat: @"Rewarded video failed to load with error code %d", code]];
}

#pragma mark - Ad Reward Delegate

- (void)rewardValidationRequestForAd:(ALAd *)ad didSucceedWithResponse:(nonnull NSDictionary *)response
{
    /* AppLovin servers validated the reward. Refresh user balance from your server.  We will also pass the number of coins
     awarded and the name of the currency.  However, ideally, you should verify this with your server before granting it. */
    
    // i.e. - "Coins", "Gold", whatever you set in the dashboard.
    NSString *currencyName = [response objectForKey: @"currency"];
    
    // For example, "5" or "5.00" if you've specified an amount in the UI.
    NSString *amountGivenString = [response objectForKey: @"amount"];
    NSNumber *amountGiven = [NSNumber numberWithFloat: [amountGivenString floatValue]];
    
    // Do something with this information.
    // [MYCurrencyManagerClass updateUserCurrency: currencyName withChange: amountGiven];
    [self log: [NSString stringWithFormat: @"Rewarded %@ %@", amountGiven, currencyName]];
    
    // By default we'll show a UIAlertView informing your user of the currency & amount earned.
    // If you don't want this, you can turn it off in the Manage Apps UI.
}

- (void)rewardValidationRequestForAd:(ALAd *)ad didFailWithError:(NSInteger)responseCode
{
    if (responseCode == kALErrorCodeIncentivizedUserClosedVideo)
    {
        // Your user exited the video prematurely. It's up to you if you'd still like to grant
        // a reward in this case. Most developers choose not to. Note that this case can occur
        // after a reward was initially granted (since reward validation happens as soon as a
        // video is launched).
    }
    else if (responseCode == kALErrorCodeIncentivizedValidationNetworkTimeout || responseCode == kALErrorCodeIncentivizedUnknownServerError)
    {
        // Some server issue happened here. Don't grant a reward. By default we'll show the user
        // a UIAlertView telling them to try again later, but you can change this in the
        // Manage Apps UI.
    }
    else if (responseCode == kALErrorCodeIncentiviziedAdNotPreloaded)
    {
        // Indicates that the developer called for a rewarded video before one was available.
    }
}

- (void)rewardValidationRequestForAd:(ALAd *)ad didExceedQuotaWithResponse:(NSDictionary *)response
{
    // Your user has already earned the max amount you allowed for the day at this point, so
    // don't give them any more money. By default we'll show them a UIAlertView explaining this,
    // though you can change that from the Manage Apps UI.
}

- (void)rewardValidationRequestForAd:(ALAd *)ad wasRejectedWithResponse:(NSDictionary *)response
{
    // Your user couldn't be granted a reward for this view. This could happen if you've blacklisted
    // them, for example. Don't grant them any currency. By default we'll show them a UIAlertView explaining this,
    // though you can change that from the Manage Apps UI.
}

#pragma mark - Ad Display Delegate

- (void)ad:(nonnull ALAd *)ad wasDisplayedIn:(nonnull UIView *)view
{
    [self log: @"Ad Displayed"];
}

- (void)ad:(nonnull ALAd *)ad wasHiddenIn:(nonnull UIView *)view
{
    [self log: @"Ad Dismissed"];
}

- (void)ad:(nonnull ALAd *)ad wasClickedIn:(nonnull UIView *)view
{
    [self log: @"Ad Clicked"];
}

#pragma mark - Ad Video Playback Delegate

- (void)videoPlaybackBeganInAd:(nonnull ALAd *)ad
{
    [self log: @"Video Started"];
}

- (void)videoPlaybackEndedInAd:(nonnull ALAd *)ad atPlaybackPercent:(nonnull NSNumber *)percentPlayed fullyWatched:(BOOL)wasFullyWatched
{
    [self log: @"Video Ended"];
}

@end
