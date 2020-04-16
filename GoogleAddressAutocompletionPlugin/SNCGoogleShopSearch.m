//
//  SNCGoogleShopSearch.m
//  GoogleAddressAutocompletionPlugin
//
//  Created by Ivan Yanakiev on 16.04.20.
//  Copyright © 2020 Ivan Yanakiev. All rights reserved.
//

#import "SNCGoogleShopSearch.h"
#import <SonectShop/SNCAddressAutocompletionPlugin.h>

@implementation SNCGoogleShopCandidate

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _address = [dictionary[@"formatted_address"] copy];
        _name = [dictionary[@"name"] copy];
        _shopId = [dictionary[@"place_id"] copy];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ id: %@", self.name, self.address, self.shopId];
}

@end

@implementation SNCGoogleShopSearch

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _candidates = [self parseCandidates:dictionary[@"candidates"]];
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
