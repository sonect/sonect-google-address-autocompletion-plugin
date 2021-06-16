//
//  SNCGoogleShopDetails.m
//  GoogleAddressAutocompletionPlugin
//
//  Created by Ivan Yanakiev on 16.04.20.
//  Copyright © 2020 Ivan Yanakiev. All rights reserved.
//

#import "SNCGoogleShopDetails.h"
#import "SNCGooglePlaceDetails.h"
#import <SonectCore/SNCAddressAutocompletionPlugin.h>
#import <SonectCore/SNCOpeningHours.h>

@implementation SNCGoogleShopDetails

- (instancetype)initWithDictionary:(NSDictionary *)dictionary shopImage:(nullable UIImage *)shopImage {
    self = [super init];
    if (self) {
        _address = [[SNCGooglePlaceDetails alloc] initWithDictionary:@{@"result" : dictionary}]; // it expects such structure
        _name = [dictionary[@"name"] copy];
        _openingHours = [self parseOpeningHours:[dictionary[@"opening_hours"] copy]];
        _types = [dictionary[@"types"] copy];
        _shopImage = shopImage;
        _vicinity = dictionary[@"vicinity"];
        _placeId = dictionary[@"place_id"];
        _photoReference = [[dictionary[@"photos"] firstObject][@"photo_reference"] copy];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ -- %@, %@, lat: %f, lon: %f", super.description, _name, _vicinity, _address.latitude, _address.longitude];
}

- (SNCOpeningHours *)parseOpeningHours:(NSDictionary *)openingHoursDictionary {
    if (!openingHoursDictionary) {
        return nil;
    }
    NSMutableArray *periods = [NSMutableArray new];
    
    for (NSDictionary *periodDictionary in openingHoursDictionary[@"periods"]) {
        SNCDayTime *openTime = [[SNCDayTime alloc] initWithDay:[periodDictionary[@"open"][@"day"] unsignedIntValue] andTime:[periodDictionary[@"open"][@"time"] copy]];
        SNCDayTime *closeTime = [[SNCDayTime alloc] initWithDay:[periodDictionary[@"close"][@"day"] unsignedIntValue] andTime:[periodDictionary[@"close"][@"time"] copy]];
        SNCPeriod *period = [[SNCPeriod alloc] initWithOpeningTime:openTime andClosingTime:closeTime];
        
        [periods addObject:period];
    }
         
    return [[SNCOpeningHours alloc] initWithPeriods:periods.copy];
}

@end
