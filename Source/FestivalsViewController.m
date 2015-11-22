//
//  ViewController.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "FestivalsViewController.h"
#import "DemoCollectionViewCell.h"
#import "AsyncImageView.h"
#import "SWRevealViewController.h"
#import "AFNetworkFacade.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "PrayersViewController.h"

@interface FestivalsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView* headerImgView;
@property (weak, nonatomic) IBOutlet UILabel* headerBanner;
@property (weak, nonatomic) IBOutlet UILabel* subtitleBanner;

@end

@implementation FestivalsViewController

#pragma mark - Public
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];

    SWRevealViewController* revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sideBarButton setTarget:self.revealViewController];
        [self.sideBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.layoutType = EBCardCollectionLayoutVertical;
    [_collectionView setDelegate:self];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if (_isCeremony) {
        [self showCeremony];
    }
    else if (_isTraditionalWear) {
        [self showTraditionalWear];
    }
    else if (_isTraditionalArt) {
        [self showTraditionalArt];
    }
    else if (_isTraditionalFood) {
        [self showTraditionalFood];
    }
    else if(_isYoga){
        [self showYoga];
    }
    else {
        [self showFestival];
    }

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
        //[(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setCardWdth:280];
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setCardHght:_isTraditionalFood?300:431];
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setOffset:anOffset];
        [(EBCardCollectionViewLayout*)_collectionView.collectionViewLayout setLayoutType:EBCardCollectionLayoutVertical];
    }
}

- (void)showCeremony
{
    [self.headerImgView setImage:[UIImage imageNamed:@"Ceremony@3x"]];
    self.headerBanner.text = @"Ceremony";
    self.headerBanner.textColor = [UIColor whiteColor];
    self.subtitleBanner.textColor = [UIColor yellowColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getCeremonyswithSuccessBlock:^(NSArray* array) {
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
}

- (void)showFestival
{
    self.headerBanner.text = @"Festival";
    [self.headerImgView setImage:[UIImage imageNamed:@"Festival Banner@3x"]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getFestivalswithSuccessBlock:^(NSArray* array) {
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
}
- (void)showTraditionalWear
{
    [self.headerImgView setImage:[UIImage imageNamed:@"Traditional Wear@3x"]];
    self.headerBanner.text = @"Traditional Wear";
    self.headerBanner.textColor = [UIColor whiteColor];
    self.subtitleBanner.textColor = [UIColor yellowColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getTraditionalWearwithSuccessBlock:^(NSArray* array) {
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
}
- (void)showTraditionalFood
{
    [self.headerImgView setImage:[UIImage imageNamed:@"Traditional Food@3x"]];
    self.headerBanner.text = @"Traditional Food";
    self.headerBanner.textColor = [UIColor whiteColor];
    self.subtitleBanner.textColor = [UIColor yellowColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getTraditionalFoodwithSuccessBlock:^(NSArray* array) {
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
}
- (void)showTraditionalArt
{
    [self.headerImgView setImage:[UIImage imageNamed:@"Traditional Art@3x"]];
    self.headerBanner.textColor = [UIColor whiteColor];
    self.subtitleBanner.textColor = [UIColor yellowColor];
    self.headerBanner.text = @"Traditional Art";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getTraditionalArtwithSuccessBlock:^(NSArray* array) {
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
}
- (void)showYoga
{
    [self.headerImgView setImage:[UIImage imageNamed:@"Traditional Food@3x"]];
    self.headerBanner.text = @"Yoga";
    self.headerBanner.textColor = [UIColor whiteColor];
    self.subtitleBanner.textColor = [UIColor yellowColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getYogaswithSuccessBlock:^(NSArray* array) {
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
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _collectionView.contentOffset = CGPointMake(0, 0);
//    _isCeremony = NO;
//    _isTraditionalArt = NO;
//    _isTraditionalFood = NO;
//    _isTraditionalWear = NO;
//    _isYoga = NO;
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

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath{
    
    if(_isCeremony){
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        PrayersViewController* controller = (PrayersViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"prayers"];
        controller.isCeremonyDetailsView = YES;
        Person* aPerson = _people[indexPath.row];
        controller.idString = aPerson.identfier;
        controller.header = aPerson.name;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if(_isTraditionalArt){
        
    }
    else if(_isTraditionalFood){
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        PrayersViewController* controller = (PrayersViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"prayers"];
        controller.isFoodDetailsView = YES;
        Person* aPerson = _people[indexPath.row];
        controller.idString = aPerson.identfier;
        controller.header = aPerson.name;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if(_isTraditionalWear){
        
    }
    else if(_isYoga){
        
    }
    else{
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        PrayersViewController* controller = (PrayersViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"prayers"];
        controller.isFestivalDetailsView = YES;
        Person* aPerson = _people[indexPath.row];
        controller.idString = aPerson.identfier;
        controller.header = aPerson.name;
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
