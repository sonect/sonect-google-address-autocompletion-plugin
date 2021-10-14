//
//  SNCGooglePlaceSearch.h
//  GoogleAddressAutocompletionPlugin
//
//  Created by Anton Iermilin on 14.06.2021.
//  Copyright © 2021 Ivan Yanakiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNCGoogleShopDetails.h"
#import <SonectCore/SNCAddressAutocompletionPlugin.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNCGoogleNearbySearch : NSObject <SNCNearbySearch>
@property (readonly) NSArray <SNCGoogleShopDetails *> *results;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
