//
//  SNCGoogleMapsAPI.m
//  SonectShop
//
//  Created by Ivan Yanakiev on 2.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import "SNCGoogleMapsAPI.h"
#import "SNCGoogleAutocompleteAddresses.h"
#import "SNCGooglePlaceDetails.h"
#import "SNCGoogleShopSearch.h"
#import "SNCGoogleShopDetails.h"

static NSString *addressAutocomplete = @"https://maps.googleapis.com/maps/api/place/autocomplete/json";
static NSString *placeDetails = @"https://maps.googleapis.com/maps/api/place/details/json";
static NSString *textSearchPlace = @"https://maps.googleapis.com/maps/api/place/textsearch/json";

@implementation SNCGoogleMapsAPI

+ (void)getAddressesForSearchTerm:(NSString *)searchTerm
                      countryCode:(NSString *)countryCode
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGoogleAddressAutocompletionCompletionHandler)compleionHandler {

    NSURLComponents *serviceUrl = [NSURLComponents componentsWithString:addressAutocomplete];
    serviceUrl.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"input" value:searchTerm],
        [NSURLQueryItem queryItemWithName:@"types" value:@"address"],
        [NSURLQueryItem queryItemWithName:@"key" value:key],
        [NSURLQueryItem queryItemWithName:@"components" value:[NSString stringWithFormat:@"country:%@", countryCode]]
    ];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceUrl.URL];
    request.HTTPMethod = @"GET";
    [request setValue:@"Application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                compleionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                compleionHandler(nil, parsingError);
                return;
            }
            
            SNCGoogleAutocompleteAddresses *autocompletedAddresses = [[SNCGoogleAutocompleteAddresses alloc] initWithDictionary:dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                compleionHandler(autocompletedAddresses, nil);
            });
            
            return;
        }
    }] resume];
}

+ (void)getPlaceDetailsForPlaceId:(NSString *)placeId
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGooglePlaceDetailsCompletionHandler)compleionHandler {
    NSURLComponents *serviceUrl = [NSURLComponents componentsWithString:placeDetails];
    serviceUrl.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"placeid" value:placeId],
        [NSURLQueryItem queryItemWithName:@"fields" value:@"address_component,geometry"],
        [NSURLQueryItem queryItemWithName:@"key" value:key],
    ];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceUrl.URL];
    request.HTTPMethod = @"GET";
    [request setValue:@"Application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                compleionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                compleionHandler(nil, parsingError);
                return;
            }
            
            SNCGooglePlaceDetails *placeDetails = [[SNCGooglePlaceDetails alloc] initWithDictionary:dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                compleionHandler(placeDetails, nil);
            });
            
            return;
        }
    }] resume];
}

+ (void)getShopsForSearchTerm:(NSString *)searchTerm
                  countryCode:(NSString *)countryCode
                 googleApiKey:(NSString *)key
            completionHandler:(SNCGoogleShopSearchCompletionHandler)compleionHandler {
    
    NSURLComponents *serviceUrl = [NSURLComponents componentsWithString:addressAutocomplete];
    serviceUrl.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"input" value:searchTerm],
        [NSURLQueryItem queryItemWithName:@"types" value:@"establishment"],
        [NSURLQueryItem queryItemWithName:@"key" value:key],
        [NSURLQueryItem queryItemWithName:@"components" value:[NSString stringWithFormat:@"country:%@", countryCode]]
    ];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceUrl.URL];
    request.HTTPMethod = @"GET";
    [request setValue:@"Application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                compleionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                compleionHandler(nil, parsingError);
                return;
            }
            
            SNCGoogleShopSearch *searchShop = [[SNCGoogleShopSearch alloc] initWithDictionary:dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                compleionHandler(searchShop, nil);
            });
            
            return;
        }
    }] resume];
}

+ (void)getShopDetailsForShopId:(NSString *)placeId
                   googleApiKey:(NSString *)key
              completionHandler:(SNCGoogleShopDetailsCompletionHandler)compleionHandler {
    NSURLComponents *serviceUrl = [NSURLComponents componentsWithString:placeDetails];
    serviceUrl.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"placeid" value:placeId],
        [NSURLQueryItem queryItemWithName:@"fields" value:@"address_component,photo,name,opening_hours,geometry"],
        [NSURLQueryItem queryItemWithName:@"key" value:key],
    ];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceUrl.URL];
    request.HTTPMethod = @"GET";
    [request setValue:@"Application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                compleionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                compleionHandler(nil, parsingError);
                return;
            }
            
            SNCGoogleShopDetails *placeDetails = [[SNCGoogleShopDetails alloc] initWithDictionary:dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                compleionHandler(placeDetails, nil);
            });
            
            return;
        }
    }] resume];
}

@end
