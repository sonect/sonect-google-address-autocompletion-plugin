//
//  SNCGoogleAddressAutocompletionPlugin.m
//  SonectShop
//
//  Created by Ivan Yanakiev on 7.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import "SNCGoogleAddressAutocompletionPlugin.h"
#import "SNCGoogleMapsAPI.h"
#import <SonectShop/SNCAddressAutocompletionPlugin.h>

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
                         completionHandler:(SNCAddressAutocompletionResultHandler)compleionHandler {
    [SNCGoogleMapsAPI getAddressesForSearchTerm:searchTerm countryCode:countryCode googleApiKey:self.apiKey completionHandler:^(SNCGoogleAutocompleteAddresses * _Nullable addressAutocompletion, NSError * _Nullable error) {
        compleionHandler(addressAutocompletion, error);
    }];
}

- (void)adressDetailsForAddressId:(NSString *)addressId
                completionHandler:(SNCAddressDetailsHandler)compleionHandler {
    [SNCGoogleMapsAPI getPlaceDetailsForPlaceId:addressId googleApiKey:self.apiKey completionHandler:^(SNCGooglePlaceDetails * _Nullable placeDetails, NSError * _Nullable error) {
        compleionHandler(placeDetails, error);
    }];
}

@end
