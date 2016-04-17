//
//  GeoLocViewController.h
//  velobs
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GeoLocViewController : UIViewController<CLLocationManagerDelegate> {
    
    NSInteger proxButtonOnScreen;
    CLLocationManager *lm;
    CLLocation *loc;
    Boolean found ;
}


@end
