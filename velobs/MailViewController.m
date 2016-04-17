//
//  MailViewController.m
//  velobs
//

#import "MailViewController.h"

@interface MailViewController ()

@end

@implementation MailViewController

@synthesize champMail ;

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
    
    [self setTitle:@"Mail de suivi"];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Changement du mail de suivi";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:labelExplicatif];
        
        champMail = [[UITextField alloc] initWithFrame:CGRectMake(20, 170, 280, 30)];
        champMail.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                                       green:245.0/255.0 \
                                                                        blue:245.0/255.0 \
                                                                       alpha:1.0];;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"email"] != nil ) {
            champMail.placeholder = [defaults objectForKey:@"email"];
        } else {
           champMail.placeholder = @"Entrez ici votre mail";
        }

        champMail.keyboardType = UIKeyboardTypeEmailAddress ;
        champMail.clearButtonMode = UITextFieldViewModeWhileEditing;
        champMail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champMail.delegate = self;
        [self.view addSubview:champMail];
        
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
        [okButton addTarget:self action:@selector(setMail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];

        
    } else if (screenBounds.size.height == 568) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Changement du mail de suivi";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:labelExplicatif];
        
        champMail = [[UITextField alloc] initWithFrame:CGRectMake(20, 170, 280, 30)];
        champMail.backgroundColor = [UIColor clearColor];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"email"] != nil ) {
            champMail.placeholder = [defaults objectForKey:@"email"];
        } else {
            champMail.placeholder = @"Entrez ici votre mail";
        }
        

        champMail.keyboardType = UIKeyboardTypeEmailAddress ;
        champMail.clearButtonMode = UITextFieldViewModeWhileEditing;
        champMail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champMail.delegate = self;
        [self.view addSubview:champMail];
        
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
        [okButton addTarget:self action:@selector(setMail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];
        
        
    } else if (screenBounds.size.height == 667) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD4.7.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,375,135);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(24, 153, 327, 35)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Changement du mail de suivi";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:labelExplicatif];
        
        champMail = [[UITextField alloc] initWithFrame:CGRectMake(24, 199, 327, 35)];
        champMail.backgroundColor = [UIColor clearColor];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"email"] != nil ) {
            champMail.placeholder = [defaults objectForKey:@"email"];
        } else {
            champMail.placeholder = @"Entrez ici votre mail";
        }
        

        champMail.keyboardType = UIKeyboardTypeEmailAddress ;
        champMail.clearButtonMode = UITextFieldViewModeWhileEditing;
        champMail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champMail.delegate = self;
        [self.view addSubview:champMail];
        
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
        [okButton addTarget:self action:@selector(setMail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];
        
        
    } else if (screenBounds.size.height == 736) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD5.5.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,414,149);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(26, 168, 362, 39)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Changement du mail de suivi";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:labelExplicatif];
        
        champMail = [[UITextField alloc] initWithFrame:CGRectMake(26, 220, 362, 39)];
        champMail.backgroundColor = [UIColor clearColor];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"email"] != nil ) {
            champMail.placeholder = [defaults objectForKey:@"email"];
        } else {
            champMail.placeholder = @"Entrez ici votre mail";
        }
        

        champMail.keyboardType = UIKeyboardTypeEmailAddress ;
        champMail.clearButtonMode = UITextFieldViewModeWhileEditing;
        champMail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champMail.delegate = self;
        [self.view addSubview:champMail];
        
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
        [okButton addTarget:self action:@selector(setMail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];
        
      
        
        
    } else {
        // taille écran non gérée
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void) setMail:(id)sender {
    
        [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",champMail.text);
    [self.champMail resignFirstResponder];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:champMail.text] == NO) {
        
        
        
        UIAlertController *alert=   [UIAlertController
                                      alertControllerWithTitle:@"Erreur"
                                      message:@"Veuillez entrer une adresse email valide"
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
    } else {
        
        // Store the data
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:champMail.text forKey:@"email"];
        
    }
    
    
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

