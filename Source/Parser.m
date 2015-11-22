//
//  Parser.m
//  EAIntroView
//
//  Created by KrunalSoni on 30/07/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import "Parser.h"
#import "DetailsModel.h"

@implementation Parser
+ (NSDictionary*)getCasteReligionDictionary:(NSDictionary*)dict
{
    NSMutableDictionary* casteRelDict = [NSMutableDictionary new];

    NSArray* tempArray = [dict objectForKey:@"_RetData"];
    for (NSDictionary* temp in tempArray) {
        [casteRelDict setObject:[temp objectForKey:@"Value"] forKey:[temp objectForKey:@"Text"]];
    }
    return [NSDictionary dictionaryWithDictionary:casteRelDict];
}
+ (NSDictionary*)getReligion:(NSDictionary*)dict
{
    NSMutableDictionary* casteRelDict = [NSMutableDictionary new];

    NSArray* tempArray = [dict objectForKey:@"_RetData"];
    for (NSDictionary* temp in tempArray) {
        if ([temp objectForKey:@"RelName"]) {
            [casteRelDict setObject:[temp objectForKey:@"RelName"] forKey:@"Religion"];
        }
    }
    return [NSDictionary dictionaryWithDictionary:casteRelDict];
}
+ (NSArray*)getFilteredArrayFromArray:(NSArray*)arr
{
    NSMutableArray* tempArray = [NSMutableArray new];

    for (NSDictionary* dict in arr) {
        NSMutableDictionary* filterDict = [NSMutableDictionary new];
        [filterDict setObject:[dict objectForKey:@"Description"] forKey:@"Description"];
        [filterDict setObject:[dict objectForKey:@"ImgUrl"] forKey:@"ImgUrl"];
        [filterDict setObject:[dict objectForKey:@"Title"] forKey:@"Title"];//HDRID
        [filterDict setObject:[dict objectForKey:@"HDRID"] forKey:@"Identifier"];
        [tempArray addObject:filterDict];
    }
    return [NSArray arrayWithArray:tempArray];
}
+ (NSArray*)getFilteredArrayFromArrayForPrayers:(NSArray*)arr
{
    NSMutableArray* tempArray = [NSMutableArray new];
    
    for (NSDictionary* dict in arr) {
        NSMutableDictionary* filterDict = [NSMutableDictionary new];
        [filterDict setObject:[dict objectForKey:@"Description"] forKey:@"Description"];
        [filterDict setObject:[dict objectForKey:@"ExternalUrl"] forKey:@"ExternalUrl"];
        [filterDict setObject:[dict objectForKey:@"Title"] forKey:@"Title"];
        [tempArray addObject:filterDict];
    }
    return [NSArray arrayWithArray:tempArray];
}
+ (NSArray*)getFilteredArrayFromArrayForBooks:(NSArray*)arr
{
    NSMutableArray* tempArray = [NSMutableArray new];

    for (NSDictionary* dict in arr) {
        NSMutableDictionary* filterDict = [NSMutableDictionary new];
        [filterDict setObject:[dict objectForKey:@"ExternalUrl"] forKey:@"Description"];
        [filterDict setObject:[dict objectForKey:@"ImgUrl"] forKey:@"ImgUrl"];
        [filterDict setObject:[dict objectForKey:@"Title"] forKey:@"Title"];
        [tempArray addObject:filterDict];
    }
    return [NSArray arrayWithArray:tempArray];
}

+ (NSArray*)getFilteredArrayFromArrayForHolyPlaces:(NSArray*)arr
{
    NSMutableArray* tempArray = [NSMutableArray new];

    for (NSDictionary* dict in arr) {
        NSMutableDictionary* filterDict = [NSMutableDictionary new];
        [filterDict setObject:[dict objectForKey:@"Description"] forKey:@"Description"];
        [filterDict setObject:[dict objectForKey:@"ImgUrl"] forKey:@"ImgUrl"];
        [filterDict setObject:[dict objectForKey:@"Title"] forKey:@"Title"];
        [filterDict setObject:[dict objectForKey:@"Location"] forKey:@"Location"];
        [filterDict setObject:[dict objectForKey:@"HDRID"] forKey:@"Identifier"];
        [tempArray addObject:filterDict];
    }
    return [NSArray arrayWithArray:tempArray];
}


+ (NSArray*)getArrayOfFestivalDetailModel:(NSDictionary*)dict
{
    NSMutableArray* tempArray = [NSMutableArray new];
    
    if([[dict objectForKey:@"Intro_Desc"] length] > 0){
    DetailsModel *model1 = [DetailsModel new];
    model1.title = [dict objectForKey:@"Intro_Title"];
    model1.content = [dict objectForKey:@"Intro_ImgPath"];
    model1.details = [dict objectForKey:@"Intro_Desc"];
    [tempArray addObject:model1];
    }
    
    if([[dict objectForKey:@"History_Desc"] length] > 0){
    DetailsModel *model2 = [DetailsModel new];
    model2.title = [dict objectForKey:@"History_Title"];
    model2.content = [dict objectForKey:@"History_ImgPath"];
    model2.details = [dict objectForKey:@"History_Desc"];
    [tempArray addObject:model2];
    }
    
    if([[dict objectForKey:@"WhyCele_Desc"] length] > 0){
    DetailsModel *model3 = [DetailsModel new];
    model3.title = [dict objectForKey:@"WhyCele_Title"];
    model3.content = [dict objectForKey:@"WhyCele_ImgPath"];
    model3.details = [dict objectForKey:@"WhyCele_Desc"];
    [tempArray addObject:model3];
    }
    
    if([[dict objectForKey:@"Cele_Desc"] length] > 0){
    DetailsModel *model4 = [DetailsModel new];
    model4.title = [dict objectForKey:@"Cele_Title"];
    model4.details = [dict objectForKey:@"Cele_Desc"];
    [tempArray addObject:model4];
    }
    
    if([[dict objectForKey:@"RC_Desc"] length] > 0){
    DetailsModel *model5 = [DetailsModel new];
    model5.title = [dict objectForKey:@"RC_Title"];
    model5.content = [dict objectForKey:@"RC_ImgPath"];
    model5.details = [dict objectForKey:@"RC_Desc"];
    [tempArray addObject:model5];
    }
    
    return tempArray;
}

