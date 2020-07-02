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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *resultDictionary = [dictionary[@"result"] copy];
        _address = [[SNCGooglePlaceDetails alloc] initWithDictionary:dictionary];
        _name = [resultDictionary[@"name"] copy];
        _openingHours = [self parseOpeningHours:[resultDictionary[@"opening_hours"] copy]];
        _types = [resultDictionary[@"types"] copy];
    }
    
    return self;
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
