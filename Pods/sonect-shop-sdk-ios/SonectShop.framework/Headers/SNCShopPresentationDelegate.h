//
//  SNCShopPresentationDelegate.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 24.06.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SNCShopPresentationDelegate <NSObject>

@optional

/**
Called on delegate when SonectShop starts dismissing itself.

@param sonectShopViewController sonect shop view controller.
*/
- (void)sonectShopViewControllerWillDismiss:(UIViewController *)sonectShopViewController;

/**
Called on delegate when SonectShop did dismiss itself.

@param sonectShopViewController sonect shop view controller.
*/
- (void)sonectShopViewControllerDidDismiss:(UIViewController *)sonectShopViewController;

@end

NS_ASSUME_NONNULL_END
