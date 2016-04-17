//
//  OldObs.h
//  velobs
//

#import <Foundation/Foundation.h>

@interface OldObs : NSObject {
    
    NSString *cat;
    NSString *adresse;
    NSString *ville;
    NSString *desc;
    NSString *distance;
    NSString *status;
    NSString *photo;
    NSString *repere;
    NSString *idd;
}

@property (nonatomic, retain) NSString *cat;
@property (nonatomic, retain) NSString *adresse;
@property (nonatomic, retain) NSString *ville;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *distance;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *repere;
@property (nonatomic ,retain) NSString *idd;

@end
