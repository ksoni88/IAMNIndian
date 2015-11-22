//
//  EBCardCollectionViewCell.h
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "AsyncImageView.h"

@interface DemoCollectionViewCell : UICollectionViewCell {
    __weak IBOutlet AsyncImageView* _personImageView;
    __weak IBOutlet UILabel* _personNameLabel;
    __weak IBOutlet UILabel* _description;
}
@property (weak, nonatomic) Person* person;
@end
