//
//  ViewController.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "BooksViewController.h"
#import "DemoCollectionViewCell.h"
#import "AsyncImageView.h"
#import "SWRevealViewController.h"
#import "AFNetworkFacade.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "BooksWebViewController.h"

@interface BooksViewController ()

@end

@implementation BooksViewController

#pragma mark - Public

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];

    [self.view sendSubviewToBack:_collectionView];
    [_collectionView setDelegate:self];
    SWRevealViewController* revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sideBarButton setTarget:self.revealViewController];
        [self.sideBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.layoutType = EBCardCollectionLayoutVertical;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getBookswithSuccessBlock:^(NSArray* array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSArray* peopleData = array;
                _people = [[NSMutableArray alloc] init];

                for (NSDictionary* personDict in peopleData) {
                    Person* aPerson = [[Person alloc] initWithDictionary:personDict];
                    [_people addObject:aPerson];
                }
                [_collectionView reloadData];
            });
        } andFailureBlock:^(NSString* urlResponse, NSError* error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                _people = [[NSMutableArray alloc] init];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"Coming Soon !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

            });
        }];

    });

    //  The bigger the offset, the more you see on previous / next cards.

    UIOffset anOffset = UIOffsetZero;
    if (_layoutType == EBCardCollectionLayoutHorizontal) {

        anOffset = UIOffsetMake(40, 10);
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setOffset:anOffset];
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setLayoutType:EBCardCollectionLayoutHorizontal];
    }
    else {
        anOffset = UIOffsetMake(20, 100);
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setCardHght:280];
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
    return [_people count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{

    DemoCollectionViewCell* retVal = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell"
                                                                               forIndexPath:indexPath];
    retVal.person = _people[indexPath.row];
    return retVal;
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{

    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    BooksWebViewController* controller = (BooksWebViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"bookswebvc"];
    //controller.booksPage
    Person* book = _people[indexPath.row];
    NSString* urlString = book.desc;
    if ([urlString length] > 7) {
        controller.booksurl = urlString;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (BOOL)shouldAutorotate
{
    [_collectionView.collectionViewLayout invalidateLayout];

    BOOL retVal = YES;
    return retVal;
}

@end
