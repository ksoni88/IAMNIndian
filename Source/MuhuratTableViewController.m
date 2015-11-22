//
//  ViewController.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "MuhuratTableViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"

@interface MuhuratTableViewController ()

@property (nonatomic, strong) NSArray* contents;

@end

@implementation MuhuratTableViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray*)contents
{
    if (!_contents) {

        NSString* pathString = [[NSBundle mainBundle] pathForResource:self.dataSourceName ofType:@"json"];
        NSData* elementsData = [NSData dataWithContentsOfFile:pathString];

        NSError* anError = nil;
        NSDictionary* parsedElements = [NSJSONSerialization JSONObjectWithData:elementsData
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&anError];

        NSArray* dataArray = [parsedElements objectForKey:self.dataSourceName];
        NSMutableArray* mutArray = [NSMutableArray new];
        for (NSDictionary* dict in dataArray) {

            NSArray* arr = @[ [dict objectForKey:@"date"], [NSString stringWithFormat:@"Time : %@", [dict objectForKey:@"Time"]], [NSString stringWithFormat:@"Nakshatra : %@", [dict objectForKey:@"Nakshatra"]], [NSString stringWithFormat:@"Tithi : %@", [dict objectForKey:@"Tithi"]] ];
            [mutArray addObject:arr];
        }
        _contents = @[ mutArray ];
    }

    return _contents;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];

    self.tableView.SKSTableViewDelegate = self;

    // In order to expand just one cell at a time. If you set this value YES, when you expand an cell, the already-expanded cell is collapsed automatically.
    self.tableView.shouldExpandOnlyOneCell = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView*)tableView numberOfSubRowsAtIndexPath:(NSIndexPath*)indexPath
{
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView*)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        return YES;
    }

    return NO;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"SKSTableViewCell";

    SKSTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor orangeColor];

    cell.expandable = YES;
    return cell;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForSubRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"UITableViewCell";

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;

    return cell;
}

- (CGFloat)tableView:(SKSTableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

- (void)tableView:(SKSTableView*)tableView didSelectSubRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

#pragma mark - Actions

- (void)collapseSubrows
{
    [self.tableView collapseCurrentlyExpandedIndexPaths];
}

- (void)refreshData
{
    NSArray* array = @[
        @[
           @[ @"Section0_Row0", @"Row0_Subrow1", @"Row0_Subrow2" ],
           @[ @"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12" ],
           @[ @"Section0_Row2" ]
        ]
    ];
    [self reloadTableViewWithData:array];

    [self setDataManipulationButton:UIBarButtonSystemItemUndo];
}

- (void)undoData
{
    [self reloadTableViewWithData:nil];

    [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
}

- (void)reloadTableViewWithData:(NSArray*)array
{
    self.contents = array;

    // Refresh data not scrolling
    //    [self.tableView refreshData];

    [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* sectionName = @"Muhurats";

    return sectionName;
}

#pragma mark - Helpers

- (void)setDataManipulationButton:(UIBarButtonSystemItem)item
{
    switch (item) {
    case UIBarButtonSystemItemUndo:
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                                                                                              target:self
                                                                                              action:@selector(undoData)];
        break;

    default:
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                              target:self
                                                                                              action:@selector(refreshData)];
        break;
    }
}

@end
