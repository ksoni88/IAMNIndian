//
//  BooksWebViewController.m
//  EAIntroView
//
//  Created by KrunalSoni on 04/08/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import "BooksWebViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
@import UIKit;

@implementation BooksWebViewController
- (void)viewDidLoad
{

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];

    // Toggle the network activity indicator
    // Check if the indicator is on
    if (![UIApplication sharedApplication].isNetworkActivityIndicatorVisible) {
        // Turn the indicator on
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    else {

        // Turn the indicator off
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    NSURL* url = [NSURL URLWithString:self.booksurl];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    [self.booksPage loadRequest:urlRequest];
}
- (void)webViewDidFinishLoad:(UIWebView*)webView
{

    // Toggle the network activity indicator
    // Check if the indicator is on
    if (![UIApplication sharedApplication].isNetworkActivityIndicatorVisible) {

        // Turn the indicator on
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    else {

        // Turn the indicator off
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.booksPage stopLoading];
    // Toggle the network activity indicator
    // Check if the indicator is on
    if (![UIApplication sharedApplication].isNetworkActivityIndicatorVisible) {

        // Turn the indicator on
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    else {

        // Turn the indicator off
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

@end
