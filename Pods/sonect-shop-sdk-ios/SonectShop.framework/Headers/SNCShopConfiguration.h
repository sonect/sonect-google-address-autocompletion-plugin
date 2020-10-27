//
//  SNCShopConfiguration.h
//  SonectShop
//
//  Created by Marko Hlebar on 13/02/2020.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNCShopConfiguration : NSObject

/**
 Set allowed country codes.
 Example: would be US and Switzerland
 @[@1, @41]
 */
@property (nonatomic, copy, readonly) NSArray <NSNumber *> *allowedCountryCodes;

/**
 The user's preferred currency i.e. "CHF" for Swiss Francs
 */
@property (nonatomic, nullable, copy, readonly) NSString* currency;

/**
 The user's maximum amount for handing out cash on the shop.
 */
@property (nonatomic, nullable, copy, readonly) NSNumber *maximumCashHandoutAmount;

/**
 Initializes the configuration with a designated configuration plist file.

 @param filePath a file path.
 @return a configuration.
 */
- (instancetype)initWithContentsOfFile:(NSString *)filePath;

/**
 Initializes the configuration by loading the SonectConfiguration.plist

 @return a configuration.
 */
+ (instancetype)defaultConfiguration;

+ (instancetype) new  NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
