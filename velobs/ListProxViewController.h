//
//  ListProxViewController.h
//  velobs
//

#import <UIKit/UIKit.h>
#import "OldObs.h"

@interface ListProxViewController : UIViewController <NSXMLParserDelegate,UITableViewDataSource, UITableViewDelegate> {
    UITableView *proxTableView;
    NSInteger nbConnection;
    NSMutableData *receivedData;
    UIAlertView *waitingAlert;
    UITableView *myTableView;
    NSInteger nbOldObs;
}

@property (nonatomic,retain) NSXMLParser *parser;
@property (nonatomic,retain) NSMutableString *currentAttribute;
@property (nonatomic,retain) NSMutableArray *listeOldObs;
@property (nonatomic,retain) OldObs *tempElement;



@end

