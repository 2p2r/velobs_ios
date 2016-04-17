//
//  UpdateProxViewController.h
//  velobs
//

#import <UIKit/UIKit.h>

@interface UpdateProxViewController : UIViewController  <UITextFieldDelegate> {
    
    UILabel *photoLabel;
    Boolean photoAdded ;
    NSInteger nbConnection;
    NSMutableData *receivedData;
    UIAlertView *waitingAlert;
    UIImage *imageScaled;
    
    
}

@property (nonatomic, strong) UITextField *champCommentaire;


@end
