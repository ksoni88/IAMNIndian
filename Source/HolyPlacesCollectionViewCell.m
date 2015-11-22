//
//  EBCardCollectionViewCell.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "HolyPlacesCollectionViewCell.h"

#define kHorizontalOffset 10

@implementation HolyPlacesCollectionViewCell

#pragma mark - Properties

- (void)setPlace:(HolyPlaces*)person
{
    _place = person;
    _personImageView.imageURL = [NSURL URLWithString:_place.avatarFilename];
    _personNameLabel.text = _place.name;
    _locationNameLabel.text = _place.location;
    _description.text = _place.desc;
}

@end
