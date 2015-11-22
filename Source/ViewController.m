

#import "ViewController.h"
#import <SMPageControl/SMPageControl.h>
#import "SWRevealViewController.h"
#import "RegistrationViewController.h"
#import "AFViewShaker.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Constants.h"
#import "AFNetworkFacade.h"
#import "KeychainUtil.h"

@interface ViewController () {
    UIView* rootView;
    EAIntroView* _intro;
    UITextField* usernameTf;
    UITextField* passwordTf;
    AFViewShaker* viewShaker;
}

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // using self.navigationController.view - to display EAIntroView above navigation bar
    rootView = self.navigationController.view;
    NSString* str = [KeychainUtil keychainStringFromMatchingIdentifier:kUserId];
    if ([str length] > 0) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        SWRevealViewController* controller = (SWRevealViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"reveal"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else {
        [self setViewItems];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    usernameTf.text = @"";
    passwordTf.text = @"";
}
#pragma mark - Intro screen

- (void)showIntroWithCustomPages
{
    EAIntroPage* page1 = [EAIntroPage page];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Intro_H"]];
    CGRect frame = page1.titleIconView.frame;
    frame.size.height = self.view.frame.size.height - 130.0f;
    page1.titleIconView.frame = frame;
    page1.alpha = 0.75f;

    EAIntroPage* page2 = [EAIntroPage page];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Intro_M"]];
    page2.titleIconView.frame = frame;
    page2.alpha = 0.75f;

    EAIntroPage* page3 = [EAIntroPage page];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Intro_C"]];
    page3.titleIconView.frame = frame;
    page3.alpha = 0.75f;

    EAIntroView* intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[ page1, page2, page3 ]];
    intro.bgImage = [UIImage imageNamed:@"bg1"];

    UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, 0, 230, 40)];
    [btn setTitle:@"Explore" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 2.f;
    btn.layer.cornerRadius = 10;
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    intro.skipButton = btn;
    intro.skipButtonY = 60.f;
    intro.skipButtonAlignment = EAViewAlignmentCenter;
    intro.pageControlY = intro.skipButtonY + 10.0f;

    [intro setDelegate:self];
    [intro showInView:rootView animateDuration:0.3];
}

#pragma mark - EAIntroView delegate

- (void)introDidFinish:(EAIntroView*)introView
{
    NSLog(@"introDidFinish callback");
}
- (IBAction)done:(UIStoryboardSegue*)segue
{
    // Optional place to read data from closing controller
    usernameTf.text = @"";
    passwordTf.text = @"";
    [KeychainUtil deleteItemFromKeychainWithIdentifier:kUserId];
    [KeychainUtil deleteItemFromKeychainWithIdentifier:kPassword];
    [KeychainUtil deleteItemFromKeychainWithIdentifier:kReligion];
    [self setViewItems];
}
#pragma mark View setups
- (void)setViewItems
{

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];

    UIImageView* imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 5.0f, self.view.frame.size.width, 70)];
    imageV.image = [UIImage imageNamed:@"login-logo@3x"];
    [self.view addSubview:imageV];

    UILabel* loginlbl = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(self.view.center.x - 100.0f, 90, 200, 30))];
    NSMutableAttributedString* lstring = [[NSMutableAttributedString alloc] initWithString:@"Log In to Explore"];
    [lstring addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 6)];
    [lstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:20.0f] range:NSMakeRange(0, 17)];
    [lstring addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(7, 10)];
    [loginlbl setAttributedText:lstring];
    [loginlbl setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:loginlbl];

    UIImageView* starVC = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 140.0f, self.view.frame.size.width - 40.0f, 15)];
    starVC.image = [UIImage imageNamed:@"login-star@3x"];
    [self.view addSubview:starVC];

    _usernameView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 125.0f, 180, 250, 35)];
    _usernameView.layer.borderWidth = 1.0f;
    _usernameView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _passwordView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 125.0f, 230, 250, 35)];
    _passwordView.layer.borderWidth = 1.0f;
    _passwordView.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    _sendButtonView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 125.0f, 325, 250, 35)];
    _sendButtonView.backgroundColor = [UIColor orangeColor];

    _registerButtonView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 125.0f, 370, 250, 35)];
    _registerButtonView.backgroundColor = [UIColor orangeColor];

    //BUTTON
    UIButton* sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _sendButtonView.frame.size.width, _sendButtonView.frame.size.height)];
    [sendButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"LOG IN" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [_sendButtonView addSubview:sendButton];

    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Forgot Password" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(self.view.center.x + 70.0f, 300.0f);
    [button setTintColor:[UIColor orangeColor]];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    // Add an action in current code file (i.e. target)
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    //Register Button
    UIButton* registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _registerButtonView.frame.size.width, _registerButtonView.frame.size.height)];
    [registerButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [registerButton addTarget:self action:@selector(regis:) forControlEvents:UIControlEventTouchUpInside];
    [_registerButtonView addSubview:registerButton];

    //USERNAME Text Field
    UIImageView* userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
    [userImage setImage:[UIImage imageNamed:@"Signup-button-contact@3x"]];

    [_usernameView addSubview:userImage];

    usernameTf = [[UITextField alloc] initWithFrame:CGRectMake(60, 3, 150, 30)];
    usernameTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    usernameTf.textColor = [UIColor blackColor];
    usernameTf.autocorrectionType = UITextAutocorrectionTypeNo;
    usernameTf.keyboardType = UIKeyboardTypeNumberPad;
    _usernameView.backgroundColor = [UIColor whiteColor];
    [_usernameView addSubview:usernameTf];

    //PASSWORD Text Field
    UIImageView* lockImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
    [lockImage setImage:[UIImage imageNamed:@"login-password@3x.png"]];
    [_passwordView addSubview:lockImage];

    passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(60, 3, 150, 30)];
    passwordTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    passwordTf.textColor = [UIColor blackColor];
    passwordTf.secureTextEntry = YES;
    passwordTf.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordView.backgroundColor = [UIColor whiteColor];
    [_passwordView addSubview:passwordTf];

    [self.view addSubview:_usernameView];
    [self.view addSubview:_passwordView];
    [self.view addSubview:_sendButtonView];
    [self.view addSubview:_registerButtonView];
}

