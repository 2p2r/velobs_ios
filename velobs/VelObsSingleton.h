//
//  ObsSingleton.h
//  velobs
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OldObs.h"


@interface VelObsSingleton : NSObject {

}

@property (nonatomic,retain) CLLocation *localisation;
@property (nonatomic,retain) NSString *categorie;
@property (nonatomic,retain) NSString *mail;
@property (nonatomic,retain) NSString *nomderue;
@property (nonatomic,retain) NSString *repere;
@property (nonatomic,retain) NSString *observation;
@property (nonatomic,retain) NSString *propositionAmelioration;
@property (nonatomic,retain) NSString *typegeoloc;
@property (nonatomic,retain) NSString *dateObs;
@property (nonatomic,retain) NSString *tel;
@property (nonatomic,retain) OldObs *poi;
@property (nonatomic,retain) NSString *serverName;


+ (VelObsSingleton *)sharedPref;


@end
