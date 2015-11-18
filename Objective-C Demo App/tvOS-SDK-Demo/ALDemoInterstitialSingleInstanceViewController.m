//
//  ALDemoInterstitialSingleInstanceViewController.m
//  tvOS-SDK-Demo
//
//  Created by Thomas So on 11/13/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoInterstitialSingleInstanceViewController.h"
#import "ALInterstitialAd.h"

@interface ALDemoInterstitialSingleInstanceViewController ()<ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@property (nonatomic, strong) ALInterstitialAd *interstitial;
@end

@implementation ALDemoInterstitialSingleInstanceViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Single Instance";
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
}

#pragma mark - IB Action Methods

- (IBAction)showInterstitial:(id)sender
{
    if ( [ALInterstitialAd isReadyForDisplay] )
    {
        // Make it a class @property so it doesn't get dealloc'd by ARC
        self.interstitial = [[ALInterstitialAd alloc] initWithSdk: [ALSdk shared]]; // You can also explicitly enter sdk key so: [ALSdk sharedWithKey: @"YOUR KEY"] (i.e. if you have multiple keys)
    
        // Optional: Assign delegates.
        self.interstitial.adLoadDelegate = self;
        self.interstitial.adDisplayDelegate = self;
        self.interstitial.adVideoPlaybackDelegate = self; // This will only ever be used if you have video ads enabled.
        
        [self.interstitial show];
        [self log: @"Interstitial Shown"];
    }
    else
    {
        // Ideally, the SDK preloads ads when you initialize it in application:didFinishLaunchingWithOptions: of the app delegate
        // you can manually load an ad as demonstrated in the ALDemoInterstitialManualLoadingViewController class
        [self log: @"Interstitial not ready for display.\nPlease check SDK key or internet connection."];
    }
}

#pragma mark - Ad Load Delegate

- (void)adService:(nonnull ALAdService *)adService didLoadAd:(nonnull ALAd *)ad
{
    [self log: @"Interstitial Loaded"];
}

- (void) adService:(nonnull ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: [NSString stringWithFormat: @"Interstitial failed to load with error code = %d", code]];
}

#pragma mark - Ad Display Delegate

- (void)ad:(nonnull ALAd *)ad wasDisplayedIn:(nonnull UIView *)view
{
    [self log: @"Interstitial Displayed"];
}

- (void)ad:(nonnull ALAd *)ad wasHiddenIn:(nonnull UIView *)view
{
    [self log: @"Interstitial Dismissed"];
}

- (void)ad:(nonnull ALAd *)ad wasClickedIn:(nonnull UIView *)view
{
    [self log: @"Interstitial Clicked"];
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
