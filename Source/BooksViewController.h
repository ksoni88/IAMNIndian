//
//  ViewController.h
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EBCardCollectionViewLayout.h"

@interface BooksViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    NSMutableArray* _people;
    __weak IBOutlet UICollectionView* _collectionView;
}

@property (assign) EBCardCollectionLayoutType layoutType;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* sideBarButton;
@end