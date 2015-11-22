//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "FestivalsViewController.h"
#import "Constants.h"
#import "KeychainUtil.h"
#import "PrayersViewController.h"

@interface SidebarTableViewController () {
    NSIndexPath* selectedIndex;
}

@end

@implementation SidebarTableViewController {
    NSArray* menuItems;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* religion = [KeychainUtil keychainStringFromMatchingIdentifier:kReligion];
    if ([religion caseInsensitiveCompare:@"hindu"] == NSOrderedSame) {

        menuItems = @[ @"title", @"news", @"comments", @"map", @"wishlist", @"calendar", @"bookmark", @"Holiday", @"Traditional art", @"Traditional Food", @"Traditional Wear", @"Yoga", @"Muhurats", @"Logout" ];
    }
    else {
        menuItems = @[ @"title", @"news", @"comments", @"map", @"wishlist", @"calendar", @"bookmark", @"Holiday", @"Traditional art", @"Traditional Food", @"Traditional Wear", @"Yoga", @"Logout" ];
    }
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return menuItems.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (indexPath == selectedIndex) {
        [cell setSelected:YES];
    }
    else {
        [cell setSelected:NO];
    }
    return cell;
}

- (void)tableView:(UITableView*)aTableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    selectedIndex = indexPath;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{

    // Set the title of navigation bar by using the menu items
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController* destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];

    //showCeremony
    if ([segue.identifier isEqualToString:@"showCeremony"]) {
        UINavigationController* navController = segue.destinationViewController;
        FestivalsViewController* ceremonyController = [navController childViewControllers].firstObject;
        ceremonyController.isCeremony = YES;
    }
    if ([segue.identifier isEqualToString:@"showFestival"]) {
        UINavigationController* navController = segue.destinationViewController;
        FestivalsViewController* ceremonyController = [navController childViewControllers].firstObject;
        ceremonyController.isCeremony = NO;
    }
    if ([segue.identifier isEqualToString:@"showArt"]) {
        UINavigationController* navController = segue.destinationViewController;
        FestivalsViewController* ceremonyController = [navController childViewControllers].firstObject;
        ceremonyController.isTraditionalArt = YES;
    }
    if ([segue.identifier isEqualToString:@"showWear"]) {
        UINavigationController* navController = segue.destinationViewController;
        FestivalsViewController* ceremonyController = [navController childViewControllers].firstObject;
        ceremonyController.isTraditionalWear = YES;
    }
    if ([segue.identifier isEqualToString:@"showFood"]) {
        UINavigationController* navController = segue.destinationViewController;
        FestivalsViewController* ceremonyController = [navController childViewControllers].firstObject;
        ceremonyController.isTraditionalFood = YES;
    }
    if ([segue.identifier isEqualToString:@"showYoga"]) {
        UINavigationController* navController = segue.destinationViewController;
        FestivalsViewController* ceremonyController = [navController childViewControllers].firstObject;
        ceremonyController.isYoga = YES;
    }
    if([segue.identifier isEqualToString:@"showPrayer"]){
        UINavigationController* navController = segue.destinationViewController;
        PrayersViewController* prayerVC = [navController childViewControllers].firstObject;
        prayerVC.isPrayersView = YES;

    }
}

@end
