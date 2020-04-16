//
//  SNCGoogleAutocompleteAddresses.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 3.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Weverything"
@protocol SNCAddressPrediction, SNCAddressAutocompletion;
@interface SNCGoogleAddressPrediction : NSObject <SNCAddressPrediction>
#pragma clang diagnostic pop

@property (nonatomic, copy, readonly) NSString *addressId;
@property (nonatomic, copy, readonly) NSString *mainText;
@property (nonatomic, copy, readonly) NSString *secondaryText;
@property (nonatomic, copy, readonly) NSArray <NSString*> *types;
@property (nonatomic, copy, readonly) NSString *reference;
@property (nonatomic, copy, readonly) NSString *addressDescription;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Weverything"
@interface SNCGoogleAutocompleteAddresses : NSObject <SNCAddressAutocompletion>
#pragma clang diagnostic pop

@property (readonly) NSArray <id<SNCAddressPrediction>> *predictions;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
