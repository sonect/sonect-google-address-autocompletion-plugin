//
//  SNCShopEventHandler.h
//  SonectSDK
//
//  Created by Oleksandr Bedzyk on 19.05.2020.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SNCSonectShop;

@protocol SNCSonectShopEventHandler <NSObject>

/**
 Inform event handler of occuring event.

 @param shop a sonect instance.
 @param event occuring
 */
- (void)sonectShop:(SNCSonectShop *)shop handleEvent:(NSString *)event withParameters:(NSDictionary  * _Nullable)parameters;

@end

NS_ASSUME_NONNULL_END

