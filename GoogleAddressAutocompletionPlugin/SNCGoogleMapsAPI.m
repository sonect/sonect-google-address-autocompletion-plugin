//
//  SNCGoogleMapsAPI.m
//  SonectShop
//
//  Created by Ivan Yanakiev on 2.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCGoogleMapsAPI.h"
#import "SNCGoogleAutocompleteAddresses.h"
#import "SNCGooglePlaceDetails.h"
#import "SNCGoogleShopSearch.h"
#import "SNCGoogleShopDetails.h"
#import "SNCGoogleNearbySearch.h"
#import <CoreLocation/CoreLocation.h>

static NSString *addressAutocomplete = @"https://maps.googleapis.com/maps/api/place/autocomplete/json";
static NSString *placeDetails = @"https://maps.googleapis.com/maps/api/place/details/json";
static NSString *textSearchPlace = @"https://maps.googleapis.com/maps/api/place/textsearch/json";
static NSString *placePhoto = @"https://maps.googleapis.com/maps/api/place/photo";
static NSString *nearbySearch = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json";

static CGFloat defaultImageMaxWidth = 1024;

@implementation SNCGoogleMapsAPI

+ (void)getAddressesForSearchTerm:(NSString *)searchTerm
                      countryCode:(NSString *)countryCode
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGoogleAddressAutocompletionCompletionHandler)completionHandler {

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
                completionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                completionHandler(nil, parsingError);
                return;
            }
            
            SNCGoogleAutocompleteAddresses *autocompletedAddresses = [[SNCGoogleAutocompleteAddresses alloc] initWithDictionary:dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(autocompletedAddresses, nil);
            });
            
            return;
        }
    }] resume];
}

+ (void)getPlaceDetailsForPlaceId:(NSString *)placeId
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGooglePlaceDetailsCompletionHandler)completionHandler {
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
                completionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                completionHandler(nil, parsingError);
                return;
            }
            
            SNCGooglePlaceDetails *placeDetails = [[SNCGooglePlaceDetails alloc] initWithDictionary:dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(placeDetails, nil);
            });
            
            return;
        }
    }] resume];
}

+ (void)getShopsForSearchTerm:(NSString *)searchTerm
                  countryCode:(NSString *)countryCode
                 googleApiKey:(NSString *)key
            completionHandler:(SNCGoogleShopSearchCompletionHandler)completionHandler {
    
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
                completionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                completionHandler(nil, parsingError);
                return;
            }
            
            SNCGoogleShopSearch *searchShop = [[SNCGoogleShopSearch alloc] initWithDictionary:dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(searchShop, nil);
            });
            
            return;
        }
    }] resume];
}

+ (void)getShopDetailsForShopId:(NSString *)placeId
                   googleApiKey:(NSString *)key
              completionHandler:(SNCGoogleShopDetailsCompletionHandler)completionHandler {
    NSURLComponents *serviceUrl = [NSURLComponents componentsWithString:placeDetails];
    serviceUrl.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"placeid" value:placeId],
        [NSURLQueryItem queryItemWithName:@"fields" value:@"address_component,photo,name,opening_hours,geometry,type"],
        [NSURLQueryItem queryItemWithName:@"key" value:key],
    ];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceUrl.URL];
    request.HTTPMethod = @"GET";
    [request setValue:@"Application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                completionHandler(nil, parsingError);
                return;
            }
            
            [self loadPhotoAndMakeShopDetailsFromDictionary:dictionary googleApiKey:key completion:completionHandler];
            
            return;
        }
    }] resume];
}

+ (void)loadPhotoAndMakeShopDetailsFromDictionary:(NSDictionary *)dictionary googleApiKey:(NSString *)key completion:(SNCGoogleShopDetailsCompletionHandler)completionHandler {
    NSString *photoReference = [self firstPhotoReferenceFromDetailsDictionary:dictionary];
    NSDictionary *resultDictionary = dictionary[@"result"];
    if (photoReference) {
        [self getPhotoFromReference:photoReference
                           maxWidth:defaultImageMaxWidth
                       googleApiKey:key
                  completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
            SNCGoogleShopDetails *placeDetails = [[SNCGoogleShopDetails alloc] initWithDictionary:resultDictionary shopImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(placeDetails, nil);
            });
        }];
    } else {
        SNCGoogleShopDetails *placeDetails = [[SNCGoogleShopDetails alloc] initWithDictionary:resultDictionary shopImage:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(placeDetails, nil);
        });
    }
}

+ (void)getPhotoFromReference:(NSString *)photoReference
                     maxWidth:(CGFloat)maxWidth
                   googleApiKey:(NSString *)key
            completionHandler:(SNCGooglePlacePhotoCompletionHandler)completionHandler {
    NSURLComponents *serviceUrl = [NSURLComponents componentsWithString:placePhoto];
    
    serviceUrl.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"photoreference" value:photoReference],
        [NSURLQueryItem queryItemWithName:@"maxwidth" value:[NSString stringWithFormat:@"%.0f", maxWidth]],
        [NSURLQueryItem queryItemWithName:@"key" value:key],
    ];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceUrl.URL];
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            
            if (image) {
                completionHandler(image, nil);
            } else {
                completionHandler(nil, [NSError errorWithDomain:NSNetServicesErrorDomain code:100 userInfo:nil]);
            }
        }
    }] resume];
}

+ (nullable NSString *)firstPhotoReferenceFromDetailsDictionary:(NSDictionary *)dictionary {
    return [[dictionary[@"result"][@"photos"] firstObject][@"photo_reference"] copy];
}

+ (void)getGooglePlacesForSearchTerm:(NSString *)searchTerm
                        googleApiKey:(NSString *)key
                            latitude:(double)lat
                           longitude:(double)lon
                   completionHandler:(SNCGooglePlaceSearchResultHandler)completionHandler {
    
    NSURLComponents *serviceUrl = [NSURLComponents componentsWithString:nearbySearch];
    serviceUrl.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"key" value:key],
        [NSURLQueryItem queryItemWithName:@"keyword" value:searchTerm],
        [NSURLQueryItem queryItemWithName:@"location" value:[NSString stringWithFormat:@"%f,%f", lat, lon]],
        [NSURLQueryItem queryItemWithName:@"rankby" value:@"distance"],
    ];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceUrl.URL];
    request.HTTPMethod = @"GET";
    [request setValue:@"Application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        if (data) {
            NSError *parsingError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&parsingError];
            if (parsingError) {
                completionHandler(nil, parsingError);
                return;
            }
            
            SNCGoogleNearbySearch *searchPlace = [[SNCGoogleNearbySearch alloc] initWithDictionary:dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(searchPlace, nil);
            });
            
            return;
        }
    }] resume];
}

@end