- (BOOL)isValid
{
    BOOL isValid = NO;
    if ([usernameTf.text length] == 0 && [passwordTf.text length] == 0) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ _usernameView, _passwordView ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if ([usernameTf.text length] == 0) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ _usernameView ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if ([passwordTf.text length] == 0) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ _passwordView ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if ([usernameTf.text length] < 10 || [usernameTf.text length] > 14) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ _usernameView ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if (![self isNumericOnly:usernameTf.text]) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ _usernameView ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else {
        isValid = YES;
    }
    return isValid;
}

- (BOOL)isNumericOnly:(NSString*)text
{
    BOOL valid;
    NSCharacterSet* alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet* inStringSet = [NSCharacterSet characterSetWithCharactersInString:text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    return valid;
}

#pragma mark UIActions
- (void)login:(id)sender
{
    if ([self isValid]) {

        NSDictionary* tempDict = [NSDictionary dictionaryWithObjectsAndKeys:usernameTf.text, USER_ID, passwordTf.text, PASSWORD, nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [AFNetworkFacade loginUserWithDict:tempDict
                withSuccessBlock:^(NSDictionary* dict) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [KeychainUtil createKeychainValue:usernameTf.text forIdentifier:kUserId];
                        [KeychainUtil createKeychainValue:passwordTf.text forIdentifier:kPassword];
                        [KeychainUtil createKeychainValue:[dict objectForKey:@"Religion"] forIdentifier:kReligion];

                        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                        SWRevealViewController* controller = (SWRevealViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"reveal"];
                        [self.navigationController pushViewController:controller animated:YES];
                    });
                }
                andFailureBlock:^(NSString* urlResponse, NSError* error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([urlResponse length] > 0) {
                            usernameTf.text = @"";
                            passwordTf.text = @"";
                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:urlResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                        }

                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                }];
        });
    }
}
- (void)regis:(id)sender
{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    RegistrationViewController* controller = (RegistrationViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"register"];

    [self.navigationController pushViewController:controller animated:YES];
}
- (void)buttonPressed:(id)sender
{

    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Forgot Password" message:@"Enter Contact number to recover password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 6666;
    [alert addButtonWithTitle:@"OK"];
    [alert show];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    [self.view endEditing:YES];
}

#pragma mark UIAlertView Delegate
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag == 6666 && buttonIndex == 1) {
        UITextField* title1 = [alertView textFieldAtIndex:0];

        title1 = [alertView textFieldAtIndex:0];
        NSString* title = title1.text;
        NSDictionary* tempDict = [NSDictionary dictionaryWithObjectsAndKeys:title, USER_ID, nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [AFNetworkFacade forgotPasswordDict:tempDict
            withSuccessBlock:^(NSString* urlResponse, NSError* error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:urlResponse delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            andFailureBlock:^(NSString* urlResponse, NSError* error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:urlResponse delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }];
    }
}
@end
