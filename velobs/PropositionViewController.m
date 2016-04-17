//
//  PropositionViewController.m
//  velobs
//


#import "PropositionViewController.h"
#import "PictAndSendViewController.h"
#import "VelObsSingleton.h"

@interface PropositionViewController ()

@end

@implementation PropositionViewController

@synthesize champProposition;

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
    
    [self setTitle:@"Proposition"];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320,480)];
        [self.view addSubview:self.scrollView];

        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.scrollView addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 5/6\nProposition de résolution";
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
        
        champProposition = [[UITextView alloc] initWithFrame:CGRectMake(20, 190, 280, 120)];
        champProposition.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                            green:245.0/255.0 \
                                                             blue:245.0/255.0 \
                                                            alpha:1.0];;
        
        champProposition.keyboardType = UIKeyboardTypeDefault ;
        [champProposition setFont:[UIFont systemFontOfSize:15]];
        champProposition.delegate = self;
        [self.scrollView addSubview:champProposition];
        
        
    } else if (screenBounds.size.height == 568) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320,568)];
        [self.view addSubview:self.scrollView];

        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.scrollView addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 5/6\nProposition de résolution";
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
        
        champProposition = [[UITextView alloc] initWithFrame:CGRectMake(20, 210, 280, 120)];
        champProposition.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                            green:245.0/255.0 \
                                                             blue:245.0/255.0 \
                                                            alpha:1.0];;
        
        champProposition.keyboardType = UIKeyboardTypeDefault ;
        [champProposition setFont:[UIFont systemFontOfSize:15]];
        champProposition.delegate = self;
        [self.scrollView addSubview:champProposition];

        
        
    } else if (screenBounds.size.height == 667) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,375,667)];
        [self.view addSubview:self.scrollView];

        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD4.7.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,375,135);
        [self.scrollView addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(24, 153, 327, 35)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 5/6\nProposition de résolution";
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
        
        champProposition = [[UITextView alloc] initWithFrame:CGRectMake(24, 248, 327, 140)];
        champProposition.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                            green:245.0/255.0 \
                                                             blue:245.0/255.0 \
                                                            alpha:1.0];;
        
        champProposition.keyboardType = UIKeyboardTypeDefault ;
        [champProposition setFont:[UIFont systemFontOfSize:15]];
        champProposition.delegate = self;
        [self.scrollView addSubview:champProposition];

        
        
    } else if (screenBounds.size.height == 736) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,414,736)];
        [self.view addSubview:self.scrollView];

        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD5.5.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,414,149);
        [self.scrollView addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(26, 168, 362, 39)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 5/6\nProposition de résolution";
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
        
        champProposition = [[UITextView alloc] initWithFrame:CGRectMake(26, 271, 362, 159)];
        champProposition.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                            green:245.0/255.0 \
                                                             blue:245.0/255.0 \
                                                            alpha:1.0];;
        
        champProposition.keyboardType = UIKeyboardTypeDefault ;
        [champProposition setFont:[UIFont systemFontOfSize:15]];
        champProposition.delegate = self;
        [self.scrollView addSubview:champProposition];

        
    } else {
        // taille écran non gérée
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
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    
    
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    CGPoint scrollPoint = CGPointMake(0.0,100);
    
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Fin de saisie"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(hideKeyboard:)];
    self.navigationItem.rightBarButtonItem = doneButton ;
    
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}

-(void) hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
    self.navigationItem.rightBarButtonItem = nil;
    
}



-(void) suivant:(id)sender {
    
    NSString *temp = [NSString stringWithFormat:@"%@",champProposition.text];
    
    [[VelObsSingleton sharedPref] setPropositionAmelioration:temp];
    
    PictAndSendViewController *pictController = [[PictAndSendViewController alloc] init];
    [self.navigationController pushViewController:pictController animated:YES ] ;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [self.champProposition resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

