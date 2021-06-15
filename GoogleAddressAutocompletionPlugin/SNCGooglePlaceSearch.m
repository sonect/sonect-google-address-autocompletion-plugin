//
//  SNCGooglePlaceSearch.m
//  GoogleAddressAutocompletionPlugin
//
//  Created by Anton Iermilin on 14.06.2021.
//  Copyright © 2021 Ivan Yanakiev. All rights reserved.
//

#import "SNCGoogleNearbySearch.h"
#import "SNCGoogleShopDetails.h"

@implementation SNCGoogleNearbySearch
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _candidates = [self parseCandidates:dictionary[@"results"]];
    }
    
    return self;
}

- (NSArray<SNCGoogleShopDetails *> *)parseCandidates:(NSArray *)candidatesDictionary {
    NSMutableArray *candidates = [NSMutableArray new];
    for (NSDictionary *candidateDictionary in candidatesDictionary) {
        SNCGoogleShopDetails *candidate = [[SNCGoogleShopDetails alloc] initWithDictionary:candidateDictionary shopImage:nil];
        [candidates addObject:candidate];
    }
    
    return candidates.copy;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"results: %@", self.candidates];
}
@end
