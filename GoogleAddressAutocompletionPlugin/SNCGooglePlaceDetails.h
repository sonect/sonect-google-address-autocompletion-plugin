//
//  SNCGooglePlaceDetails.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 3.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Weverything"
@protocol SNCAddressDetails;
@interface SNCGooglePlaceDetails : NSObject <SNCAddressDetails>
#pragma clang diagnostic pop

@property (nonatomic, copy, nullable, readonly) NSString *country;
@property (nonatomic, copy, nullable, readonly) NSString *countryCode;
@property (nonatomic, copy, nullable, readonly) NSString *streetName;
@property (nonatomic, copy, nullable, readonly) NSString *streetNumber;
@property (nonatomic, copy, nullable, readonly) NSString *city;
@property (nonatomic, copy, nullable, readonly) NSString *zip;
@property (nonatomic, copy, nullable, readonly) NSString *state;
@property (nonatomic, readonly) CGFloat latitude;
@property (nonatomic, readonly) CGFloat longitude;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
