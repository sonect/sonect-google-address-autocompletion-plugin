//
//  SNCAddressAutocompletionPlugin.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 7.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SonectDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class SNCOpeningHours;

SNC_SWIFT_NAME(AddressDetails)
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

SNC_SWIFT_NAME(AddressPrediction)
@protocol SNCAddressPrediction <NSObject>
@property (copy, readonly) NSString *addressId;
@property (copy, readonly) NSString *mainText;
@property (copy, readonly) NSString *secondaryText;
@end

SNC_SWIFT_NAME(ShopDetails)
@protocol SNCShopDetails <NSObject>
@property (copy, readonly) NSString *name;
@property (copy, readonly) id <SNCAddressDetails> address;
@property (copy, readonly) SNCOpeningHours *openingHours;
@property (copy, readonly) NSArray <NSString*> *types;
@property (copy, nullable, readonly) UIImage *shopImage;
@property (nonatomic, nullable, copy) NSString *vicinity;
@property (nonatomic, copy) NSString *placeId;
@property (nonatomic, copy, nullable) NSString *photoReference;
@end

SNC_SWIFT_NAME(ShopCandidate)
@protocol SNCShopCandidate <NSObject>
@property (copy, readonly) NSString *shopId;
@property (copy, readonly) NSString *name;
@property (copy, readonly) NSString *address;
@property (copy, readonly) NSArray <NSString*> *types;
@end

SNC_SWIFT_NAME(ShopSearch)
@protocol SNCShopSearch <NSObject>
@property (readonly) NSArray <id<SNCShopCandidate>> *candidates;
@end

<<<<<<< HEAD:Pods/sonect-core-ios/SonectCore.framework/Headers/SNCAddressAutocompletionPlugin.h
@protocol SNCPlaceSearch <NSObject>
@property (readonly) NSArray <id<SNCShopDetails>> *results;
@end

=======
SNC_SWIFT_NAME(NearbySearch)
@protocol SNCNearbySearch <NSObject>
@property (readonly) NSArray <id<SNCShopDetails>> *results;
@end

SNC_SWIFT_NAME(AddressAutocompletion)
>>>>>>> master:Pods/sonect-core-ios/SonectCore.xcframework/ios-arm64_armv7/SonectCore.framework/Headers/SNCAddressAutocompletionPlugin.h
@protocol SNCAddressAutocompletion <NSObject>
@property (readonly) NSArray <id<SNCAddressPrediction>> *predictions;
@end

<<<<<<< HEAD:Pods/sonect-core-ios/SonectCore.framework/Headers/SNCAddressAutocompletionPlugin.h
typedef void(^SNCAddressDetailsResultHandler)(id<SNCAddressDetails> _Nullable addressDetails, NSError * _Nullable error);
typedef void(^SNCAddressAutocompletionResultHandler)(id<SNCAddressAutocompletion> _Nullable autocompleteAddress, NSError * _Nullable error);
typedef void(^SNCShopSearchResultHandler)(id<SNCShopSearch> _Nullable shopSearch, NSError * _Nullable error);
typedef void(^SNCShopDetailsResultHandler)(id<SNCShopDetails> _Nullable shopDetails, NSError * _Nullable error);
typedef void(^SNCPlaceSearchResultHandler)(id<SNCPlaceSearch> _Nullable, NSError * _Nullable error);
=======
typedef void(^SNCAddressDetailsResultHandler)(id<SNCAddressDetails> _Nullable addressDetails, NSError * _Nullable error) SNC_SWIFT_NAME(AddressDetailsResultHandler);
typedef void(^SNCAddressAutocompletionResultHandler)(id<SNCAddressAutocompletion> _Nullable autocompleteAddress, NSError * _Nullable error) SNC_SWIFT_NAME(AddressAutocompletionResultHandler);
typedef void(^SNCShopSearchResultHandler)(id<SNCShopSearch> _Nullable shopSearch, NSError * _Nullable error) SNC_SWIFT_NAME(ShopSearchResultHandler);
typedef void(^SNCShopDetailsResultHandler)(id<SNCShopDetails> _Nullable shopDetails, NSError * _Nullable error) SNC_SWIFT_NAME(ShopDetailsResultHandler);
typedef void(^SNCNearbySearchResultHandler)(id<SNCNearbySearch> _Nullable, NSError * _Nullable error);
>>>>>>> master:Pods/sonect-core-ios/SonectCore.xcframework/ios-arm64_armv7/SonectCore.framework/Headers/SNCAddressAutocompletionPlugin.h
typedef void(^SNCImageLoadCompletionHandler)(UIImage * _Nullable, NSError * _Nullable);

SNC_SWIFT_NAME(AddressDetails)
@protocol SNCAddressAutocompletionPlugin <NSObject>

- (void)addressAutocompletionForSearchTerm:(NSString *)searchTerm
                               countryCode:(NSString *)countryCode
                         completionHandler:(SNCAddressAutocompletionResultHandler)compleionHandler;
 
- (void)adressDetailsForAddressId:(NSString *)addressId
                completionHandler:(SNCAddressDetailsResultHandler)compleionHandler;

- (void)shopsForSearchTerm:(NSString *)searchTerm
               countryCode:(NSString *)countryCode
         completionHandler:(SNCShopSearchResultHandler)compleionHandler;

- (void)shopDetailsForShopId:(NSString *)shopId
           completionHandler:(SNCShopDetailsResultHandler)compleionHandler;

- (void)placesForSearchTerm:(NSString *)searchTerm
<<<<<<< HEAD:Pods/sonect-core-ios/SonectCore.framework/Headers/SNCAddressAutocompletionPlugin.h
                  latitude:(double)lat
                    longitude:(double)lon
          completionHandler:(SNCPlaceSearchResultHandler)completionHandler;
=======
                   latitude:(double)lat
                  longitude:(double)lon
          completionHandler:(SNCNearbySearchResultHandler)completionHandler;
>>>>>>> master:Pods/sonect-core-ios/SonectCore.xcframework/ios-arm64_armv7/SonectCore.framework/Headers/SNCAddressAutocompletionPlugin.h

- (void)photoFromReference:(NSString *)photoReference
                  maxWidth:(double)maxWidth
         completionHandler:(SNCImageLoadCompletionHandler)completionHandler;
@end

NS_ASSUME_NONNULL_END
