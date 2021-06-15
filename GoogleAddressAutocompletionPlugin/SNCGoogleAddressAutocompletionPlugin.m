//
//  SNCGoogleAddressAutocompletionPlugin.m
//  SonectShop
//
//  Created by Ivan Yanakiev on 7.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import "SNCGoogleAddressAutocompletionPlugin.h"
#import "SNCGoogleMapsAPI.h"
#import <SonectCore/SNCAddressAutocompletionPlugin.h>

@interface SNCGoogleAddressAutocompletionPlugin ()

@property (nonatomic, strong) NSString *apiKey;

@end

@implementation SNCGoogleAddressAutocompletionPlugin

- (instancetype)initWithApiKey:(NSString *)apiKey {
    self = [super init];
    if (self) {
        _apiKey = apiKey;
    }
    
    return self;
}

- (void)addressAutocompletionForSearchTerm:(NSString *)searchTerm
                               countryCode:(NSString *)countryCode
                         completionHandler:(SNCAddressAutocompletionResultHandler)completionHandler {
    [SNCGoogleMapsAPI getAddressesForSearchTerm:searchTerm countryCode:countryCode googleApiKey:self.apiKey completionHandler:^(SNCGoogleAutocompleteAddresses * _Nullable addressAutocompletion, NSError * _Nullable error) {
        completionHandler((id)addressAutocompletion, error);
    }];
}

- (void)adressDetailsForAddressId:(NSString *)addressId
                completionHandler:(SNCAddressDetailsResultHandler)completionHandler {
    [SNCGoogleMapsAPI getPlaceDetailsForPlaceId:addressId
                                   googleApiKey:self.apiKey
                              completionHandler:^(SNCGooglePlaceDetails * _Nullable placeDetails, NSError * _Nullable error) {
        completionHandler((id)placeDetails, error);
    }];
}

- (void)shopsForSearchTerm:(NSString *)searchTerm
               countryCode:(NSString *)countryCode
         completionHandler:(SNCShopSearchResultHandler)completionHandler {
    [SNCGoogleMapsAPI getShopsForSearchTerm:searchTerm
                                countryCode:countryCode
                               googleApiKey:self.apiKey
                          completionHandler:^(SNCGoogleShopSearch * _Nullable shopSearch, NSError * _Nullable error) {
        completionHandler((id)shopSearch, error);
    }];
}

- (void)shopDetailsForShopId:(NSString *)shopId
           completionHandler:(SNCShopDetailsResultHandler)completionHandler {
    [SNCGoogleMapsAPI getShopDetailsForShopId:shopId
                                 googleApiKey:self.apiKey
                            completionHandler:^(SNCGoogleShopDetails * _Nullable shopDetails, NSError * _Nullable error) {
        completionHandler((id)shopDetails, error);
    }];
}

- (void)placesForSearchTerm:(NSString *)searchTerm
                   latitude:(double)lat
                  longitude:(double)lon
          completionHandler:(SNCGooglePlaceSearchResultHandler)completionHandler {
    [SNCGoogleMapsAPI getGooglePlacesForSearchTerm:searchTerm googleApiKey:self.apiKey latitude:lat longitude:lon completionHandler:completionHandler];
}

- (void)photoFromReference:(NSString *)photoReference
                  maxWidth:(double)maxWidth
         completionHandler:(SNCImageLoadCompletionHandler)completionHandler {
    [SNCGoogleMapsAPI getPhotoFromReference:photoReference maxWidth:maxWidth googleApiKey:self.apiKey completionHandler:completionHandler];
}

@end
