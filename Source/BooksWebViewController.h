//
//  BooksWebViewController.h
//  EAIntroView
//
//  Created by KrunalSoni on 04/08/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksWebViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView* booksPage;
@property (nonatomic, strong) NSString* booksurl;

@end
