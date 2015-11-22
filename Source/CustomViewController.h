//
//  ViewController.h
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 4/21/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MosaicLayoutDelegate.h"

#define kColumnsiPadLandscape 5
#define kColumnsiPadPortrait 4
#define kColumnsiPhoneLandscape 3
#define kColumnsiPhonePortrait 2

@interface CustomViewController : UIViewController <MosaicLayoutDelegate, UICollectionViewDelegate> {
    __weak IBOutlet UICollectionView* _collectionView;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem* sidebarButton;

@end
