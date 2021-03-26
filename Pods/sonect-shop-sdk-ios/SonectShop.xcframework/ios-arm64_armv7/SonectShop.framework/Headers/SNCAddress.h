//
//  SNCAddress.h
//  Sonect
//
//  Created by Marko Hlebar on 13/07/2020.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNCModel.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNCAddress : NSObject <SNCModel, NSSecureCoding>

@property (nonatomic, copy, readonly) NSString *line1;
@property (nonatomic, copy, nullable, readonly) NSString *line2;
@property (nonatomic, copy, nullable, readonly) NSString *streetNumber;
@property (nonatomic, copy, nullable, readonly) NSString *streetName;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *formattedAddress;
@property (nonatomic, copy, readonly) NSString *zip;
@property (nonatomic, copy, nullable, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) NSString *countryCode;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinates;

@property (nonatomic, readonly) BOOL isValid;

- (instancetype)initWithLine1:(NSString *)line1
                        line2:(NSString * _Nullable)line2
                         city:(NSString *)city
                          zip:(NSString *)zip
                        state:(NSString * _Nullable)state
                  countryCode:(NSString *)countryCode
                  coordinates:(CLLocationCoordinate2D)coordinates;

- (instancetype)initWithLine1:(NSString *)line1
                        line2:(NSString * _Nullable)line2
                         city:(NSString *)city
                          zip:(NSString *)zip
                        state:(NSString * _Nullable)state
                      country:(NSString *)country
                  countryCode:(NSString *)countryCode
             formattedAddress:(NSString *)formattedAddress
                  coordinates:(CLLocationCoordinate2D)coordinates;

+ (instancetype)addressWithLine1:(NSString *)line1
                           line2:(NSString * _Nullable)line2
                             zip:(NSString *)zip
                            city:(NSString *)city
                     countryCode:(NSString *)countryCode;

- (NSDictionary *)toDictionary;

@end

@protocol SNCAddressDetails;
@interface SNCAddress (Autocompletion)
+ (instancetype)addressWithAutocompletedAddress:(id <SNCAddressDetails>) autocompletedAddress;
@end

NS_ASSUME_NONNULL_END
