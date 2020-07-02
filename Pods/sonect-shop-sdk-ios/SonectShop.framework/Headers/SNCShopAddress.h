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

@property (nonatomic, copy, readonly) NSString *line1;
@property (nonatomic, copy, nullable, readonly) NSString *line2;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *zip;
@property (nonatomic, copy, nullable, readonly) NSString *state;
@property (nonatomic, readonly) CGFloat latitude;
@property (nonatomic, readonly) CGFloat longitude;

@property (nonatomic, readonly) BOOL isValid;

- (instancetype)initWithLine1:(NSString *)line1
                        line2:(NSString * _Nullable)line2
                         city:(NSString *)city
                          zip:(NSString *)zip
                        state:(NSString * _Nullable)state
                     latitude:(CGFloat)latitude
                    longitude:(CGFloat)longitude;

@end

NS_ASSUME_NONNULL_END
