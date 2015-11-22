//
//  ViewController.m
//  SignUpPage
//
//  Created by KrunalSoni on 20/07/15.
//  Copyright (c) 2015 KrunalSoni. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AFNetworkFacade.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AFViewShaker.h"
#import "Constants.h"
#import "SWRevealViewController.h"
#import "KeychainUtil.h"
#import "TNCViewController.h"

@interface RegistrationViewController () {
    AFViewShaker* viewShaker;
    NSString* currentCasteID;
    NSString* currentReligionID;
}
@property (weak, nonatomic) IBOutlet UIScrollView* scrollView;
@property (strong, nonatomic) UITextField* currentTextField;
@property (weak, nonatomic) IBOutlet UITextField* userName;
@property (weak, nonatomic) IBOutlet UITextField* password;
@property (weak, nonatomic) IBOutlet UITextField* emailId;
@property (weak, nonatomic) IBOutlet UITextField* telephone;
@property (strong, nonatomic) NSArray* arrReligion;
@property (strong, nonatomic) NSDictionary* dictReligion;
@property (strong, nonatomic) NSArray* arrCaste;
@property (strong, nonatomic) NSDictionary* dictCaste;

@property (weak, nonatomic) IBOutlet UIButton* btnReligion;
@property (weak, nonatomic) IBOutlet UIButton* btnCaste;
@property (weak, nonatomic) IBOutlet UIButton* btnTerms;
- (IBAction)goBack:(id)sender;

- (IBAction)sigup:(id)sender;
- (IBAction)selectReligion:(id)sender;
- (IBAction)selectCaste:(id)sender;
- (IBAction)showTermsNConditions:(id)sender;
- (IBAction)selectTermsNConditions:(id)sender;

@end

@implementation RegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    currentCasteID = nil;
    currentReligionID = nil;
    self.btnCaste.enabled = NO;
    [AFNetworkFacade getReligionwithSuccessBlock:^(NSDictionary* dict) {
        _dictReligion = [[NSDictionary alloc] initWithDictionary:dict];
        _arrReligion = [[NSArray alloc] initWithArray:[_dictReligion allKeys]];
    } andFailureBlock:^(NSString* urlResponse, NSError* error) {
        _arrReligion = [NSArray new];
    }];
    [self.btnTerms setBackgroundImage:[UIImage imageNamed:@"checked_checkbox@3x.png"] forState:UIControlStateNormal];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    [self addPlaceHolderimageToTextfield];
    [self registerForKeyboardNotifications];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self deRegisterForKeyboardNotifications];
}
- (void)dealloc
{
    [self deRegisterForKeyboardNotifications];
    self.currentTextField = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self deRegisterForKeyboardNotifications];
    self.currentTextField = nil;
}

