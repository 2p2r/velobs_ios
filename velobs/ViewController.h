//
//  ViewController.h
//  velobs
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UILabel *mailLabel;

- (BOOL)connected;


@end

