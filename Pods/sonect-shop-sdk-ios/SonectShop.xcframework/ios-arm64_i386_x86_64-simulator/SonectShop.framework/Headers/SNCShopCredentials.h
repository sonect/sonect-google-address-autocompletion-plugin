//
//  SNCShopCredentials.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 5.02.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNCShopCredentials : NSObject

/**
 An SDK token.
 */
@property(nonatomic, copy, readonly) NSString* sdkToken;

/**
 A partner's merchant id.
 */
@property(nonatomic, copy, readonly) NSString* merchantId;

/**
 A signature.
 */
@property(nonatomic, copy, readonly) NSString* signature;

/**
 A POS terminal id.
 */
@property(nonatomic, copy, readonly) NSString* deviceId;

/**
 Creates credentials to authorize the SDK.

 @param sdkToken an sdk token.
 @param merchantId  partner's merchant id.
 @param deviceId POS terminal id.

 @return credentials.
 */
- (instancetype)initWithSdkToken:(NSString *)sdkToken
                      merchantId:(NSString *)merchantId
                       signature:(NSString *)signature
                        deviceId:(NSString *)deviceId;

@end

NS_ASSUME_NONNULL_END
