//
//  AFNetworkFacade.m
//  EAIntroView
//
//  Created by KrunalSoni on 30/07/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import "AFNetworkFacade.h"
#import "Constants.h"
#import "Parser.h"
#import "KeychainUtil.h"

#define religionContext @"/api/urd/Religion?religionid=0"
#define casteContext @"/api/urd/CastByRelID?religionid=%@"
#define registerUserContext @"/api/urd/userreg"
#define loginContext @"/api/urd/ValidateUser"
#define festivalContext @"/api/urd/Festival"//Festival
#define yogaContext @"/api/urd/Yoga"
#define booksContext @"/api/urd/Books"
#define ceremonyContext @"/api/urd/Ceremony"
#define prayerContext @"/api/urd/Prayers"
#define mantraContext @"/api/urd/Mantras"
#define holyplacesContext @"/api/urd/HolyPlaces"
#define calendarContext @"/api/urd/Calendar"
#define forgotPasswordContext @"/api/urd/ForgetPassword"
#define traditionalArtContext @"/api/urd/TrdArt"
#define traditionalWearContext @"/api/urd/TradWear"
#define traditionalFoodContext @"/api/urd/TrdFood"
#define festivalDetailsContext @"/api/cdd/Festival"
#define ceremonyDetailsContext @"/api/cdd/Ceremony"
#define holyPlaceDetailsContext @"/api/cdd/HolyPlace"//TraditionFood
#define foodDetailsContext @"/api/cdd/TraditionFood"

@implementation AFNetworkFacade
+ (void)getReligionwithSuccessBlock:(successResponseBlock)success andFailureBlock:(completionBlock)failure
{
    //Where request is going
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];

    NSString* path = [NSString stringWithFormat:@"%@%@", BASE_URL, religionContext];

    //Tell operation to expect JSON
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];

    //Start spinner

    //Set up actual GET request
    [httpClient getPath:path
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {

            //Stop spinning

            //Make the response JSON valid
            if (responseObject) {
                success([Parser getCasteReligionDictionary:responseObject]);
            }
        }

        failure:^(AFHTTPRequestOperation* operation, NSError* error) {

            failure(nil, nil);
            //Error
            NSLog(@"%@", error);

        }];
}

+ (void)getCasteWithReligionId:(NSString*)relID withSuccessBlock:(successResponseBlock)success andFailureBlock:(completionBlock)failure
{
    //Where request is going
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];

    NSString* path = [NSString stringWithFormat:@"%@%@", BASE_URL, casteContext];
    path = [NSString stringWithFormat:path, relID];

    //Tell operation to expect JSON
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];

    //Start spinner

    //Set up actual GET request
    [httpClient getPath:path
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {

            //Stop spinning

            //Make the response JSON valid
            if (responseObject) {
                success([Parser getCasteReligionDictionary:responseObject]);
            }
        }

        failure:^(AFHTTPRequestOperation* operation, NSError* error) {

            failure(nil, nil);
            //Error
            NSLog(@"%@", error);

        }];
}

