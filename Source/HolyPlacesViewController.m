//
//  ViewController.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "HolyPlacesViewController.h"
#import "HolyPlacesCollectionViewCell.h"
#import "AsyncImageView.h"
#import "SWRevealViewController.h"
#import "AFNetworkFacade.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "PrayersViewController.h"

@interface HolyPlacesViewController ()

@end

@implementation HolyPlacesViewController

#pragma mark - Public

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];

    [self.view sendSubviewToBack:_collectionView];
    SWRevealViewController* revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sideBarButton setTarget:self.revealViewController];
        [self.sideBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.layoutType = EBCardCollectionLayoutVertical;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_collectionView setDelegate:self];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getHolyPlaceswithSuccessBlock:^(NSArray* array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSArray* peopleData = array;
                _place = [[NSMutableArray alloc] init];

                for (NSDictionary* personDict in peopleData) {
                    HolyPlaces* aPerson = [[HolyPlaces alloc] initWithDictionary:personDict];
                    [_place addObject:aPerson];
                }
                [_collectionView reloadData];
            });
        } andFailureBlock:^(NSString* urlResponse, NSError* error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                _place = [[NSMutableArray alloc] init];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"Coming Soon !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

            });
        }];

    });

    //  The bigger the offset, the more you see on previous / next cards.

    UIOffset anOffset = UIOffsetZero;

    if (_layoutType == EBCardCollectionLayoutHorizontal) {
        self.title = @"Horizontal Scrolling";
        anOffset = UIOffsetMake(40, 10);
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setOffset:anOffset];
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setLayoutType:EBCardCollectionLayoutHorizontal];
    }
    else {
        self.title = @"Vertical Scrolling";
        anOffset = UIOffsetMake(20, 20);
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setCardHght:431];
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setOffset:anOffset];
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setLayoutType:EBCardCollectionLayoutVertical];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _collectionView.contentOffset = CGPointMake(0, 0);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_place count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{

    HolyPlacesCollectionViewCell* retVal = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell"
                                                                                     forIndexPath:indexPath];
    retVal.place = _place[indexPath.row];
    return retVal;
}
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath{

    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PrayersViewController* controller = (PrayersViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"prayers"];
    controller.isHolyPlaceDetailsView = YES;
    HolyPlaces* aPerson = _place[indexPath.row];
    controller.idString = aPerson.identfier;
    controller.header = aPerson.name;
    [self.navigationController pushViewController:controller animated:YES];
}
- (BOOL)shouldAutorotate
{
    [_collectionView.collectionViewLayout invalidateLayout];

    BOOL retVal = YES;
    return retVal;
}

@end
