//
//  VelObsSingleton.m
//  velobs
//

#import "VelObsSingleton.h"

@implementation VelObsSingleton


@synthesize localisation;
@synthesize observation;
@synthesize propositionAmelioration;
@synthesize nomderue;
@synthesize repere;
@synthesize mail;
@synthesize categorie;
@synthesize poi;
@synthesize typegeoloc;
@synthesize dateObs;
@synthesize tel;
@synthesize serverName;



+ (id)sharedPref {
    static VelObsSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    
}



@end
