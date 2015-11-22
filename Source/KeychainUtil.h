//
//  KeychainUtil.h
//
//
//  Created by admin on 9/11/12.
//  Copyright (c) 2012 Rahul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

#import <SystemConfiguration/SystemConfiguration.h>
/**
 This interface acxts as an utility for dealing with kechain items
 */
@interface KeychainUtil : NSObject

/**
 Search the keychain for the specified identifier and provide the search item. Search results is limited to one.
 @param identifire a string identifire to search
 @return NSData returs a NSData as a search result
 */
+ (NSData*)searchKeychainCopyMatchingIdentifier:(NSString*)identifier;

/**
 Provide a string for the specified matching identifier.
 @param identifire a string identifire to search
 @return NSSTring returs a string as a search result
 */
+ (NSString*)keychainStringFromMatchingIdentifier:(NSString*)identifier;

/**
 Create a keychain item for specified identifier with specified value
 @param value a string value to store
 @param identifier a string identifier to be created
 @return BOOL return YES if created a keychain item else return NO.
 */
+ (BOOL)createKeychainValue:(NSString*)value forIdentifier:(NSString*)identifier;

/**
 Create a keychain item for specified identifier with specified value
 @param value a string value to store
 @param identifier a string identifier to be created
 @return BOOL return YES if created a keychain item else return NO.
 */
+ (BOOL)createKeychainValueWithLessRestriction:(NSString*)value forIdentifier:(NSString*)identifier;

/**
 Update a keychain item for specified identifier with specified value
 @param value a string value to be updated for spefified identifire
 @param identifier a string identifier to be updated
 @return BOOL return YES if updated a keychain item else return NO.
 */
+ (BOOL)updateKeychainValue:(NSString*)value forIdentifier:(NSString*)identifier;

/**
 Delete keychain item for specified identifier.
 @param identifier a string identifier to be deleted
 */
+ (void)deleteItemFromKeychainWithIdentifier:(NSString*)identifier;

/**
 Create a keychain item for specified identifier with specified value data
 @param valueDate a NSData value to store
 @param identifier a NSString identifier to be created
 @return BOOL return YES if created a keychain item else return NO.
 */
+ (BOOL)createKeychainValueData:(NSData*)valueData forIdentifier:(NSString*)identifier;

/**
 Update a keychain item for specified identifier with specified value data
 @param valueDate a NSData value data to be updated for spefified identifire
 @param identifier a NSString identifier to be updated
 @return BOOL return YES if created a keychain item else return NO.
 */
+ (BOOL)updateKeychainValueData:(NSData*)valueData forIdentifier:(NSString*)identifier;

@end
