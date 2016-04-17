//
//  ViewController.m
//  velobs
//

#import "ViewController.h"
#import "MailViewController.h"
#import "GeoLocViewController.h"
#import "VelObsSingleton.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mailLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 \
                                                    green:238.0/255.0 \
                                                     blue:238.0/255.0 \
                                                    alpha:1.0];
    }
    
    [[VelObsSingleton sharedPref] setServerName:@"velobs.2p2r.org"] ;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"VelObs"];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        // iphone 4
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UIButton *obsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        obsButton.frame = CGRectMake(20, 140, 280, 40);
        [obsButton setTitle:@"POSTER UNE OBSERVATION" forState:UIControlStateNormal];
        [obsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [obsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [obsButton setBackgroundColor:[UIColor colorWithRed:254.0/255.0 \
                                                      green:237.0/255.0 \
                                                       blue:1.0/255.0 \
                                                      alpha:1.0]];
        [obsButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [obsButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [obsButton.layer setShadowOpacity:0.5];
        [obsButton addTarget:self action:@selector(postObs:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:obsButton];
        
        mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 280, 30)];
        mailLabel.backgroundColor =[UIColor clearColor];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"email"] != nil ) {
            mailLabel.text = [NSString stringWithFormat:@"Mail de suivi : %@",[defaults objectForKey:@"email"]];
        } else {
            mailLabel.text = @"Vous n'avez pas de mail de suivi";
        }
        

        
        mailLabel.textColor = [UIColor grayColor];
        mailLabel.textAlignment = NSTextAlignmentCenter;
        mailLabel.font = [UIFont systemFontOfSize:16.0];
        [self.view addSubview:mailLabel];
        
        UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mailButton.frame = CGRectMake(40, 235, 240, 30);
        [mailButton setTitle:@"CHANGER LE MAIL DE SUIVI" forState:UIControlStateNormal];
        [mailButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [mailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mailButton setBackgroundColor:[UIColor colorWithRed:254.0/255.0 \
                                                      green:237.0/255.0 \
                                                       blue:1.0/255.0 \
                                                      alpha:1.0]];
        [mailButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [mailButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [mailButton.layer setShadowOpacity:0.5];
        [mailButton addTarget:self action:@selector(setMail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mailButton];
        
        UILabel *urgenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 285, 280, 50)];
        urgenceLabel.backgroundColor =[UIColor clearColor];
        urgenceLabel.text = @"En cas d'urgence sur la ville de Toulouse, veuillez appeler le 0561 222 222";
        urgenceLabel.textColor = [UIColor grayColor];
        urgenceLabel.textAlignment = NSTextAlignmentCenter;
        urgenceLabel.numberOfLines = 2;
        urgenceLabel.font = [UIFont systemFontOfSize:14.0];
        [self.view addSubview:urgenceLabel];
        
        UIButton *urgenceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        urgenceButton.frame = CGRectMake(60, 350, 200, 30);
        [urgenceButton setTitle:@"APPELER LE SERVICE" forState:UIControlStateNormal];
        [urgenceButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [urgenceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [urgenceButton setBackgroundColor:[UIColor colorWithRed:253.0/255.0 \
                                                       green:120.0/255.0 \
                                                        blue:13.0/255.0 \
                                                       alpha:1.0]];
        [urgenceButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [urgenceButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [urgenceButton.layer setShadowOpacity:0.5];
        [urgenceButton addTarget:self action:@selector(callEmergency:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:urgenceButton];
        
        
        
    
    } else if (screenBounds.size.height == 568) {
        
        // iphone 5
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UIButton *obsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        obsButton.frame = CGRectMake(20, 150, 280, 40);
        [obsButton setTitle:@"POSTER UNE OBSERVATION" forState:UIControlStateNormal];
        [obsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [obsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [obsButton setBackgroundColor:[UIColor colorWithRed:254.0/255.0 \
                                                      green:237.0/255.0 \
                                                       blue:1.0/255.0 \
                                                      alpha:1.0]];
        [obsButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [obsButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [obsButton.layer setShadowOpacity:0.5];
        [obsButton addTarget:self action:@selector(postObs:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:obsButton];
        
        mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 280, 30)];
        mailLabel.backgroundColor =[UIColor clearColor];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"email"] != nil ) {
            mailLabel.text = [NSString stringWithFormat:@"Mail de suivi : %@",[defaults objectForKey:@"email"]];
        } else {
            mailLabel.text = @"Vous n'avez pas de mail de suivi";
        }

        mailLabel.textColor = [UIColor grayColor];
        mailLabel.textAlignment = NSTextAlignmentCenter;
        mailLabel.font = [UIFont systemFontOfSize:16.0];
        [self.view addSubview:mailLabel];
        
        UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mailButton.frame = CGRectMake(40, 275, 240, 30);
        [mailButton setTitle:@"CHANGER LE MAIL DE SUIVI" forState:UIControlStateNormal];
        [mailButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [mailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mailButton setBackgroundColor:[UIColor colorWithRed:254.0/255.0 \
                                                       green:237.0/255.0 \
                                                        blue:1.0/255.0 \
                                                       alpha:1.0]];
        [mailButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [mailButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [mailButton.layer setShadowOpacity:0.5];
        [mailButton addTarget:self action:@selector(setMail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mailButton];
        
        UILabel *urgenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 365, 280, 50)];
        urgenceLabel.backgroundColor =[UIColor clearColor];
        urgenceLabel.text = @"En cas d'urgence sur la ville de Toulouse, veuillez appeler le 0561 222 222";
        urgenceLabel.textColor = [UIColor grayColor];
        urgenceLabel.textAlignment = NSTextAlignmentCenter;
        urgenceLabel.numberOfLines = 2;
        urgenceLabel.font = [UIFont systemFontOfSize:14.0];
        [self.view addSubview:urgenceLabel];
        
        UIButton *urgenceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        urgenceButton.frame = CGRectMake(60, 430, 200, 30);
        [urgenceButton setTitle:@"APPELER LE SERVICE" forState:UIControlStateNormal];
        [urgenceButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [urgenceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [urgenceButton setBackgroundColor:[UIColor colorWithRed:253.0/255.0 \
                                                          green:120.0/255.0 \
                                                           blue:13.0/255.0 \
                                                          alpha:1.0]];
        [urgenceButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [urgenceButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [urgenceButton.layer setShadowOpacity:0.5];
        [urgenceButton addTarget:self action:@selector(callEmergency:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:urgenceButton];
        
        
        
    } else if (screenBounds.size.height == 667) {
        
        // iphone 6
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD4.7.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,375,135);
        [self.view addSubview:topImageView];
        
        UIButton *obsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        obsButton.frame = CGRectMake(24, 164, 327, 47);
        [obsButton setTitle:@"POSTER UNE OBSERVATION" forState:UIControlStateNormal];
        [obsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [obsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [obsButton setBackgroundColor:[UIColor colorWithRed:254.0/255.0 \
                                                      green:237.0/255.0 \
                                                       blue:1.0/255.0 \
                                                      alpha:1.0]];
        [obsButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [obsButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [obsButton.layer setShadowOpacity:0.5];
        [obsButton addTarget:self action:@selector(postObs:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:obsButton];
        
        mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 280, 325, 35)];
        mailLabel.backgroundColor =[UIColor clearColor];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"email"] != nil ) {
            mailLabel.text = [NSString stringWithFormat:@"Mail de suivi : %@",[defaults objectForKey:@"email"]];
        } else {
            mailLabel.text = @"Vous n'avez pas de mail de suivi";
        }

        mailLabel.textColor = [UIColor grayColor];
        mailLabel.textAlignment = NSTextAlignmentCenter;
        mailLabel.font = [UIFont systemFontOfSize:16.0];
        [self.view addSubview:mailLabel];
        
        UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mailButton.frame = CGRectMake(47, 322, 281, 35);
        [mailButton setTitle:@"CHANGER LE MAIL DE SUIVI" forState:UIControlStateNormal];
        [mailButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [mailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mailButton setBackgroundColor:[UIColor colorWithRed:254.0/255.0 \
                                                       green:237.0/255.0 \
                                                        blue:1.0/255.0 \
                                                       alpha:1.0]];
        [mailButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [mailButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [mailButton.layer setShadowOpacity:0.5];
        [mailButton addTarget:self action:@selector(setMail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mailButton];
        
        UILabel *urgenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 427, 325, 59)];
        urgenceLabel.backgroundColor =[UIColor clearColor];
        urgenceLabel.text = @"En cas d'urgence sur la ville de Toulouse, veuillez appeler le 0561 222 222";
        urgenceLabel.textColor = [UIColor grayColor];
        urgenceLabel.textAlignment = NSTextAlignmentCenter;
        urgenceLabel.numberOfLines = 2;
        urgenceLabel.font = [UIFont systemFontOfSize:16.0];
        [self.view addSubview:urgenceLabel];
        
        UIButton *urgenceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        urgenceButton.frame = CGRectMake(70, 503, 234, 35);
        [urgenceButton setTitle:@"APPELER LE SERVICE" forState:UIControlStateNormal];
        [urgenceButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [urgenceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [urgenceButton setBackgroundColor:[UIColor colorWithRed:253.0/255.0 \
                                                          green:120.0/255.0 \
                                                           blue:13.0/255.0 \
                                                          alpha:1.0]];
        [urgenceButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [urgenceButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [urgenceButton.layer setShadowOpacity:0.5];
        [urgenceButton addTarget:self action:@selector(callEmergency:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:urgenceButton];
        
    } else if (screenBounds.size.height == 736) {
        
        // iphone 6+
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD5.5.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,414,149);
        [self.view addSubview:topImageView];
        
        
        UIButton *obsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        obsButton.frame = CGRectMake(26, 193, 362, 52);
        [obsButton setTitle:@"POSTER UNE OBSERVATION" forState:UIControlStateNormal];
        [obsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [obsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [obsButton setBackgroundColor:[UIColor colorWithRed:254.0/255.0 \
                                                      green:237.0/255.0 \
                                                       blue:1.0/255.0 \
                                                      alpha:1.0]];
        [obsButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [obsButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [obsButton.layer setShadowOpacity:0.5];
        [obsButton addTarget:self action:@selector(postObs:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:obsButton];
        
        mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 312, 362, 39)];
        mailLabel.backgroundColor =[UIColor clearColor];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"email"] != nil ) {
            mailLabel.text = [NSString stringWithFormat:@"Mail de suivi : %@",[defaults objectForKey:@"email"]];
        } else {
            mailLabel.text = @"Vous n'avez pas de mail de suivi";
        }

        mailLabel.textColor = [UIColor grayColor];
        mailLabel.textAlignment = NSTextAlignmentCenter;
        mailLabel.font = [UIFont systemFontOfSize:16.0];
        [self.view addSubview:mailLabel];
        
        UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mailButton.frame = CGRectMake(52, 357, 312, 39);
        [mailButton setTitle:@"CHANGER LE MAIL DE SUIVI" forState:UIControlStateNormal];
        [mailButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [mailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mailButton setBackgroundColor:[UIColor colorWithRed:254.0/255.0 \
                                                       green:237.0/255.0 \
                                                        blue:1.0/255.0 \
                                                       alpha:1.0]];
        [mailButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [mailButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [mailButton.layer setShadowOpacity:0.5];
        [mailButton addTarget:self action:@selector(setMail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mailButton];
        
        UILabel *urgenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 474, 362, 65)];
        urgenceLabel.backgroundColor =[UIColor clearColor];
        urgenceLabel.text = @"En cas d'urgence sur la ville de Toulouse, veuillez appeler le 0561 222 222";
        urgenceLabel.textColor = [UIColor grayColor];
        urgenceLabel.textAlignment = NSTextAlignmentCenter;
        urgenceLabel.numberOfLines = 2;
        urgenceLabel.font = [UIFont systemFontOfSize:16.0];
        [self.view addSubview:urgenceLabel];
        
        UIButton *urgenceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        urgenceButton.frame = CGRectMake(78, 559, 260, 39);
        [urgenceButton setTitle:@"APPELER LE SERVICE" forState:UIControlStateNormal];
        [urgenceButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [urgenceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [urgenceButton setBackgroundColor:[UIColor colorWithRed:253.0/255.0 \
                                                          green:120.0/255.0 \
                                                           blue:13.0/255.0 \
                                                          alpha:1.0]];
        [urgenceButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [urgenceButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [urgenceButton.layer setShadowOpacity:0.5];
        [urgenceButton addTarget:self action:@selector(callEmergency:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:urgenceButton];

        
    } else {
        // taille écran non gérée
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"email"] != nil ) {
        mailLabel.text = [NSString stringWithFormat:@"Mail de suivi : %@",[defaults objectForKey:@"email"]];
    } else {
        mailLabel.text = @"Vous n'avez pas de mail de suivi";
    }



}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}



-(void) postObs:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"email"] != nil ) {
        
        if (![self connected]) {
            UIAlertController *alert=   [UIAlertController
                                         alertControllerWithTitle:@"Erreur"
                                         message:@"Vous n'êtes pas connecté à Internet"                                         preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
        } else {
            [[VelObsSingleton sharedPref] setMail:[defaults objectForKey:@"email"]] ;
            
            GeoLocViewController *geolocViewController = [[GeoLocViewController alloc] init];
            [self.navigationController pushViewController:geolocViewController animated:YES ] ;
        }
        
        
        
        
    } else {
        
        UIAlertController *alert=   [UIAlertController
                                     alertControllerWithTitle:@"Erreur"
                                     message:@"Veuillez entrer une adresse email de suivi"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
    }
    
}

-(void) setMail:(id)sender {
    
    MailViewController *mailViewController = [[MailViewController alloc] init];
    [self.navigationController pushViewController:mailViewController animated:YES ] ;
    
}

-(void) callEmergency:(id)sender {
    
    NSString *phoneNumber = @"telprompt://0561222222";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
