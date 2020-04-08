//
//  SNCGooglePlaceDetails.m
//  SonectShop
//
//  Created by Ivan Yanakiev on 3.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import "SNCGooglePlaceDetails.h"
#import <SonectShop/SNCAddressAutocompletionPlugin.h>

@implementation SNCGooglePlaceDetails

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *resultDictionary = [dictionary[@"result"] copy];
        
        _longitude = [resultDictionary[@"geometry"][@"location"][@"lng"] floatValue];
        _latitude = [resultDictionary[@"geometry"][@"location"][@"lat"] floatValue];
        [self parseAddressComponents:resultDictionary[@"address_components"]];
    }
    
    return self;
}

- (void)parseAddressComponents:(NSArray *)addressComponents {
    for (NSDictionary *addressComponent in addressComponents) {
        NSArray *types = [addressComponent[@"types"] copy];
        NSString *shortName = [addressComponent[@"short_name"] copy];
        NSString *longName = [addressComponent[@"long_name"] copy];
        if ([types containsObject:@"street_number"]) {
            _streetNumber = shortName;
            continue;
        }
        
         if ([types containsObject:@"route"]) {
             _streetName = shortName;
             continue;
         }
        
        if ([types containsObject:@"locality"]) {
            _city = longName;
            continue;
        }

        if ([types containsObject:@"country"]) {
            _country = longName;
            _countryCode = shortName;
            continue;
        }

        if ([types containsObject:@"postal_code"]) {
            _zip = longName;
            continue;
        }
        
        if ([types containsObject:@"administrative_area_level_1"]) {
            _state = shortName;
            continue;
        }
    }
}

@end
