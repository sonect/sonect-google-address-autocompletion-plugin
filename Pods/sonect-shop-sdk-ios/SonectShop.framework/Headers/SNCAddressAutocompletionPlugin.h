//
//  SNCAddressAutocompletionPlugin.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 7.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SNCAddressDetails <NSObject>
@property (nullable, copy, readonly) NSString *country;
@property (nullable, copy, readonly) NSString *countryCode;
@property (nullable, copy, readonly) NSString *streetName;
@property (nullable, copy, readonly) NSString *streetNumber;
@property (nullable, copy, readonly) NSString *city;
@property (nullable, copy, readonly) NSString *zip;
@property (nullable, copy, readonly) NSString *state;
@property (readonly) CGFloat latitude;
@property (readonly) CGFloat longitude;
@end

@protocol SNCAddressPrediction <NSObject>
@property (copy, readonly) NSString *addressId;
@property (copy, readonly) NSString *mainText;
@property (copy, readonly) NSString *secondaryText;
@end

@protocol SNCAddressAutocompletion <NSObject>
@property (readonly) NSArray <id<SNCAddressPrediction>> *predictions;
@end

typedef void(^SNCAddressDetailsHandler)(id<SNCAddressDetails> _Nullable addressDetails, NSError * _Nullable error);
typedef void(^SNCAddressAutocompletionResultHandler)(id<SNCAddressAutocompletion> _Nullable autocompleteAddress, NSError * _Nullable error);
@protocol SNCAddressAutocompletionPlugin <NSObject>

- (void)addressAutocompletionForSearchTerm:(NSString *)searchTerm
                               countryCode:(NSString *)countryCode
                         completionHandler:(SNCAddressAutocompletionResultHandler)compleionHandler;
 
- (void)adressDetailsForAddressId:(NSString *)addressId
                completionHandler:(SNCAddressDetailsHandler)compleionHandler;

@end

NS_ASSUME_NONNULL_END
