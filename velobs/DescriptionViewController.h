//
//  DescriptionViewController.h
//  velobs
//

#import <UIKit/UIKit.h>

@interface DescriptionViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) UITextView *champDescription;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

