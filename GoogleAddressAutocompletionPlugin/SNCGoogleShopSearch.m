//
//  SNCGoogleShopSearch.m
//  GoogleAddressAutocompletionPlugin
//
//  Created by Ivan Yanakiev on 16.04.20.
//  Copyright © 2020 Ivan Yanakiev. All rights reserved.
//

#import "SNCGoogleShopSearch.h"
#import <SonectCore/SNCAddressAutocompletionPlugin.h>

@implementation SNCGoogleShopCandidate

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _shopId = [dictionary[@"place_id"] copy];
        _name = [dictionary[@"structured_formatting"][@"main_text"] copy];
        _address = [dictionary[@"structured_formatting"][@"secondary_text"] copy];
        _types = [dictionary[@"types"] copy];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ id: %@ types: %@", self.name, self.address, self.shopId, self.types];
}

@end

@implementation SNCGoogleShopSearch

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _candidates = [self parseCandidates:dictionary[@"predictions"]];
    }
    
    return self;
}

- (NSArray<id<SNCAddressPrediction>> *)parseCandidates:(NSArray *)candidatesDictionary {
    NSMutableArray *candidates = [NSMutableArray new];
    for (NSDictionary *candidateDictionary in candidatesDictionary) {
        SNCGoogleShopCandidate *candidate = [[SNCGoogleShopCandidate alloc] initWithDictionary:candidateDictionary];
        [candidates addObject:candidate];
    }
    
    return candidates.copy;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"candidates: %@", self.candidates];
}

@end
