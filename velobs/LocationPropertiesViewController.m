//
//  LocationPropertiesViewController.m
//  velobs
//


#import "LocationPropertiesViewController.h"
#import "DescriptionViewController.h"
#import "VelObsSingleton.h"

@interface LocationPropertiesViewController ()

@end

@implementation LocationPropertiesViewController

@synthesize champNomDeRue;
@synthesize champRepere;

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
    
    [self setTitle:@"Lieu"];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320,480)];
        [self.view addSubview:self.scrollView];
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.scrollView addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(10, 130, 300, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 3/6\nPrécisions sur le lieu d'observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        
        [self.scrollView addSubview:labelExplicatif];
        
        
        
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
        [self.scrollView addSubview:okButton];
        
        champNomDeRue = [[UITextField alloc] initWithFrame:CGRectMake(20, 190, 280, 30)];
        champNomDeRue.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                     green:245.0/255.0 \
                                                      blue:245.0/255.0 \
                                                     alpha:1.0];
        champNomDeRue.placeholder = @"Donnez ici le nom de la rue";
        champNomDeRue.keyboardType = UIKeyboardTypeDefault ;
        champNomDeRue.clearButtonMode = UITextFieldViewModeWhileEditing;
        champNomDeRue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champNomDeRue.delegate = self;
        champNomDeRue.tag = 1 ;
        [self.scrollView addSubview:champNomDeRue];
        
        champRepere = [[UITextField alloc] initWithFrame:CGRectMake(20, 230, 280, 30)];
        champRepere.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                         green:245.0/255.0 \
                                                          blue:245.0/255.0 \
                                                         alpha:1.0];
        champRepere.placeholder = @"Donnez ici un repère (ex: un numéro)";
        champRepere.keyboardType = UIKeyboardTypeDefault ;
        champRepere.clearButtonMode = UITextFieldViewModeWhileEditing;
        champRepere.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champRepere.delegate = self;
        champRepere.tag = 2 ;
        [self.scrollView addSubview:champRepere];
        
        
    } else if (screenBounds.size.height == 568) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320,568)];
        [self.view addSubview:self.scrollView];
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.scrollView addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(10, 130, 300, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 3/6\nPrécisions sur le lieu d'observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.scrollView addSubview:labelExplicatif];
        
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
        [self.scrollView addSubview:okButton];
        
        champNomDeRue = [[UITextField alloc] initWithFrame:CGRectMake(20, 210, 280, 30)];
        champNomDeRue.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                         green:245.0/255.0 \
                                                          blue:245.0/255.0 \
                                                         alpha:1.0];
        champNomDeRue.placeholder = @"Donnez ici le nom de la rue";
        champNomDeRue.keyboardType = UIKeyboardTypeDefault ;
        champNomDeRue.clearButtonMode = UITextFieldViewModeWhileEditing;
        champNomDeRue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champNomDeRue.delegate = self;
        champNomDeRue.tag = 1 ;
        [self.scrollView addSubview:champNomDeRue];
        
        champRepere = [[UITextField alloc] initWithFrame:CGRectMake(20, 260, 280, 30)];
        champRepere.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                       green:245.0/255.0 \
                                                        blue:245.0/255.0 \
                                                       alpha:1.0];
        champRepere.placeholder = @"Donnez ici un repère (ex: un numéro)";
        champRepere.keyboardType = UIKeyboardTypeDefault ;
        champRepere.clearButtonMode = UITextFieldViewModeWhileEditing;
        champRepere.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champRepere.delegate = self;
        champRepere.tag = 2 ;
        [self.scrollView addSubview:champRepere];
        
        
    } else if (screenBounds.size.height == 667) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,375,667)];
        [self.view addSubview:self.scrollView];
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD4.7.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,375,135);
        [self.scrollView addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(24, 153, 327, 35)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 3/6\nPrécisions sur le lieu d'observation";
        labelExplicatif.lineBreakMode = NSLineBreakByWordWrapping;
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.scrollView addSubview:labelExplicatif];
        
        
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
        [self.scrollView addSubview:okButton];
        
        champNomDeRue = [[UITextField alloc] initWithFrame:CGRectMake(24, 246, 328, 35)];
        champNomDeRue.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                         green:245.0/255.0 \
                                                          blue:245.0/255.0 \
                                                         alpha:1.0];
        champNomDeRue.placeholder = @"Donnez ici le nom de la rue";
        champNomDeRue.keyboardType = UIKeyboardTypeDefault ;
        champNomDeRue.clearButtonMode = UITextFieldViewModeWhileEditing;
        champNomDeRue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champNomDeRue.delegate = self;
        champNomDeRue.tag = 1 ;
        [self.scrollView addSubview:champNomDeRue];
        
        champRepere = [[UITextField alloc] initWithFrame:CGRectMake(24, 304, 328, 35)];
        champRepere.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                       green:245.0/255.0 \
                                                        blue:245.0/255.0 \
                                                       alpha:1.0];
        champRepere.placeholder = @"Donnez ici un repère (ex: un numéro)";
        champRepere.keyboardType = UIKeyboardTypeDefault ;
        champRepere.clearButtonMode = UITextFieldViewModeWhileEditing;
        champRepere.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champRepere.delegate = self;
        champRepere.tag = 2 ;
        [self.scrollView addSubview:champRepere];
        
        
    } else if (screenBounds.size.height == 736) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,414,736)];
        [self.view addSubview:self.scrollView];
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD5.5.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,414,149);
        [self.scrollView addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(26, 168, 362, 39)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 3/6\nPrécisions sur le lieu d'observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.scrollView addSubview:labelExplicatif];
        
        
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
        [self.scrollView addSubview:okButton];
        
        champNomDeRue = [[UITextField alloc] initWithFrame:CGRectMake(26, 271, 362, 39)];
        champNomDeRue.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                         green:245.0/255.0 \
                                                          blue:245.0/255.0 \
                                                         alpha:1.0];
        champNomDeRue.placeholder = @"Donnez ici le nom de la rue";
        champNomDeRue.keyboardType = UIKeyboardTypeDefault ;
        champNomDeRue.clearButtonMode = UITextFieldViewModeWhileEditing;
        champNomDeRue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champNomDeRue.delegate = self;
        champNomDeRue.tag = 1 ;
        [self.scrollView addSubview:champNomDeRue];
        
        champRepere = [[UITextField alloc] initWithFrame:CGRectMake(26, 335, 362, 39)];
        champRepere.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                       green:245.0/255.0 \
                                                        blue:245.0/255.0 \
                                                       alpha:1.0];
        champRepere.placeholder = @"Donnez ici un repère (ex: un numéro)";
        champRepere.keyboardType = UIKeyboardTypeDefault ;
        champRepere.clearButtonMode = UITextFieldViewModeWhileEditing;
        champRepere.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champRepere.delegate = self;
        champRepere.tag = 2 ;
        [self.scrollView addSubview:champRepere];
        
        
        
        
    } else {
        // taille d'écran non gérée
    }
    
    
}

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self deregisterFromKeyboardNotifications];
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    
    
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    CGPoint scrollPoint = CGPointMake(0.0,100.0);
        
    [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}


-(void) suivant:(id)sender {
    
    [[VelObsSingleton sharedPref] setNomderue:champNomDeRue.text] ;
    [[VelObsSingleton sharedPref] setRepere:champRepere.text] ;
    
    DescriptionViewController *descViewController = [[DescriptionViewController alloc] init];
    [self.navigationController pushViewController:descViewController animated:YES ] ;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField.tag==1) {
        
        [self.champNomDeRue resignFirstResponder];
        
    } else if(textField.tag ==2) {
        
        [self.champRepere resignFirstResponder];
        
    }
  
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

