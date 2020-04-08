//
//  SNCShopAddress.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 20.01.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNCShopAddress: NSObject <NSSecureCoding>

@property (nonatomic, copy, readonly) NSString *streetName;
@property (nonatomic, copy, readonly) NSString *streetNumber;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *zip;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, readonly) CGFloat latitude;
@property (nonatomic, readonly) CGFloat longitude;

- (instancetype)initWithStreetName:(NSString *)streetName
                      streetNumber:(NSString *)streetNumber
                              city:(NSString *)city
                               zip:(NSString *)zip
                             state:(NSString * _Nullable)state
                          latitude:(CGFloat)latitude
                         longitude:(CGFloat)longitude;

@end

NS_ASSUME_NONNULL_END
