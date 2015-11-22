//
//  AFNetworkFacade.h
//  EAIntroView
//
//  Created by KrunalSoni on 30/07/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^completionBlock)(NSString* urlResponse, NSError* error);
typedef void (^successResponseBlock)(NSDictionary* dict);
typedef void (^successArrResponseBlock)(NSArray* array);

@interface AFNetworkFacade : NSObject
+ (void)getReligionwithSuccessBlock:(successResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getCasteWithReligionId:(NSString*)relID withSuccessBlock:(successResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)registerNewUserWithDict:(NSDictionary*)dict withSuccessBlock:(successResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)loginUserWithDict:(NSDictionary*)dict withSuccessBlock:(successResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)forgotPasswordDict:(NSDictionary*)dict withSuccessBlock:(completionBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getFestivalswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getBookswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getCeremonyswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getPrayerwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getHolyPlaceswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getCalendarwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getForgotPasswordwithSuccessBlock:(completionBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getTraditionalArtwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getTraditionalWearwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getTraditionalFoodwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getYogaswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getFestivalDetailForFestivalId:(NSString*)festID WithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getCeremonyDetailForCeremonyId:(NSString*)festID WithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getHolyPlaceDetailForHolyPlace:(NSString*)festID WithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
+ (void)getFoodDetailForFoodId:(NSString*)festID WithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure;
@end
