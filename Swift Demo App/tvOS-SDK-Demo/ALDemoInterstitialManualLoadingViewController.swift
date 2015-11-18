//
//  ALDemoInterstitialManualLoadingViewController.swift
//  tvOS-SDK-Demo
//
//  Created by Thomas So on 11/13/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

class ALDemoInterstitialManualLoadingViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate
{
    var ad: ALAd?
    
    @IBAction func loadInterstitial(sender: AnyObject!)
    {
        self.log("Interstitial loading...")
        ALSdk.shared()!.adService.loadNextAd(ALAdSize.sizeInterstitial(), andNotify: self)
    }
    
    @IBAction func showInterstitial(sender: AnyObject!)
    {
        // Optional: Assign delegates
        ALInterstitialAd.shared().adDisplayDelegate = self
        ALInterstitialAd.shared().adVideoPlaybackDelegate = self
        
        if let ad = self.ad
        {
            ALInterstitialAd.shared().showOver(UIApplication.sharedApplication().keyWindow!, andRender: ad)
        }
    }
    
    // MARK: Ad Load Delegate
    
    func adService(adService: ALAdService, didLoadAd ad: ALAd)
    {
        self.log("Interstitial Loaded")
        
        self.ad = ad
        self.showButton.enabled = true
        self.requestedFocusView = self.showButton
    }
    
    func adService(adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        // Look at ALErrorCodes.h for list of error codes
        self.log("Interstitial failed to load with error code \(code)")
    }
    
    // MARK: Ad Display Delegate
    
    func ad(ad: ALAd, wasDisplayedIn view: UIView)
    {
        self.log("Interstitial Displayed")
    }
    
    func ad(ad: ALAd, wasHiddenIn view: UIView)
    {
        self.log("Interstitial Dismissed")
    }
    
    func ad(ad: ALAd, wasClickedIn view: UIView)
    {
        self.log("Interstitial Clicked")
    }
    
    // MARK: Ad Video Playback Delegate
    
    func videoPlaybackBeganInAd(ad: ALAd)
    {
        self.log("Video Started")
    }
    
    func videoPlaybackEndedInAd(ad: ALAd, atPlaybackPercent percentPlayed: NSNumber, fullyWatched wasFullyWatched: Bool)
    {
        self.log("Video Ended")
    }
}
