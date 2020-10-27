//
//  SNCGoogleShopDetails.h
//  GoogleAddressAutocompletionPlugin
//
//  Created by Ivan Yanakiev on 16.04.20.
//  Copyright © 2020 Ivan Yanakiev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SNCOpeningHours, UIImage;

//Marking a forward protocol helps fix the problem with imports.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Weverything"
@protocol SNCShopDetails, SNCAddressDetails;
@interface SNCGoogleShopDetails : NSObject <SNCShopDetails>
#pragma clang diagnostic pop

@property (copy, readonly) NSString *name;
@property (copy, readonly) id <SNCAddressDetails> address;
@property (copy, readonly) SNCOpeningHours *openingHours;
@property (copy, readonly) UIImage *shopImage;
@property (nonatomic, copy, readonly) NSArray <NSString*> *types;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary shopImage:(nullable UIImage *)shopImage;

@end


NS_ASSUME_NONNULL_END
