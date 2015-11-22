//
//  EBCardCollectionViewCell.h
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HolyPlaces.h"
#import "AsyncImageView.h"

@interface HolyPlacesCollectionViewCell : UICollectionViewCell {
    __weak IBOutlet AsyncImageView* _personImageView;
    __weak IBOutlet UILabel* _personNameLabel;
    __weak IBOutlet UILabel* _locationNameLabel;
    __weak IBOutlet UILabel* _description;
}
@property (weak, nonatomic) HolyPlaces* place;
@end
