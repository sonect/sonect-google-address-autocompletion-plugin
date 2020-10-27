//
//  SNCShopOnboardingDataSource.h
//  SonectShop
//
//  Created by Ivan Yanakiev on 31.03.20.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SNCAddress, SNCOpeningHours;

typedef void(^SNCShopOnboardingStringCallback)(NSString *);
typedef void(^SNCShopOnboardingUIntegerCallback)(NSUInteger);
typedef void(^SNCShopOnboardingAddressCallback)(SNCAddress *);
typedef void(^SNCShopOnboardingNameAndAddressCallback)(NSString *, SNCAddress *);
typedef void(^SNCShopOnboardingOpeningHoursCallback)(SNCOpeningHours *);

@protocol SNCShopOnboardingDataSource <NSObject>

@optional

/**
Called on dataSource to get shop name during onboarding. If returns YES, onboarding will be blocked waiting for the shopNameCallback.

@param shopNameCallback callback providing shop name.
@return if data source will provide shop name.
*/
- (BOOL)willProvideShopName:(SNCShopOnboardingStringCallback)shopNameCallback;

/**
Called on dataSource to get shop email during onboarding. If returns YES, onboarding will be blocked waiting for the shopEmailCallback.

@param shopEmailCallback callback providing shop email.
@return if data source will provide shop email.
*/
- (BOOL)willProvideShopEmail:(SNCShopOnboardingStringCallback)shopEmailCallback;

/**
Called on dataSource to get shop imagePatth during onboarding. If returns YES, onboarding will be blocked waiting for the shopImagePathCallback.

@param shopImagePathCallback callback providing shop image.
@return if data source will provide shop image path.
*/
- (BOOL)willProvideShopImagePath:(SNCShopOnboardingStringCallback)shopImagePathCallback;

/**
Called on dataSource to get shop IBAN during onboarding. If returns YES, onboarding will be blocked waiting for the shopIBANCallback.

@param shopIBANCallback callback providing shop IBAN.
@return if data source will provide shop IBAN.
*/
- (BOOL)willProvideShopIBAN:(SNCShopOnboardingStringCallback)shopIBANCallback;

/**
Called on dataSource to get shop withdrawal limit during onboarding. If returns YES, onboarding will be blocked waiting for the shopWithdrawalLimitCallback.

@param shopWithdrawalLimitCallback callback providing shop withdrawal limit.
@return if data source will provide shop withdrawal limit.
*/
- (BOOL)willProvideShopWithdrawalLimit:(SNCShopOnboardingUIntegerCallback)shopWithdrawalLimitCallback;

/**
Called on dataSource to get shop address during onboarding. If returns YES, onboarding will be blocked waiting for the shopAddressCallback.

@param shopAddressCallback callback providing shop address.
@return if data source will provide shop address.
*/
- (BOOL)willProvideShopAddress:(SNCShopOnboardingAddressCallback)shopAddressCallback;

/**
Called on dataSource to get shop beneficiary name and address during onboarding. If returns YES, onboarding will be blocked waiting for the shopBeneficiaryNameAddressCallback.

@param shopBeneficiaryNameAddressCallback callback providing shop beneficiary name and address.
@return if data source will provide shop beneficiary name and address.
*/
- (BOOL)willProvideBeneficiaryNameAndAddress:(SNCShopOnboardingNameAndAddressCallback)shopBeneficiaryNameAddressCallback;

/**
Called on dataSource to get shop opening hours during onboarding. If returns YES, onboarding will be blocked waiting for the shopOpeningHoursCallback.

@param shopOpeningHoursCallback callback providing shop opening hours.
@return if data source will provide shop opening hours.
*/
- (BOOL)willProvideOpeningHours:(SNCShopOnboardingOpeningHoursCallback)shopOpeningHoursCallback;

/**
Called on dataSource to check if the app will provide data like shop name or address.
In case this returns YES, address autocompletion will be disabled for the user.

@return YES if data source will provide shop info.
*/
- (BOOL)willProvideShopInfo;

@end

NS_ASSUME_NONNULL_END
