//
//  SNCGoogleMapsAPI.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 2.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SNCGoogleAutocompleteAddresses, SNCGooglePlaceDetails, SNCGoogleShopSearch, SNCGoogleShopDetails, UIImage, SNCGoogleNearbySearch;

typedef void(^SNCGoogleAddressAutocompletionCompletionHandler)(SNCGoogleAutocompleteAddresses * _Nullable, NSError * _Nullable);
typedef void(^SNCGooglePlaceDetailsCompletionHandler)(SNCGooglePlaceDetails * _Nullable, NSError * _Nullable);
typedef void(^SNCGoogleShopSearchCompletionHandler)(SNCGoogleShopSearch * _Nullable, NSError * _Nullable);
typedef void(^SNCGoogleShopDetailsCompletionHandler)(SNCGoogleShopDetails * _Nullable, NSError * _Nullable);
typedef void(^SNCGooglePlacePhotoCompletionHandler)(UIImage * _Nullable, NSError * _Nullable);
typedef void(^SNCGooglePlaceSearchResultHandler)(SNCGoogleNearbySearch * _Nullable, NSError * _Nullable error);

@interface SNCGoogleMapsAPI : NSObject

+ (void)getAddressesForSearchTerm:(NSString *)searchTerm
                      countryCode:(NSString *)countryCode
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGoogleAddressAutocompletionCompletionHandler)compleionHandler;

+ (void)getPlaceDetailsForPlaceId:(NSString *)placeId
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGooglePlaceDetailsCompletionHandler)compleionHandler;

+ (void)getShopsForSearchTerm:(NSString *)searchTerm
                  countryCode:(NSString *)countryCode
                 googleApiKey:(NSString *)key
            completionHandler:(SNCGoogleShopSearchCompletionHandler)compleionHandler;

+ (void)getShopDetailsForShopId:(NSString *)placeId
                   googleApiKey:(NSString *)key
              completionHandler:(SNCGoogleShopDetailsCompletionHandler)compleionHandler;

+ (void)getGooglePlacesForSearchTerm:(NSString *)searchTerm
                        googleApiKey:(NSString *)key
                            latitude:(double)lat
                           longitude:(double)lon
                   completionHandler:(SNCGooglePlaceSearchResultHandler)completionHandler;

+ (void)getPhotoFromReference:(NSString *)photoReference
                     maxWidth:(double)maxWidth
                 googleApiKey:(NSString *)key
            completionHandler:(SNCGooglePlacePhotoCompletionHandler)completionHandler;
@end

NS_ASSUME_NONNULL_END
