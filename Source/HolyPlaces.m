//
//  Person.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 10/4/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "HolyPlaces.h"

@implementation HolyPlaces

#pragma mark - Properties

//- (NSString *)location {
//    NSString *retVal = [NSString stringWithFormat:@"@%@", _location];
//    return retVal;
//}

#pragma mark - Public

- (instancetype)initWithDictionary:(NSDictionary*)aDictionary
{
    self = [self init];
    if (self) {
        self.name = aDictionary[@"Title"];
        self.location = aDictionary[@"Location"];
        self.avatarFilename = aDictionary[@"ImgUrl"];
        self.desc = aDictionary[@"Description"];
        self.identfier = aDictionary[@"Identifier"];
    }
    return self;
}

@end