+ (NSArray*)getArrayOfCeremonyDetailModel:(NSDictionary*)dict
{
    NSMutableArray* tempArray = [NSMutableArray new];
    
    if([[dict objectForKey:@"Intro_Desc"] length] > 0){
    DetailsModel *model1 = [DetailsModel new];
    model1.title = [dict objectForKey:@"Intro_Title"];
    model1.content = [dict objectForKey:@"Intro_ImgPath"];
    model1.details = [dict objectForKey:@"Intro_Desc"];
    [tempArray addObject:model1];
    }
    
    if([[dict objectForKey:@"HowToPerform_Desc"] length] > 0){
    DetailsModel *model2 = [DetailsModel new];
    model2.title = [dict objectForKey:@"HowToPerform_Title"];
    model2.content = [dict objectForKey:@"HowToPerform_ImgPath"];
    model2.details = [dict objectForKey:@"HowToPerform_Desc"];
    [tempArray addObject:model2];
    }
    
    if([[dict objectForKey:@"Beliefs_Desc"] length] > 0){
    DetailsModel *model3 = [DetailsModel new];
    model3.title = [dict objectForKey:@"Beliefs_Title"];
    model3.content = [dict objectForKey:@"Beliefs_ImgPath"];
    model3.details = [dict objectForKey:@"Beliefs_Desc"];
    [tempArray addObject:model3];
    }
    
    return tempArray;
}

+ (NSArray*)getArrayOfHolyPlaceDetailModel:(NSDictionary*)dict
{
    NSMutableArray* tempArray = [NSMutableArray new];
    
    if([[dict objectForKey:@"Intro_Desc"] length] > 0){
    DetailsModel *model1 = [DetailsModel new];
    model1.title = [dict objectForKey:@"Intro_Title"];
    model1.content = [dict objectForKey:@"Intro_ImgPath"];
    model1.details = [dict objectForKey:@"Intro_Desc"];
    [tempArray addObject:model1];
    }
    
    if([[dict objectForKey:@"Location_Desc"] length] > 0){
    DetailsModel *model2 = [DetailsModel new];
    model2.title = @"Location";
    model2.details = [dict objectForKey:@"Location_Desc"];
    [tempArray addObject:model2];
    }
    
    if([[dict objectForKey:@"State_Desc"] length] > 0){
    DetailsModel *model3 = [DetailsModel new];
    model3.title = @"State";
    model3.details = [dict objectForKey:@"State_Desc"];
    [tempArray addObject:model3];
    }
    
    if([[dict objectForKey:@"Country_Desc"] length] > 0){
    DetailsModel *model4 = [DetailsModel new];
    model4.title = @"Country";
    model4.details = [dict objectForKey:@"Country_Desc"];
    [tempArray addObject:model4];
    }
    
    if([[dict objectForKey:@"ByBus_Desc"] length] > 0){
    DetailsModel *model5 = [DetailsModel new];
    model5.title = @"By Bus";
    model5.details = [dict objectForKey:@"ByBus_Desc"];
    [tempArray addObject:model5];
    }
    
    if([[dict objectForKey:@"ByTrain_Desc"] length] > 0){
    DetailsModel *model6 = [DetailsModel new];
    model6.title = @"By Train";
    model6.details = [dict objectForKey:@"ByTrain_Desc"];
    [tempArray addObject:model6];
    }
    
    if([[dict objectForKey:@"ByAir_Desc"] length] > 0){
    DetailsModel *model7 = [DetailsModel new];
    model7.title = @"By Air";
    model7.details = [dict objectForKey:@"ByAir_Desc"];
    [tempArray addObject:model7];
    }
    
    if([[dict objectForKey:@"History_Desc"] length] > 0){
    DetailsModel *model8 = [DetailsModel new];
    model8.title = [dict objectForKey:@"History_Title"];
    model8.content = [dict objectForKey:@"History_ImgPath"];
    model8.details = [dict objectForKey:@"History_Desc"];
    [tempArray addObject:model8];
    }
    
    return tempArray;
}


+ (NSArray*)getArrayOfFoodDetailModel:(NSDictionary*)dict
{
    NSMutableArray* tempArray = [NSMutableArray new];
    
    if([[dict objectForKey:@"Ingredients"] length] > 0){
        DetailsModel *model1 = [DetailsModel new];
        model1.title = @"Ingredients";
        model1.content = [dict objectForKey:@"ImgPath"];
        model1.details = [dict objectForKey:@"Ingredients"];
        [tempArray addObject:model1];
    }
    
    if([[dict objectForKey:@"Method"] length] > 0){
        DetailsModel *model2 = [DetailsModel new];
        model2.title = @"Method";
        model2.details = [dict objectForKey:@"Method"];
        [tempArray addObject:model2];
    }
    
    return tempArray;
}
@end
