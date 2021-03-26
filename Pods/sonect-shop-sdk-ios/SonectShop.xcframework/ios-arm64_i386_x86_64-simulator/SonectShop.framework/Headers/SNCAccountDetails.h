//
//  SNCAccountDetails.h
//  SonectShop
//
//  Created by Marko Hlebar on 08/03/2021.
//  Copyright © 2021 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SNCAccountDetailsType) {
    SNCAccountDetailsTypeIban,
    SNCAccountDetailsTypeBankAccount,
};

@interface SNCAccountDetails : NSObject <NSSecureCoding, NSCopying>
@property (nonatomic, readonly) SNCAccountDetailsType type;

+ (instancetype)accountDetailsWithIban:(NSString *)iban;

+ (instancetype)accountDetailsWithSortCode:(NSString *)sortCode
                             accountNumber:(NSString *)accountNumber;

- (NSDictionary *)toDictionary;

@end

@interface SNCAccountDetails (IBAN)
@property (nonatomic, readonly) NSString *iban;
@end

@interface SNCAccountDetails (BankAccount)
@property (nonatomic, readonly) NSString *sortCode;
@property (nonatomic, readonly) NSString *accountNumber;
@end


NS_ASSUME_NONNULL_END