#pragma mark KeyBoardNotificationMethods
- (void)registerForKeyboardNotifications
{
    NSLog(@"registerForKeyboardNotifications got called");

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)deRegisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"keyboardWasShown got called");

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;

    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.currentTextField.frame.origin)) {
        [self.scrollView scrollRectToVisible:self.currentTextField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{

    NSLog(@"keyboardWillBeHidden got called");

    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
#pragma mark - text field delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    self.currentTextField = textField;
    return TRUE;
}

- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    self.currentTextField = textField;
}
- (void)textFieldDidEndEditing:(UITextField*)textField
{
    //self.currentTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    return YES;
}
#pragma mark
- (void)addPlaceHolderimageToTextfield
{

    [[self.view viewWithTag:55] setBackgroundColor:[UIColor orangeColor]];
    [[self.view viewWithTag:66] setBackgroundColor:[UIColor orangeColor]];
    //username
    UIView* vwContainer = [[UIView alloc] init];
    [vwContainer setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 35.0f)];
    [vwContainer setBackgroundColor:[UIColor clearColor]];

    UIImageView* icon = [[UIImageView alloc] init];
    [icon setImage:[UIImage imageNamed:@"login-username@3x"]];
    [icon setFrame:CGRectMake(10.0f, 10.0f, 17.0f, 17.0f)];
    [icon setBackgroundColor:[UIColor clearColor]];

    [vwContainer addSubview:icon];

    [self.userName setLeftView:vwContainer];
    [self.userName setLeftViewMode:UITextFieldViewModeAlways];

    self.userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    //password

    UIView* vwContainer1 = [[UIView alloc] init];
    [vwContainer1 setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 35.0f)];
    [vwContainer1 setBackgroundColor:[UIColor clearColor]];

    UIImageView* icon1 = [[UIImageView alloc] init];
    [icon1 setImage:[UIImage imageNamed:@"login-password@3x"]];
    [icon1 setFrame:CGRectMake(10.0f, 10.0f, 17.0f, 17.0f)];
    [icon1 setBackgroundColor:[UIColor clearColor]];

    [vwContainer1 addSubview:icon1];

    [self.password setLeftView:vwContainer1];
    [self.password setLeftViewMode:UITextFieldViewModeAlways];
    self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password(6 letters)" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    //emailid

    UIView* vwContainer2 = [[UIView alloc] init];
    [vwContainer2 setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 35.0f)];
    [vwContainer2 setBackgroundColor:[UIColor clearColor]];

    UIImageView* icon2 = [[UIImageView alloc] init];
    [icon2 setImage:[UIImage imageNamed:@"Signup-button-email@3x"]];
    [icon2 setFrame:CGRectMake(10.0f, 12.0f, 17.0f, 15.0f)];
    [icon2 setBackgroundColor:[UIColor clearColor]];

    [vwContainer2 addSubview:icon2];

    [self.emailId setLeftView:vwContainer2];
    [self.emailId setLeftViewMode:UITextFieldViewModeAlways];

    self.emailId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-Mail ID" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    //contact number

    UIView* vwContainer3 = [[UIView alloc] init];
    [vwContainer3 setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 35.0f)];
    [vwContainer3 setBackgroundColor:[UIColor clearColor]];

    UIImageView* icon3 = [[UIImageView alloc] init];
    [icon3 setImage:[UIImage imageNamed:@"Signup-button-contact@3x"]];
    [icon3 setFrame:CGRectMake(10.0f, 10.0f, 17.0f, 17.0f)];
    [icon3 setBackgroundColor:[UIColor clearColor]];

    [vwContainer3 addSubview:icon3];

    [self.telephone setLeftView:vwContainer3];
    [self.telephone setLeftViewMode:UITextFieldViewModeAlways];
    self.telephone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    [self.view endEditing:YES];
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sigup:(id)sender
{
    //Example
    //{"ReligionID":"5","CasteID":"1","UserID":"8888888888","UserName":"testuser2","Password":"Test@1234","Reg_EmailID":"t@b.c"}
    if ([self isreadyToRegister]) {
        NSDictionary* tempDict = [NSDictionary dictionaryWithObjectsAndKeys:currentReligionID, RELIGION_ID, currentCasteID, CASTE_ID, self.telephone.text, USER_ID, self.userName.text, USER_NAME, self.password.text, PASSWORD, self.emailId.text, EMAIL_ID, nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [AFNetworkFacade registerNewUserWithDict:tempDict
                withSuccessBlock:^(NSDictionary* dict) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [KeychainUtil createKeychainValue:self.telephone.text forIdentifier:kUserId];
                        [KeychainUtil createKeychainValue:self.password.text forIdentifier:kPassword];
                        [KeychainUtil createKeychainValue:self.btnReligion.titleLabel.text forIdentifier:kReligion];
                        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                        SWRevealViewController* controller = (SWRevealViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"reveal"];
                        [self.navigationController pushViewController:controller animated:YES];
                    });
                }
                andFailureBlock:^(NSString* urlResponse, NSError* error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([urlResponse length] > 0) {
                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Registration Error" message:urlResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                        }

                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                }];
        });
    }
}

- (void)showReligionPopup
{
    CZPickerView* picker = [[CZPickerView alloc] initWithHeaderTitle:@"Religion" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = NO;
    picker.tag = 555;
    [picker show];
}

- (IBAction)selectReligion:(id)sender
{

    [self.btnCaste setTitle:@"Select your caste" forState:UIControlStateNormal];
    self.btnCaste.enabled = NO;
    currentCasteID = nil;
    if ([_arrReligion count] == 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [AFNetworkFacade getReligionwithSuccessBlock:^(NSDictionary* dict) {
            _dictReligion = [[NSDictionary alloc] initWithDictionary:dict];
            _arrReligion = [[NSArray alloc] initWithArray:[_dictReligion allKeys]];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self showReligionPopup];
            });
        } andFailureBlock:^(NSString* urlResponse, NSError* error) {
            _arrReligion = [NSArray new];
        }];
    }
    else {
        [self showReligionPopup];
    }
}

