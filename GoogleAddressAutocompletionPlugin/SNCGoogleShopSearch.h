//
//  SNCGoogleShopSearch.h
//  GoogleAddressAutocompletionPlugin
//
//  Created by Ivan Yanakiev on 16.04.20.
//  Copyright © 2020 Ivan Yanakiev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SNCShopSearch, SNCShopCandidate, SNCAddressPrediction;

@interface SNCGoogleShopCandidate : NSObject <SNCShopCandidate>

@property (nonatomic, copy, readonly) NSString *shopId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *address;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface SNCGoogleShopSearch : NSObject <SNCShopSearch>

@property (readonly) NSArray <id<SNCAddressPrediction>> *candidates;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
