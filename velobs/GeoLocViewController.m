//
//  GeoLocViewController.m
//  velobs
//

#import "GeoLocViewController.h"
#import "CategoryViewController.h"
#import "ListProxViewController.h"
#import "MapViewController.h"
#import "VelObsSingleton.h"

@interface GeoLocViewController ()

@end

@implementation GeoLocViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 \
                                                    green:238.0/255.0 \
                                                     blue:238.0/255.0 \
                                                    alpha:1.0];
    }
    proxButtonOnScreen = 0 ;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Localisation"];
    
    found = false ;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 1/6 \n Recherche de votre localisation\n\nChoisissez une méthode :";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                 labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                 labelExplicatif.frame.size.width, labelSize.height);
        
        [self.view addSubview:labelExplicatif];
        
        UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mapButton.frame = CGRectMake(20,240, 130, 30);
        [mapButton setTitle:@"CARTE" forState:UIControlStateNormal];
        [mapButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [mapButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mapButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                     green:220.0/255.0 \
                                                      blue:220.0/255.0 \
                                                     alpha:1.0]];
        [mapButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [mapButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [mapButton.layer setShadowOpacity:0.5];
        [mapButton addTarget:self action:@selector(carte:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mapButton];
        
        UIButton *gpsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        gpsButton.frame = CGRectMake(170,240, 130, 30);
        [gpsButton setTitle:@"GPS" forState:UIControlStateNormal];
        [gpsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [gpsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [gpsButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                     green:220.0/255.0 \
                                                      blue:220.0/255.0 \
                                                     alpha:1.0]];
        [gpsButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [gpsButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [gpsButton.layer setShadowOpacity:0.5];
        [gpsButton addTarget:self action:@selector(gps:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:gpsButton];
        
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20,360, 280, 30);
        [okButton setTitle:@"SUIVANT" forState:UIControlStateNormal];
        [okButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                     green:220.0/255.0 \
                                                      blue:220.0/255.0 \
                                                     alpha:1.0]];
        [okButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [okButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [okButton.layer setShadowOpacity:0.5];
        [okButton addTarget:self action:@selector(suivant:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];
        
        
    } else if (screenBounds.size.height == 568) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 1/6 \n Recherche de votre localisation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mapButton.frame = CGRectMake(20,240, 130, 30);
        [mapButton setTitle:@"CARTE" forState:UIControlStateNormal];
        [mapButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [mapButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mapButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                      green:220.0/255.0 \
                                                       blue:220.0/255.0 \
                                                      alpha:1.0]];
        [mapButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [mapButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [mapButton.layer setShadowOpacity:0.5];
        [mapButton addTarget:self action:@selector(carte:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mapButton];
        
        UIButton *gpsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        gpsButton.frame = CGRectMake(170,240, 130, 30);
        [gpsButton setTitle:@"GPS" forState:UIControlStateNormal];
        [gpsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [gpsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [gpsButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                      green:220.0/255.0 \
                                                       blue:220.0/255.0 \
                                                      alpha:1.0]];
        [gpsButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [gpsButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [gpsButton.layer setShadowOpacity:0.5];
        [gpsButton addTarget:self action:@selector(gps:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:gpsButton];
        
        
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20,448, 280, 30);
        [okButton setTitle:@"SUIVANT" forState:UIControlStateNormal];
        [okButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                     green:220.0/255.0 \
                                                      blue:220.0/255.0 \
                                                     alpha:1.0]];
        [okButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [okButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [okButton.layer setShadowOpacity:0.5];
        [okButton addTarget:self action:@selector(suivant:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];
        
        
    } else if (screenBounds.size.height == 667) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD4.7.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,375,135);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(24, 153, 327, 35)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 1/6 \n Recherche de votre localisation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        
        UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mapButton.frame = CGRectMake(24,281, 152, 35);
        [mapButton setTitle:@"CARTE" forState:UIControlStateNormal];
        [mapButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [mapButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mapButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                      green:220.0/255.0 \
                                                       blue:220.0/255.0 \
                                                      alpha:1.0]];
        [mapButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [mapButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [mapButton.layer setShadowOpacity:0.5];
        [mapButton addTarget:self action:@selector(carte:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mapButton];
        
        UIButton *gpsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        gpsButton.frame = CGRectMake(199,281, 152, 35);
        [gpsButton setTitle:@"GPS" forState:UIControlStateNormal];
        [gpsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [gpsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [gpsButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                      green:220.0/255.0 \
                                                       blue:220.0/255.0 \
                                                      alpha:1.0]];
        [gpsButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [gpsButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [gpsButton.layer setShadowOpacity:0.5];
        [gpsButton addTarget:self action:@selector(gps:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:gpsButton];
        
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(24,524, 327, 35);
        [okButton setTitle:@"SUIVANT" forState:UIControlStateNormal];
        [okButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                     green:220.0/255.0 \
                                                      blue:220.0/255.0 \
                                                     alpha:1.0]];
        [okButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [okButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [okButton.layer setShadowOpacity:0.5];
        [okButton addTarget:self action:@selector(suivant:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];
        
        
    } else if (screenBounds.size.height == 736) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD5.5.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,414,149);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(26, 168, 362, 39)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 1/6 \n Recherche de votre localisation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mapButton.frame = CGRectMake(26,310, 168, 39);
        [mapButton setTitle:@"CARTE" forState:UIControlStateNormal];
        [mapButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [mapButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mapButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                      green:220.0/255.0 \
                                                       blue:220.0/255.0 \
                                                      alpha:1.0]];
        [mapButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [mapButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [mapButton.layer setShadowOpacity:0.5];
        [mapButton addTarget:self action:@selector(carte:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mapButton];
        
        UIButton *gpsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        gpsButton.frame = CGRectMake(219,310, 168, 39);
        [gpsButton setTitle:@"GPS" forState:UIControlStateNormal];
        [gpsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [gpsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [gpsButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                      green:220.0/255.0 \
                                                       blue:220.0/255.0 \
                                                      alpha:1.0]];
        [gpsButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [gpsButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [gpsButton.layer setShadowOpacity:0.5];
        [gpsButton addTarget:self action:@selector(gps:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:gpsButton];
        
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(26,578, 362, 39);
        [okButton setTitle:@"SUIVANT" forState:UIControlStateNormal];
        [okButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                     green:220.0/255.0 \
                                                      blue:220.0/255.0 \
                                                     alpha:1.0]];
        [okButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [okButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [okButton.layer setShadowOpacity:0.5];
        [okButton addTarget:self action:@selector(suivant:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];

        
    } else {
        // taille écran non gérée
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([VelObsSingleton sharedPref].localisation != nil) {
        
        [self afficheBoutonProx];
        
    }
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [lm stopUpdatingLocation];
}


-(void) suivant:(id)sender {
    
    if (found||([VelObsSingleton sharedPref].localisation != nil)) {
    
        CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
        [self.navigationController pushViewController:categoryViewController animated:YES ] ;
        
    } else {
        
        UIAlertController *alert=   [UIAlertController
                                     alertControllerWithTitle:@"Erreur"
                                     message:@"Veuillez choisir une méthode de localisation"
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

-(void) carte:(id)sender {
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapViewController animated:YES ] ;
    

    
}

- (void) locationManager: (CLLocationManager *) manager
     didUpdateToLocation: (CLLocation *) newLocation
            fromLocation: (CLLocation *) oldLocation{
    
    loc = newLocation ;
    found =  true ;
    
    [self afficheBoutonProx];
    [[VelObsSingleton sharedPref] setLocalisation:loc ];
    
    
}

-(void) afficheBoutonProx{
    
    if (proxButtonOnScreen == 0)  {
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height == 480) {
            
            UIButton *proxButton = [UIButton buttonWithType:UIButtonTypeCustom];
            proxButton.frame = CGRectMake(20,300, 280, 30);
            [proxButton setTitle:@"OBSERVATIONS À PROXIMITÉ" forState:UIControlStateNormal];
            [proxButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
            [proxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [proxButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                           green:220.0/255.0 \
                                                            blue:220.0/255.0 \
                                                           alpha:1.0]];
            [proxButton.layer setShadowOffset:CGSizeMake(2, 2)];
            [proxButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
            [proxButton.layer setShadowOpacity:0.5];
            [proxButton addTarget:self action:@selector(prox:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:proxButton];
            
        } else if (screenBounds.size.height == 568) {
            
            UIButton *proxButton = [UIButton buttonWithType:UIButtonTypeCustom];
            proxButton.frame = CGRectMake(20,340, 280, 30);
            [proxButton setTitle:@"OBSERVATIONS À PROXIMITÉ" forState:UIControlStateNormal];
            [proxButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
            [proxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [proxButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                           green:220.0/255.0 \
                                                            blue:220.0/255.0 \
                                                           alpha:1.0]];
            [proxButton.layer setShadowOffset:CGSizeMake(2, 2)];
            [proxButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
            [proxButton.layer setShadowOpacity:0.5];
            [proxButton addTarget:self action:@selector(prox:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:proxButton];
            
            
        } else if (screenBounds.size.height == 667) {
            
            
            UIButton *proxButton = [UIButton buttonWithType:UIButtonTypeCustom];
            proxButton.frame = CGRectMake(24,398, 328, 35);
            [proxButton setTitle:@"OBSERVATIONS À PROXIMITÉ" forState:UIControlStateNormal];
            [proxButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
            [proxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [proxButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                           green:220.0/255.0 \
                                                            blue:220.0/255.0 \
                                                           alpha:1.0]];
            [proxButton.layer setShadowOffset:CGSizeMake(2, 2)];
            [proxButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
            [proxButton.layer setShadowOpacity:0.5];
            [proxButton addTarget:self action:@selector(prox:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:proxButton];
            
        } else if (screenBounds.size.height == 736) {
            
            
            UIButton *proxButton = [UIButton buttonWithType:UIButtonTypeCustom];
            proxButton.frame = CGRectMake(26,439, 361, 39);
            [proxButton setTitle:@"OBSERVATIONS À PROXIMITÉ" forState:UIControlStateNormal];
            [proxButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
            [proxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [proxButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                           green:220.0/255.0 \
                                                            blue:220.0/255.0 \
                                                           alpha:1.0]];
            [proxButton.layer setShadowOffset:CGSizeMake(2, 2)];
            [proxButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
            [proxButton.layer setShadowOpacity:0.5];
            [proxButton addTarget:self action:@selector(prox:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:proxButton];
            
        }
        proxButtonOnScreen = 1 ;
        
        
    }

    
    
    
}

-(void) gps:(id)sender {
    
    
    lm = [[CLLocationManager alloc] init];
    
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyBest;
    lm.distanceFilter = 100.0f;
    
    if ([lm respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [lm requestWhenInUseAuthorization];
    }
    
    [lm startUpdatingLocation];
    
}

-(void) prox:(id)sender {
    
    if (found||([VelObsSingleton sharedPref].localisation != nil)) {
    
        ListProxViewController *listProxViewController = [[ListProxViewController alloc] init];
        [self.navigationController pushViewController:listProxViewController animated:YES ] ;
        
    } else {
        UIAlertController *alert=   [UIAlertController
                                     alertControllerWithTitle:@"Erreur"
                                     message:@"Veuillez choisir une méthode pour localiser votre observation"
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
