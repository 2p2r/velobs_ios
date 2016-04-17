//
//  CategoryViewController.h
//  velobs
//

#import <UIKit/UIKit.h>
#import "SousCategory.h"

@interface CategoryViewController : UIViewController <NSXMLParserDelegate,UIPickerViewDelegate>{

    NSInteger nbCategory;
    NSInteger nbConnection;
    Boolean selected;
    NSMutableData *receivedData;
    UIAlertView *waitingAlert;
}

@property (nonatomic,retain) NSXMLParser *parser;
@property (nonatomic,retain) NSMutableString *currentAttribute;
@property (nonatomic,retain) NSMutableArray *listeCategory;
@property (nonatomic,retain) SousCategory *tempElement;
@property (nonatomic,strong) UIPickerView *thePicker;



@end
