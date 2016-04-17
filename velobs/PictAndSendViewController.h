//
//  PictAndSendViewController.h
//  velobs
//

#import <UIKit/UIKit.h>

@interface PictAndSendViewController : UIViewController {
    
    UIImageView *photo;
    Boolean photoAdded ;
    NSInteger nbConnection;
    NSMutableData *receivedData;
    UIAlertView *waitingAlert;
    UIImage *imageScaled;
}


@end
