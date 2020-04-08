//
//  SNCGoogleAddressAutocompletionPlugin.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 7.04.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SNCAddressAutocompletionPlugin;

@interface SNCGoogleAddressAutocompletionPlugin : NSObject <SNCAddressAutocompletionPlugin>

- (instancetype)initWithApiKey:(NSString *)apiKey;

@end

NS_ASSUME_NONNULL_END
