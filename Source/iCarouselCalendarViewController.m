//
//  iCarouselExampleViewController.m
//  iCarouselExample
//
//  Created by Nick Lockwood on 03/04/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import "iCarouselCalendarViewController.h"
#import "SWRevealViewController.h"
#import "AsyncImageView.h"
#import "AFNetworkFacade.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface iCarouselCalendarViewController ()

@property (nonatomic, strong) NSMutableArray* items;

@end

@implementation iCarouselCalendarViewController

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

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

    //configure carousel
    _carousel.type = iCarouselTypeCylinder; //iCarouselTypeCoverFlow2;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [AFNetworkFacade getCalendarwithSuccessBlock:^(NSArray* array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                for (NSDictionary* personDict in array) {
                    [_items addObject:personDict[@"ImgUrl"]];
                }
                [self.carousel reloadData];
            });
        } andFailureBlock:^(NSString* urlResponse, NSError* error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                _items = nil;
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"Coming Soon !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

            });
        }];

    });
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    //free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel*)carousel
{
    //return the total number of items in the carousel
    return [_items count];
}

- (UIView*)carousel:(iCarousel*)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView*)view
{
    //create new view if no view is available for recycling
    if (view == nil) {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            view = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 600.0f, 600.0f)];
            ((AsyncImageView*)view).imageURL = [NSURL URLWithString:_items[index]];
            view.contentMode = UIViewContentModeScaleAspectFill;

        }else{
        
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if (result.height == 960) {
                
                view = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 250.0f, 250.0f)];
            }
            else {
                view = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
            }
            
            ((AsyncImageView*)view).imageURL = [NSURL URLWithString:_items[index]];
            view.contentMode = UIViewContentModeScaleAspectFill;
        
        }
    }
    else {
        //get a reference to the label in the recycled view
    }

    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel

    return view;
}

- (CGFloat)carousel:(iCarousel*)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing) {
        return value * 1.1;
    }
    return value;
}

@end
