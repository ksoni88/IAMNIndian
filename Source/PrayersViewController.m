//
//  ViewController.m
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "PrayersViewController.h"
#import "DynamicHeightCell.h"
#import "DynamicDetailCell.h"
#import "SWRevealViewController.h"
#import "AFNetworkFacade.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "BooksWebViewController.h"
#import "UICollectionView+ARDynamicCacheHeightLayoutCell.h"

@interface PrayersViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout* flowLayout;

@property (nonatomic, strong) NSMutableArray* feeds;

@end

@implementation PrayersViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];
    
    if(_isPrayersView){
        SWRevealViewController* revealViewController = self.revealViewController;
        if (revealViewController) {
            [self.sideBarButton setTarget:self.revealViewController];
            [self.sideBarButton setAction:@selector(revealToggle:)];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
        [self showPrayer];
    }
    else if(_isFestivalDetailsView){
        [self showFestivalDetail];
    }
    else if(_isCeremonyDetailsView){
        [self showCeremonyDetail];
    }
    else if(_isHolyPlaceDetailsView){
        [self showHolyPlaceDetail];
    }
    else if(_isFoodDetailsView){
        [self showFoodDetail];
    }

    // Do any additional setup after loading the view, typically from a nib.
    [self.collectionView registerNib:[UINib nibWithNibName:@"DynamicHeightCell" bundle:nil] forCellWithReuseIdentifier:@"DynamicHeightCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DynamicDetailCell" bundle:nil] forCellWithReuseIdentifier:@"DynamicDetailCell"];

}

- (IBAction)revealToggle:(id)sender{
    [self.navigationController popViewControllerAnimated: YES];
}
-(void) viewWillDisappear:(BOOL)animated{
//    _isCeremonyDetailsView = NO;
//    _isFestivalDetailsView = NO;
//    _isHolyPlaceDetailsView = NO;
//    _isPrayersView = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - flowlayout

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    PrayerModel* feed = self.feeds[indexPath.row];

    if(_isPrayersView){
        return [collectionView ar_sizeForCellWithIdentifier:@"DynamicHeightCell"
                                              indexPath:indexPath
                                             fixedWidth:self.view.frame.size.width - 20
                                          configuration:^(id cell) {
                                              [cell filleCellWithFeed:feed];
                                          }];
    }
    else{
        return [collectionView ar_sizeForCellWithIdentifier:@"DynamicDetailCell"
                                                  indexPath:indexPath
                                                 fixedWidth:self.view.frame.size.width - 20
                                              configuration:^(id cell) {
                                                  [cell filleCellWithFeed:feed];
                                              }];
    }
}

#pragma mark - dataSource

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.feeds.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{

    if(_isPrayersView){
        DynamicHeightCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DynamicHeightCell" forIndexPath:indexPath];
        PrayerModel* feed = self.feeds[indexPath.row];
        [cell filleCellWithFeed:feed];
        return cell;
    }else{
        DetailsModel* feed = self.feeds[indexPath.row];
        
        if([[feed content] length]>0){
            DynamicDetailCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DynamicDetailCell" forIndexPath:indexPath];
            //DetailsModel* feed = self.feeds[indexPath.row];
            [cell filleCellWithFeed:feed];
            cell.userInteractionEnabled = NO;
            return cell;

        }else{
            DynamicHeightCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DynamicHeightCell" forIndexPath:indexPath];
            [cell filleCellWithDetail:feed];
            cell.userInteractionEnabled = NO;
            return cell;
 
        }
    }
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    if(_isPrayersView){
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        BooksWebViewController* controller = (BooksWebViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"bookswebvc"];
        PrayerModel* prayer = self.feeds[indexPath.row];
        NSString* urlString = prayer.details;
        if ([urlString length] > 7) {
            controller.booksurl = urlString;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark Helper Methods
- (void)showPrayer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFNetworkFacade getPrayerwithSuccessBlock:^(NSArray* array) {
        self.feeds = [NSMutableArray array];
        for (NSDictionary* aDictionary in array) {
            PrayerModel* feed = [[PrayerModel alloc] init];
            feed.title = aDictionary[@"Title"];
            feed.content = aDictionary[@"Description"];
            feed.details = aDictionary[@"ExternalUrl"];
            [self.feeds addObject:feed];
            [self.collectionView reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } andFailureBlock:^(NSString* urlResponse, NSError* error) {
        self.feeds = [NSMutableArray array];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)showFestivalDetail
{
    
    [self.sideBarButton setTarget:self];
    [self.sideBarButton setAction:@selector(revealToggle:)];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _lbl.text = self.header;
    [AFNetworkFacade getFestivalDetailForFestivalId:self.idString WithSuccessBlock:^(NSArray *array) {
        self.feeds = [[NSMutableArray alloc] initWithArray:array];
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } andFailureBlock:^(NSString *urlResponse, NSError *error) {
        self.feeds = [NSMutableArray array];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (void)showCeremonyDetail
{
    
    [self.sideBarButton setTarget:self];
    [self.sideBarButton setAction:@selector(revealToggle:)];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _lbl.text = self.header;
    [AFNetworkFacade getCeremonyDetailForCeremonyId:self.idString WithSuccessBlock:^(NSArray *array) {
        self.feeds = [[NSMutableArray alloc] initWithArray:array];
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } andFailureBlock:^(NSString *urlResponse, NSError *error) {
        self.feeds = [NSMutableArray array];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)showHolyPlaceDetail
{
    
    [self.sideBarButton setTarget:self];
    [self.sideBarButton setAction:@selector(revealToggle:)];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _lbl.text = self.header;
    [AFNetworkFacade getHolyPlaceDetailForHolyPlace:self.idString WithSuccessBlock:^(NSArray *array) {
        self.feeds = [[NSMutableArray alloc] initWithArray:array];
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } andFailureBlock:^(NSString *urlResponse, NSError *error) {
        self.feeds = [NSMutableArray array];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)showFoodDetail
{
    
    [self.sideBarButton setTarget:self];
    [self.sideBarButton setAction:@selector(revealToggle:)];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _lbl.text = self.header;
    [AFNetworkFacade getFoodDetailForFoodId:self.idString WithSuccessBlock:^(NSArray *array) {
        self.feeds = [[NSMutableArray alloc] initWithArray:array];
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } andFailureBlock:^(NSString *urlResponse, NSError *error) {
        self.feeds = [NSMutableArray array];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
@end
