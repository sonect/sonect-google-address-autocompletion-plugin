//
//  SNCGoogleShopDetails.h
//  GoogleAddressAutocompletionPlugin
//
//  Created by Ivan Yanakiev on 16.04.20.
//  Copyright © 2020 Ivan Yanakiev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SNCShopDetails, SNCAddressDetails;
@class SNCOpeningHours;

@interface SNCGoogleShopDetails : NSObject <SNCShopDetails>

@property (copy, readonly) NSString *name;
@property (copy, readonly) id <SNCAddressDetails> address;
@property (copy, readonly) SNCOpeningHours *openingHours;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


NS_ASSUME_NONNULL_END
