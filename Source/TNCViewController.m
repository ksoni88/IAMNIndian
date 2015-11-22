//
//  TNCViewController.m
//  EAIntroView
//
//  Created by KrunalSoni on 09/08/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import "TNCViewController.h"

@implementation TNCViewController
- (void)viewDidLoad
{
    self.title = @"Terms & Conditions";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"Terms_Condition" ofType:@"html"];

    NSURL* localHTMLURL = [NSURL fileURLWithPath:htmlPath isDirectory:NO];
    NSURLRequest* request = [NSURLRequest requestWithURL:localHTMLURL
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:60];
    [self.webview loadRequest:request];
}
- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
