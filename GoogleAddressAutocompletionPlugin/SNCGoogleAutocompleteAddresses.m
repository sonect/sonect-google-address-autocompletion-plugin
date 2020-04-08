//
//  SNCGoogleAutocompleteAddresses.m
//  SonectShop
//
//  Created by Ivan Yanakiev on 3.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import "SNCGoogleAutocompleteAddresses.h"
#import <SonectShop/SNCAddressAutocompletionPlugin.h>

@implementation SNCGoogleAddressPrediction

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _addressDescription = [dictionary[@"description"] copy];
        _types = [dictionary[@"types"] copy];
        _addressId = [dictionary[@"place_id"] copy];
        _reference = [dictionary[@"reference"] copy];
        _mainText = [dictionary[@"structured_formatting"][@"main_text"] copy];
        _secondaryText = [dictionary[@"structured_formatting"][@"secondary_text"] copy];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ id: %@", self.mainText, self.secondaryText, self.addressId];
}

@end

@implementation SNCGoogleAutocompleteAddresses

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _predictions = [self parsePredictions:dictionary[@"predictions"]];
    }
    
    return self;
}

- (NSArray<id<SNCAddressPrediction>> *)parsePredictions:(NSArray *)predictionsDictionaries {
    NSMutableArray *predictions = [NSMutableArray new];
    for (NSDictionary *predictionDictionary in predictionsDictionaries) {
        SNCGoogleAddressPrediction *prediction = [[SNCGoogleAddressPrediction alloc] initWithDictionary:predictionDictionary];
        [predictions addObject:prediction];
    }
    
    return predictions.copy;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"predictions: %@", self.predictions];
}

@end
