//
//  Parser.h
//  EAIntroView
//
//  Created by KrunalSoni on 30/07/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject
+ (NSDictionary*)getCasteReligionDictionary:(NSDictionary*)dict;
+ (NSArray*)getFilteredArrayFromArray:(NSArray*)arr;
+ (NSArray*)getFilteredArrayFromArrayForHolyPlaces:(NSArray*)arr;
+ (NSArray*)getFilteredArrayFromArrayForBooks:(NSArray*)arr;
+ (NSArray*)getFilteredArrayFromArrayForPrayers:(NSArray*)arr;
+ (NSDictionary*)getReligion:(NSDictionary*)dict;
+ (NSArray*)getArrayOfFestivalDetailModel:(NSDictionary*)dict;
+ (NSArray*)getArrayOfCeremonyDetailModel:(NSDictionary*)dict;
+ (NSArray*)getArrayOfHolyPlaceDetailModel:(NSDictionary*)dict;
+ (NSArray*)getArrayOfFoodDetailModel:(NSDictionary*)dict;
@end