+ (void)registerNewUserWithDict:(NSDictionary*)dict withSuccessBlock:(successResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = dict;
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:registerUserContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([[json objectForKey:@"_RetMessage"] caseInsensitiveCompare:@"Register Successfully"] == NSOrderedSame) {
                success(nil);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}

+ (void)loginUserWithDict:(NSDictionary*)dict withSuccessBlock:(successResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = dict;
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:loginContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([[json objectForKey:@"_RetMessage"] caseInsensitiveCompare:@"Login Successfully"] == NSOrderedSame) {
                success([Parser getReligion:json]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}
+ (void)forgotPasswordDict:(NSDictionary*)dict withSuccessBlock:(completionBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = dict;
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:forgotPasswordContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([[json objectForKey:@"_RetMessage"] caseInsensitiveCompare:@"Login Successfully"] == NSOrderedSame) {
                success([json objectForKey:@"_RetMessage"], nil);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}
+ (void)getFestivalswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:festivalContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* festivalArray = [json objectForKey:@"_RetData"];
            if ([festivalArray count] > 0) {
                success([Parser getFilteredArrayFromArray:festivalArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}
+ (void)getYogaswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient postPath:yogaContext
              parameters:params
                 success:^(AFHTTPRequestOperation* operation, id responseObject) {
                     // Print the response body in text
                     NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                     id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     NSArray* yogaArray = [json objectForKey:@"_RetData"];
                     if ([yogaArray count] > 0) {
                         success([Parser getFilteredArrayFromArray:yogaArray]);
                     }
                     else {
                         failure([json objectForKey:@"_RetMessage"], nil);
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                     failure(nil, error);
                 }];
}
+ (void)getBookswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:booksContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* booksArray = [json objectForKey:@"_RetData"];
            if ([booksArray count] > 0) {
                success([Parser getFilteredArrayFromArrayForBooks:booksArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}
+ (void)getCeremonyswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:ceremonyContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* ceremonyArray = [json objectForKey:@"_RetData"];
            if ([ceremonyArray count] > 0) {
                success([Parser getFilteredArrayFromArray:ceremonyArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}

+ (void)getPrayerwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:prayerContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* prayerArray = [json objectForKey:@"_RetData"];
            if ([prayerArray count] > 0) {
                success([Parser getFilteredArrayFromArrayForPrayers:prayerArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}

+ (void)getMantrawithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:mantraContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* mantraArray = [json objectForKey:@"_RetData"];
            success([Parser getFilteredArrayFromArray:mantraArray]);

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}
+ (void)getHolyPlaceswithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:holyplacesContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* ceremonyArray = [json objectForKey:@"_RetData"];
            if ([ceremonyArray count] > 0) {
                success([Parser getFilteredArrayFromArrayForHolyPlaces:ceremonyArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}

+ (void)getCalendarwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:calendarContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* ceremonyArray = [json objectForKey:@"_RetData"];
            if ([ceremonyArray count] > 0) {
                success([Parser getFilteredArrayFromArray:ceremonyArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}

+ (void)getForgotPasswordwithSuccessBlock:(completionBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:forgotPasswordContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            success([json objectForKey:@"_RetMessage"], nil);

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            failure([json objectForKey:@"_RetMessage"], nil);
        }];
}

+ (void)getTraditionalArtwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:traditionalArtContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* festivalArray = [json objectForKey:@"_RetData"];
            if ([festivalArray count] > 0) {
                success([Parser getFilteredArrayFromArray:festivalArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}
+ (void)getTraditionalWearwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:traditionalWearContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* festivalArray = [json objectForKey:@"_RetData"];
            if ([festivalArray count] > 0) {
                success([Parser getFilteredArrayFromArray:festivalArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}

+ (void)getTraditionalFoodwithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    NSDictionary* params = @{ USER_ID : [self getUserID] };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:traditionalFoodContext
        parameters:params
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // Print the response body in text
            NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* festivalArray = [json objectForKey:@"_RetData"];
            if ([festivalArray count] > 0) {
                success([Parser getFilteredArrayFromArray:festivalArray]);
            }
            else {
                failure([json objectForKey:@"_RetMessage"], nil);
            }

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            failure(nil, error);
        }];
}

+ (void)getFestivalDetailForFestivalId:(NSString*)festID WithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    NSDictionary* params = @{ FESTIVAL_ID : festID };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient postPath:festivalDetailsContext
              parameters:params
                 success:^(AFHTTPRequestOperation* operation, id responseObject) {
                     // Print the response body in text
                     NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                     id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     NSArray* festivalArray = [json objectForKey:@"_RetData"];
                     NSDictionary* dict = [festivalArray objectAtIndex:0];
                     if ([[dict allKeys] count] > 0) {
                         success([Parser getArrayOfFestivalDetailModel:dict]);
                     }
                     else {
                         failure([json objectForKey:@"_RetMessage"], nil);
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                     failure(nil, error);
                 }];
}

+ (void)getCeremonyDetailForCeremonyId:(NSString*)festID WithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    NSDictionary* params = @{ CEREMONY_ID : festID };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient postPath:ceremonyDetailsContext
              parameters:params
                 success:^(AFHTTPRequestOperation* operation, id responseObject) {
                     // Print the response body in text
                     NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                     id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     NSArray* festivalArray = [json objectForKey:@"_RetData"];
                     NSDictionary* dict = [festivalArray objectAtIndex:0];
                     if ([[dict allKeys] count] > 0) {
                         success([Parser getArrayOfCeremonyDetailModel:dict]);
                     }
                     else {
                         failure([json objectForKey:@"_RetMessage"], nil);
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                     failure(nil, error);
                 }];
}

+ (void)getHolyPlaceDetailForHolyPlace:(NSString*)festID WithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    NSDictionary* params = @{ HOLYPLACE_ID : festID };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient postPath:holyPlaceDetailsContext
              parameters:params
                 success:^(AFHTTPRequestOperation* operation, id responseObject) {
                     // Print the response body in text
                     NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                     id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     NSArray* festivalArray = [json objectForKey:@"_RetData"];
                     NSDictionary* dict = [festivalArray objectAtIndex:0];
                     if ([[dict allKeys] count] > 0) {
                         success([Parser getArrayOfHolyPlaceDetailModel:dict]);
                     }
                     else {
                         failure([json objectForKey:@"_RetMessage"], nil);
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                     failure(nil, error);
                 }];
}

+ (void)getFoodDetailForFoodId:(NSString*)festID WithSuccessBlock:(successArrResponseBlock)success andFailureBlock:(completionBlock)failure
{
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    NSDictionary* params = @{ FOOD_ID : festID };
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient postPath:foodDetailsContext
              parameters:params
                 success:^(AFHTTPRequestOperation* operation, id responseObject) {
                     // Print the response body in text
                     NSData* data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                     id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     NSArray* festivalArray = [json objectForKey:@"_RetData"];
                     NSDictionary* dict = [festivalArray objectAtIndex:0];
                     if ([[dict allKeys] count] > 0) {
                         success([Parser getArrayOfFoodDetailModel:dict]);
                     }
                     else {
                         failure([json objectForKey:@"_RetMessage"], nil);
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                     failure(nil, error);
                 }];
}


+ (NSString*)getUserID
{
    NSString* str = [KeychainUtil keychainStringFromMatchingIdentifier:kUserId];
    return str;
}
@end
