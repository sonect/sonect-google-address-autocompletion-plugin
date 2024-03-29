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
#import <SonectCore/SonectCore.h>

static NSString *addressAutocomplete = @"https://maps.googleapis.com/maps/api/place/autocomplete/json";
static NSString *placeDetails = @"https://maps.googleapis.com/maps/api/place/details/json";
static NSString *textSearchPlace = @"https://maps.googleapis.com/maps/api/place/textsearch/json";
static NSString *placePhoto = @"https://maps.googleapis.com/maps/api/place/photo";
static NSString *nearbySearch = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json";

static CGFloat defaultImageMaxWidth = 1024;

@implementation SNCGoogleMapsAPI

- (void)getAddressesForSearchTerm:(NSString *)searchTerm
                      countryCode:(NSString *)countryCode
                            types:(NSString *)types
                         location:(CLLocationCoordinate2D)location
                     googleApiKey:(NSString *)key
                completionHandler:(SNCGoogleAddressAutocompletionCompletionHandler)completionHandler {

    NSURLComponents *serviceUrl = [NSURLComponents componentsWithString:addressAutocomplete];
    NSMutableArray *queryItems = [@[
        [NSURLQueryItem queryItemWithName:@"input" value:searchTerm],
        [NSURLQueryItem queryItemWithName:@"types" value:types],
        [NSURLQueryItem queryItemWithName:@"key" value:key]
    ] mutableCopy];
    
    if (countryCode.length == 2) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"components" value:[NSString stringWithFormat:@"country:%@", countryCode]]];
    }
    if (CLLocationCoordinate2DIsValid(location)) {
        NSString *value = [NSString stringWithFormat:@"%lf,%lf", location.latitude, location.longitude];
        value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"location" value:value]];
    }
    serviceUrl.queryItems = queryItems;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serviceUrl.URL];
    request.HTTPMethod = @"GET";
    [request setValue:@"Application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self debugLogRequest:request];
 
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [self debugLogResponse:(NSHTTPURLResponse *)response
                          data:data
                         error:error];
        
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

- (void)getPlaceDetailsForPlaceId:(NSString *)placeId
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
    
    [self debugLogRequest:request];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self debugLogResponse:(NSHTTPURLResponse *)response
                          data:data
                         error:error];
        
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

- (void)getShopsForSearchTerm:(NSString *)searchTerm
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
    
    [self debugLogRequest:request];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self debugLogResponse:(NSHTTPURLResponse *)response
                          data:data
                         error:error];
        
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

- (void)getShopDetailsForShopId:(NSString *)placeId
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
    
    [self debugLogRequest:request];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self debugLogResponse:(NSHTTPURLResponse *)response
                          data:data
                         error:error];
        
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

- (void)loadPhotoAndMakeShopDetailsFromDictionary:(NSDictionary *)dictionary googleApiKey:(NSString *)key completion:(SNCGoogleShopDetailsCompletionHandler)completionHandler {
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

- (void)getPhotoFromReference:(NSString *)photoReference
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
    
    [self debugLogRequest:request];
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [self debugLogResponse:(NSHTTPURLResponse *)response
                          data:data
                         error:error];
        
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

- (nullable NSString *)firstPhotoReferenceFromDetailsDictionary:(NSDictionary *)dictionary {
    return [[dictionary[@"result"][@"photos"] firstObject][@"photo_reference"] copy];
}

- (void)getGooglePlacesForSearchTerm:(NSString *)searchTerm
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
    
    [self debugLogRequest:request];
    
    
    NSURLSession *session = NSURLSession.sharedSession;
    [[session dataTaskWithRequest:request.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [self debugLogResponse:(NSHTTPURLResponse *)response
                          data:data
                         error:error];
        
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionHandler(nil, parsingError);
                });
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

#pragma mark - Debug Log

- (void)debugLogRequest:(NSURLRequest *)request {
    if (![self isDebuggingEnabled]) {
        return;
    }
    
    NSString *size = [[NSByteCountFormatter new] stringFromByteCount:(long long)request.HTTPBody.length];
    SNCDDLogDebug(@"\n\n+ REQUEST: %@\n- SIZE: %@\n\n=======================================\n%@\n=======================================\n\n", request.URL.absoluteString, size, request.snc_curl);
}

- (void)debugLogResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error {
    if (![self isDebuggingEnabled]) {
        return;
    }
    
    NSMutableString *logString = [NSMutableString stringWithFormat:@"\n\n+ RESPONSE: %@ (%ld)\n\n=======================================\n", response.URL.absoluteString, (long)response.statusCode];
    
    if (error) {
        [logString appendFormat:@"ERROR: \n%@", error.debugDescription];
    }
    else {
        NSError *jsonError = nil;
        id object = [NSJSONSerialization sncsdk_JSONObjectWithData:data
                                                           options:0
                                                             error:&jsonError
                                                     removingNulls:YES
                                                      ignoreArrays:NO];

        if (!object || jsonError) {
            [logString appendFormat:@"ERROR: \n%@", jsonError.debugDescription];
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [logString appendFormat:@"\n%@\n", dataString];
        }
        else {
            id prettyPrintedData = [NSJSONSerialization dataWithJSONObject:object
                                                                   options:NSJSONWritingPrettyPrinted
                                                                     error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:prettyPrintedData encoding:NSUTF8StringEncoding];
            [logString appendFormat:@"%@", jsonString];
        }
    }
    
    [logString appendString:@"\n=======================================\n"];
    
    SNCDDLogDebug(@"%@\n\n", logString);
}

@end
