//
//  ViewController.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 4/21/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "CustomViewController.h"
#import "MosaicLayout.h"
#import "MosaicData.h"
#import "CustomDataSource.h"
#import "SWRevealViewController.h"
#import "FestivalsViewController.h"
#import "BooksViewController.h"
#import "iCarouselCalendarViewController.h"
#import "PrayersViewController.h"
#import "HolyPlacesViewController.h"
#import "MuhuratVC.h"
#import "YogaViewController.h"

#define kDoubleColumnProbability 40

@interface CustomViewController ()
@end

@implementation CustomViewController

#pragma mark - Public

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];

    SWRevealViewController* revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    [(MosaicLayout*)_collectionView.collectionViewLayout setDelegate:self];
    [_collectionView setDelegate:self];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    MosaicLayout* layout = (MosaicLayout*)_collectionView.collectionViewLayout;
    [layout invalidateLayout];
}

#pragma mark - MosaicLayoutDelegate

- (float)collectionView:(UICollectionView*)collectionView relativeHeightForItemAtIndexPath:(NSIndexPath*)indexPath
{

    //  Base relative height for simple layout type. This is 1.0 (height equals to width)
    float retVal = 1.0;

    NSMutableArray* elements = [(CustomDataSource*)_collectionView.dataSource elements];
    MosaicData* aMosaicModule = [elements objectAtIndex:indexPath.row];

    if (aMosaicModule.relativeHeight != 0) {

        //  If the relative height was set before, return it
        retVal = aMosaicModule.relativeHeight;
    }
    else {

        BOOL isDoubleColumn = [self collectionView:collectionView isDoubleColumnAtIndexPath:indexPath];
        if (isDoubleColumn) {
            //  Base relative height for double layout type. This is 0.75 (height equals to 75% width)
            retVal = 0.75;
        }

        /*  Relative height random modifier. The max height of relative height is 25% more than
         *  the base relative height */

        float extraRandomHeight = arc4random() % 25;
        retVal = retVal + (extraRandomHeight / 100);

        /*  Persist the relative height on MosaicData so the value will be the same every time
         *  the mosaic layout invalidates */

        aMosaicModule.relativeHeight = retVal;
    }

    return retVal;
}

- (BOOL)collectionView:(UICollectionView*)collectionView isDoubleColumnAtIndexPath:(NSIndexPath*)indexPath
{
    NSMutableArray* elements = [(CustomDataSource*)_collectionView.dataSource elements];
    MosaicData* aMosaicModule = [elements objectAtIndex:indexPath.row];

    if (aMosaicModule.layoutType == kMosaicLayoutTypeUndefined) {

        /*  First layout. We have to decide if the MosaicData should be
         *  double column (if possible) or not. */

        NSUInteger random = arc4random() % 100;
        if (random < kDoubleColumnProbability) {
            aMosaicModule.layoutType = kMosaicLayoutTypeDouble;
        }
        else {
            aMosaicModule.layoutType = kMosaicLayoutTypeSingle;
        }
    }

    BOOL retVal = aMosaicModule.layoutType == kMosaicLayoutTypeDouble;

    return retVal;
}

- (NSUInteger)numberOfColumnsInCollectionView:(UICollectionView*)collectionView
{

    UIInterfaceOrientation anOrientation = self.interfaceOrientation;

    //  Set the quantity of columns according of the device and interface orientation
    NSUInteger retVal = 0;
    if (UIInterfaceOrientationIsLandscape(anOrientation)) {

        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            retVal = kColumnsiPadLandscape;
        }
        else {
            retVal = kColumnsiPhoneLandscape;
        }
    }
    else {

        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            retVal = kColumnsiPadPortrait;
        }
        else {
            retVal = kColumnsiPhonePortrait;
        }
    }

    return retVal;
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{

    //calendar,prayers,holyplaces,muhurats
    if (indexPath.row == 0) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        FestivalsViewController* controller = (FestivalsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"festivals"];
        controller.isCeremony = NO;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 1) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        BooksViewController* controller = (BooksViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"books"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 2) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        FestivalsViewController* controller = (FestivalsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"festivals"];
        controller.isCeremony = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 3) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        iCarouselCalendarViewController* controller = (iCarouselCalendarViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"calendar"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 4) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        PrayersViewController* controller = (PrayersViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"prayers"];
        controller.isPrayersView = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 5) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        HolyPlacesViewController* controller = (HolyPlacesViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"holyplaces"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 6) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        FestivalsViewController* controller = (FestivalsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"festivals"];
        controller.isTraditionalArt = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 7) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        FestivalsViewController* controller = (FestivalsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"festivals"];
        controller.isTraditionalFood = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 8) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        FestivalsViewController* controller = (FestivalsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"festivals"];
        controller.isTraditionalWear = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 9) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        FestivalsViewController* controller = (FestivalsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"festivals"];
        controller.isYoga = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 10) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        MuhuratVC* controller = (MuhuratVC*)[mainStoryboard instantiateViewControllerWithIdentifier:@"muhurats"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (BOOL)collectionView:(UICollectionView*)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath*)indexPath withSender:(id)sender
{
    return YES;
}
@end
