//
//  SNCGoogleAddressAutocompletionPlugin.m
//  SonectShop
//
//  Created by Ivan Yanakiev on 7.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import "SNCGoogleAddressAutocompletionPlugin.h"
#import "SNCGoogleMapsAPI.h"
//#import <SonectCore/SNCAddressAutocompletionPlugin.h>
#import <SonectCore/SonectCore.h>
#import "SNCGoogleAutocompleteAddresses.h"
#import "SNCGoogleShopDetails.h"
#import "SNCGoogleNearbySearch.h"

@interface SNCGoogleAddressAutocompletionPlugin ()

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) SNCGoogleMapsAPI *mapsApi;

@end

@implementation SNCGoogleAddressAutocompletionPlugin

- (instancetype)initWithApiKey:(NSString *)apiKey {
    self = [super init];
    if (self) {
        _apiKey = apiKey;
        _mapsApi = [SNCGoogleMapsAPI new];        
    }
    
    return self;
}

- (void)setDebuggingEnabled:(BOOL)debuggingEnabled {
    _debuggingEnabled = debuggingEnabled;
    self.mapsApi.debuggingEnabled = debuggingEnabled;
}

- (void)addressAutocompletionForSearchTerm:(NSString *)searchTerm
                               countryCode:(NSString *)countryCode
                         completionHandler:(SNCAddressAutocompletionResultHandler)completionHandler {
    [self.mapsApi getAddressesForSearchTerm:searchTerm countryCode:countryCode types:@"address" location:kCLLocationCoordinate2DInvalid googleApiKey:self.apiKey completionHandler:^(SNCGoogleAutocompleteAddresses * _Nullable addressAutocompletion, NSError * _Nullable error) {
        completionHandler((id)addressAutocompletion, error);
    }];
}

- (void)adressDetailsForAddressId:(NSString *)addressId
                completionHandler:(SNCAddressDetailsResultHandler)completionHandler {
    [self.mapsApi getPlaceDetailsForPlaceId:addressId
                                   googleApiKey:self.apiKey
                              completionHandler:^(SNCGooglePlaceDetails * _Nullable placeDetails, NSError * _Nullable error) {
        completionHandler((id)placeDetails, error);
    }];
}

- (void)shopsForSearchTerm:(NSString *)searchTerm
               countryCode:(NSString *)countryCode
         completionHandler:(SNCShopSearchResultHandler)completionHandler {
    [self.mapsApi getShopsForSearchTerm:searchTerm
                                countryCode:countryCode
                               googleApiKey:self.apiKey
                          completionHandler:^(SNCGoogleShopSearch * _Nullable shopSearch, NSError * _Nullable error) {
        completionHandler((id)shopSearch, error);
    }];
}

- (void)shopDetailsForShopId:(NSString *)shopId
           completionHandler:(SNCShopDetailsResultHandler)completionHandler {
    [self.mapsApi getShopDetailsForShopId:shopId
                                 googleApiKey:self.apiKey
                            completionHandler:^(SNCGoogleShopDetails * _Nullable shopDetails, NSError * _Nullable error) {
        completionHandler((id)shopDetails, error);
    }];
}

- (void)placesForSearchTerm:(NSString *)searchTerm
                   latitude:(double)lat
                  longitude:(double)lon
          completionHandler:(SNCNearbySearchResultHandler)completionHandler {
    [self.mapsApi getAddressesForSearchTerm:searchTerm countryCode:@"" types:@"geocode" location:CLLocationCoordinate2DMake(lat, lon) googleApiKey:self.apiKey completionHandler:^(SNCGoogleAutocompleteAddresses * _Nullable addressAutocompletion, NSError * _Nullable error) {
        if (error != nil) {
            completionHandler(nil, error);
        } else {
            NSMutableArray *results = [NSMutableArray new];
            for (id<SNCAddressPrediction> prediction in addressAutocompletion.predictions) {
                if (prediction.mainText == nil || prediction.addressId == nil) {
                    continue;
                }
                
                NSDictionary *shopDictionary = @{
                        @"name" : prediction.mainText,
                    @"vicinity" : prediction.secondaryText ?: @"",
                    @"place_id" : prediction.addressId
                };
                
                [results addObject: shopDictionary];
            }
            NSDictionary *nearbySearchDictionary = @{ @"results" : results };
            
            
            completionHandler([[SNCGoogleNearbySearch alloc] initWithDictionary:nearbySearchDictionary], nil);
        }
    }];
}

- (void)photoFromReference:(NSString *)photoReference
                  maxWidth:(double)maxWidth
         completionHandler:(SNCImageLoadCompletionHandler)completionHandler {
    [self.mapsApi getPhotoFromReference:photoReference maxWidth:maxWidth googleApiKey:self.apiKey completionHandler:completionHandler];
}

@end
