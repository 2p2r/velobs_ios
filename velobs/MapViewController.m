//
//  MapViewController.m
//  velobs
//

#import "MapViewController.h"
#import "VelObsSingleton.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView;
@synthesize pinObs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 \
                                                    green:238.0/255.0 \
                                                     blue:238.0/255.0 \
                                                    alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Carte"];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Veuillez indiquer le lieu de votre\nobservation par un appui long";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        
        [self.view addSubview:labelExplicatif];
        
        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20,180,280,160)];
        mapView.showsUserLocation = YES;
        
        MKCoordinateRegion region;
        region.center.latitude = 43.604;
        region.center.longitude = 1.444;
        region.span.latitudeDelta = 0.1;
        region.span.longitudeDelta = 0.1;
        region = [mapView regionThatFits:region];
        [mapView setRegion:region animated:TRUE];
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleGesture:)];
        lpgr.minimumPressDuration = 1.0;
        [mapView addGestureRecognizer:lpgr];
        
        [self.view addSubview:mapView];
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20,360, 280, 30);
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Veuillez indiquer le lieu de votre\nobservation par un appui long";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        
        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20,200,280,210)];
        mapView.showsUserLocation = YES;
        
        MKCoordinateRegion region;
        region.center.latitude = 43.604;
        region.center.longitude = 1.444;
        region.span.latitudeDelta = 0.1;
        region.span.longitudeDelta = 0.1;
        region = [mapView regionThatFits:region];
        [mapView setRegion:region animated:TRUE];
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleGesture:)];
        lpgr.minimumPressDuration = 1.0;
        [mapView addGestureRecognizer:lpgr];
        
        [self.view addSubview:mapView];
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20,448, 280, 30);
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Veuillez indiquer le lieu de votre\nobservation par un appui long";
        labelExplicatif.lineBreakMode = NSLineBreakByWordWrapping;
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(24,234,327,246)];
        mapView.showsUserLocation = YES;
        
        MKCoordinateRegion region;
        region.center.latitude = 43.604;
        region.center.longitude = 1.444;
        region.span.latitudeDelta = 0.1;
        region.span.longitudeDelta = 0.1;
        region = [mapView regionThatFits:region];
        [mapView setRegion:region animated:TRUE];
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleGesture:)];
        lpgr.minimumPressDuration = 1.0;
        [mapView addGestureRecognizer:lpgr];
   
        [self.view addSubview:mapView];
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(24,524, 327, 35);
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Veuillez indiquer le lieu de votre\nobservation par un appui long";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(26,258,362,271)];
        mapView.showsUserLocation = YES;
        
        MKCoordinateRegion region;
        region.center.latitude = 43.604;
        region.center.longitude = 1.444;
        region.span.latitudeDelta = 0.1;
        region.span.longitudeDelta = 0.1;
        region = [mapView regionThatFits:region];
        [mapView setRegion:region animated:TRUE];
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleGesture:)];
        lpgr.minimumPressDuration = 1.0;
        [mapView addGestureRecognizer:lpgr];

        [self.view addSubview:mapView];
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(26,578, 362, 39);
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
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
    
    
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
    
    if (pinObs != nil) {
        
        [mapView removeAnnotation:pinObs];
        
    }
    
    pinObs = [[MKPointAnnotation alloc] init];
    pinObs.coordinate = touchMapCoordinate;
    pinObs.title = @"Ici";
    [mapView addAnnotation:pinObs];
}



-(void) suivant:(id)sender {
    
    if (pinObs != nil) {
    
        [[VelObsSingleton sharedPref] setLocalisation:[[CLLocation alloc] initWithLatitude:pinObs.coordinate.latitude longitude:pinObs.coordinate.longitude]];
        
        [self.navigationController popViewControllerAnimated:YES];

    } else {
        
        UIAlertController *alert=   [UIAlertController
                                     alertControllerWithTitle:@"Erreur"
                                     message:@"Veuillez choisir une localisation sur la carte avec un appui long"
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
