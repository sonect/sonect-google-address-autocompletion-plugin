//
//  SNCSonectShop.h
//  SonectSDK
//
//  Created by Ivan Yanakiev on 8.01.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SNCShopConfiguration, SNCShopCredentials, UIViewController;
@protocol SNCScanCodePlugin, SNCKycProviderPlugin, SNCShopOnboardingDataSource, SNCAddressAutocompletionPlugin;

@interface SNCSonectShop : NSObject

/**
 The current configuration that is passed through the presentWithCredentials: method.
 */
@property (class, nullable, readonly) SNCShopConfiguration *currentConfiguration;

/**
 The current credentials that are passed through the presentWithCredentials: method.
 */
@property (class, nullable, readonly) SNCShopCredentials *currentCredentials;

/**
 The plugin to be used when scanning barcodes / QR codes.
*/
@property (class, nullable) id <SNCScanCodePlugin> scanCodePlugin;

/**
 The plugin to be used when getting customer KYC data.
*/
@property (class, nullable) id <SNCKycProviderPlugin> kycProviderPlugin;

/**
 The plugin to be used for getting address autocompletion.
*/
@property (class, nullable) id <SNCAddressAutocompletionPlugin> addressAutocompletionPlugin;

/**
 The data source for shop onboarding.
*/
@property (class, nullable) id <SNCShopOnboardingDataSource> onboardingDataSource;

/**
 Presents the Sonect Shop View Controller on the presenting view controller, with credentials and
 configuration provided by the client.
 The presented view controller is wrapped in a navigation controller.

 @param credentials the credentials.
 @param configuration the configuration.
 @param presentingViewController a presenting view controller.
 */
+ (void)presentWithCredentials:(SNCShopCredentials *)credentials
                 configuration:(SNCShopConfiguration *)configuration
      presentingViewController:(UIViewController *)presentingViewController;

@end

NS_ASSUME_NONNULL_END
