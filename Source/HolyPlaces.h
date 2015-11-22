//
//  Person.h
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 10/4/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HolyPlaces : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)aDictionary;

@property (strong) NSString* name;
@property (strong, nonatomic) NSString* location;
@property (strong) NSString* avatarFilename;
@property (strong) NSString* desc;
@property (strong, nonatomic) NSString* identfier;
@end