- (IBAction)selectCaste:(id)sender
{

    CZPickerView* picker = [[CZPickerView alloc] initWithHeaderTitle:@"Caste" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = NO;
    picker.tag = 666;
    [picker show];
}

- (IBAction)showTermsNConditions:(id)sender
{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TNCViewController* controller = (TNCViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"tnc"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)selectTermsNConditions:(id)sender
{
    if ([[self.btnTerms backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"checked_checkbox@3x.png"]]) {
        [self.btnTerms setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox@3x.png"] forState:UIControlStateNormal];
    }
    else {
        [self.btnTerms setBackgroundImage:[UIImage imageNamed:@"checked_checkbox@3x.png"] forState:UIControlStateNormal];
    }
}

#pragma CZPIckerVIew Delagte
- (NSString*)czpickerView:(CZPickerView*)pickerView
              titleForRow:(NSInteger)row
{
    NSString* str = nil;
    if (pickerView.tag == 555) {
        str = [[NSString alloc] initWithString:_arrReligion[row]];
    }
    else {
        str = [[NSString alloc] initWithString:_arrCaste[row]];
    }
    return str;
}
- (NSInteger)numberOfRowsInPickerView:(CZPickerView*)pickerView
{
    if (pickerView.tag == 555) {
        return _arrReligion.count;
    }
    else {
        return _arrCaste.count;
    }
}
- (void)czpickerView:(CZPickerView*)pickerView didConfirmWithItemAtRow:(NSInteger)row
{
    //NSLog(@"%@ is chosen! %@", _arrReligion[row], [_dictReligion objectForKey:_arrReligion[row]]);
    if (pickerView.tag == 555) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [AFNetworkFacade getCasteWithReligionId:[_dictReligion objectForKey:_arrReligion[row]]
                withSuccessBlock:^(NSDictionary* dict) {
                    currentReligionID = [_dictReligion objectForKey:_arrReligion[row]];
                    _dictCaste = nil;
                    _dictCaste = [[NSDictionary alloc] initWithDictionary:dict];
                    _arrCaste = nil;
                    _arrCaste = [[NSArray alloc] initWithArray:[_dictCaste allKeys]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.btnReligion setTitle:_arrReligion[row] forState:UIControlStateNormal];
                        self.btnCaste.enabled = YES;
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                }
                andFailureBlock:^(NSString* urlResponse, NSError* error) {
                    _arrCaste = [NSArray new];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.btnReligion setTitle:_arrReligion[row] forState:UIControlStateNormal];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                }];
        });
    }
    else {
        currentCasteID = [_dictCaste objectForKey:_arrCaste[row]];
        [self.btnCaste setTitle:_arrCaste[row] forState:UIControlStateNormal];
    }
}

- (void)CZPickerViewDidClickCancelButton:(CZPickerView*)pickerView
{
    NSLog(@"Canceled.");
}

#pragma mark Validation
- (BOOL)isreadyToRegister
{
    BOOL isready = NO;
    if ([self.userName.text length] == 0 || [self.userName.text length] < 3) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ self.userName ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if ([self.password.text length] == 0 || [self.password.text length] < 6 || [self.password.text length] > 6) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ self.password ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if ([self isvalidEmailwithEmail:self.emailId.text]) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ self.emailId ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if ([self.telephone.text length] < 10 || [self.telephone.text length] > 14) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ self.telephone ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if (![self isNumericOnly:self.telephone.text]) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ self.telephone ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if ([self.btnReligion.titleLabel.text caseInsensitiveCompare:@"select your religion"] == NSOrderedSame) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ self.btnReligion ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if ([self.btnCaste.titleLabel.text caseInsensitiveCompare:@"select your caste"] == NSOrderedSame) {
        viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[ self.btnCaste ]];
        [viewShaker shake];
        viewShaker = nil;
    }
    else if (![[self.btnTerms backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"checked_checkbox@3x.png"]]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please accept your Terms and conditions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        isready = YES;
    }
    return isready;
}
- (BOOL)isvalidEmailwithEmail:(NSString*)email
{
    BOOL isvalidEmail = NO;
    NSString* emailRegex = @"[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailTest evaluateWithObject:email]) {
        isvalidEmail = YES;
    }
    else {
        isvalidEmail = NO;
    }
    return isvalidEmail;
}
- (BOOL)isNumericOnly:(NSString*)text
{
    BOOL valid;
    NSCharacterSet* alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet* inStringSet = [NSCharacterSet characterSetWithCharactersInString:text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    return valid;
}
@end
