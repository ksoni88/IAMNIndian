
#import <UIKit/UIKit.h>
#import <EAIntroView/EAIntroView.h>

@interface ViewController : UIViewController <EAIntroDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UIView* usernameView;
@property (strong, nonatomic) UIView* passwordView;
@property (strong, nonatomic) UIView* sendButtonView;
@property (strong, nonatomic) UIView* registerButtonView;
@end
