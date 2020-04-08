//
//  SNCGoogleMapsAPI.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 2.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SNCGoogleAutocompleteAddresses, SNCGooglePlaceDetails;

typedef void(^SNCGoogleAddressAutocompletionCompletionHandler)(SNCGoogleAutocompleteAddresses * _Nullable, NSError * _Nullable);
typedef void(^SNCGooglePlaceDetailsCompletionHandler)(SNCGooglePlaceDetails * _Nullable, NSError * _Nullable);

@interface SNCGoogleMapsAPI : NSObject

+ (void)getAddressesForSearchTerm:(NSString *)searchTerm
                      countryCode:(NSString *)countryCode
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGoogleAddressAutocompletionCompletionHandler)compleionHandler;

+ (void)getPlaceDetailsForPlaceId:(NSString *)placeId
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGooglePlaceDetailsCompletionHandler)compleionHandler;

@end

NS_ASSUME_NONNULL_END
