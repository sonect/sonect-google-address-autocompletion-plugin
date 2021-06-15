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
        _results = [self parseResults:dictionary[@"results"]];
    }
    
    return self;
}

- (NSArray<SNCGoogleShopDetails *> *)parseResults:(NSArray *)results {
    NSMutableArray *detailsOut = [NSMutableArray new];
    for (NSDictionary *dictionary in results) {
        SNCGoogleShopDetails *details = [[SNCGoogleShopDetails alloc] initWithDictionary:dictionary shopImage:nil];
        [detailsOut addObject:details];
    }
    
    return detailsOut.copy;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"results: %@", self.results];
}
@end
