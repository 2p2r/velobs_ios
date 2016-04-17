//
//  UpdateProxViewController.m
//  velobs
//

#import "UpdateProxViewController.h"
#import "VelObsSingleton.h"

@interface UpdateProxViewController ()

@end

@implementation UpdateProxViewController

@synthesize champCommentaire ;

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
    
    [self setTitle:@"Mise à jour"];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Mise à jour d'une observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        
        [self.view addSubview:labelExplicatif];
        
        
        champCommentaire = [[UITextField alloc] initWithFrame:CGRectMake(20, 190, 280, 30)];
        champCommentaire.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                         green:245.0/255.0 \
                                                          blue:245.0/255.0 \
                                                         alpha:1.0];;
        
        
        
        champCommentaire.placeholder = @"Ecrivez ici votre commentaire";
        
        
        champCommentaire.keyboardType = UIKeyboardTypeDefault ;
        champCommentaire.clearButtonMode = UITextFieldViewModeWhileEditing;
        champCommentaire.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champCommentaire.delegate = self;
         champCommentaire.tag = 1 ;
        [self.view addSubview:champCommentaire];
        
        
        
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(20,240, 280, 30);
        [photoButton setTitle:@"AJOUTER UNE PHOTO" forState:UIControlStateNormal];
        [photoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [photoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [photoButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                        green:220.0/255.0 \
                                                         blue:220.0/255.0 \
                                                        alpha:1.0]];
        [photoButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [photoButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [photoButton.layer setShadowOpacity:0.5];
        [photoButton addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:photoButton];
        
        photoAdded = false ;
        
        photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 290, 280, 30)];
        photoLabel.backgroundColor = [UIColor clearColor];
        photoLabel.textColor = [UIColor darkGrayColor];
        photoLabel.textAlignment = NSTextAlignmentCenter;
        photoLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:photoLabel];
        
        
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20,360, 280, 30);
        [okButton setTitle:@"ENVOYER" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Mise à jour d'une observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        
        champCommentaire = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 280, 30)];
        champCommentaire.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                            green:245.0/255.0 \
                                                             blue:245.0/255.0 \
                                                            alpha:1.0];
        
        champCommentaire.placeholder = @"Ecrivez ici votre commentaire";
        
        champCommentaire.keyboardType = UIKeyboardTypeDefault ;
        champCommentaire.clearButtonMode = UITextFieldViewModeWhileEditing;
        champCommentaire.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champCommentaire.delegate = self;
        champCommentaire.tag = 1 ;
        [self.view addSubview:champCommentaire];
        
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(20,260, 280, 30);
        [photoButton setTitle:@"AJOUTER UNE PHOTO" forState:UIControlStateNormal];
        [photoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [photoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [photoButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                        green:220.0/255.0 \
                                                         blue:220.0/255.0 \
                                                        alpha:1.0]];
        [photoButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [photoButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [photoButton.layer setShadowOpacity:0.5];
        [photoButton addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:photoButton];
        
        photoAdded = false ;
        
        photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 280, 30)];
        photoLabel.backgroundColor = [UIColor clearColor];
        photoLabel.textColor = [UIColor darkGrayColor];
        photoLabel.textAlignment = NSTextAlignmentCenter;
        photoLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:photoLabel];
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20,448, 280, 30);
        [okButton setTitle:@"ENVOYER" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Mise à jour d'une observation";
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
        
        
        champCommentaire = [[UITextField alloc] initWithFrame:CGRectMake(24, 234, 327, 35)];
        champCommentaire.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                            green:245.0/255.0 \
                                                             blue:245.0/255.0 \
                                                            alpha:1.0];
        
        champCommentaire.placeholder = @"Ecrivez ici votre commentaire";
        
        champCommentaire.keyboardType = UIKeyboardTypeDefault ;
        champCommentaire.clearButtonMode = UITextFieldViewModeWhileEditing;
        champCommentaire.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champCommentaire.delegate = self;
        champCommentaire.tag = 1 ;
        [self.view addSubview:champCommentaire];
        
        
        
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(24,304, 327, 35);
        [photoButton setTitle:@"AJOUTER UNE PHOTO" forState:UIControlStateNormal];
        [photoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [photoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [photoButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                        green:220.0/255.0 \
                                                         blue:220.0/255.0 \
                                                        alpha:1.0]];
        [photoButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [photoButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [photoButton.layer setShadowOpacity:0.5];
        [photoButton addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:photoButton];
        
        photoAdded = false ;
        
        photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 374, 327, 35)];
        photoLabel.backgroundColor = [UIColor clearColor];
        photoLabel.textColor = [UIColor darkGrayColor];
        photoLabel.textAlignment = NSTextAlignmentCenter;
        photoLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:photoLabel];
    
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(24,524, 327, 35);
        [okButton setTitle:@"ENVOYER" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Mise à jour d'une observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        
        champCommentaire = [[UITextField alloc] initWithFrame:CGRectMake(26, 258, 362, 39)];
        champCommentaire.backgroundColor =  [UIColor colorWithRed:245.0/255.0 \
                                                            green:245.0/255.0 \
                                                             blue:245.0/255.0 \
                                                            alpha:1.0];
        
        champCommentaire.placeholder = @"Ecrivez ici votre commentaire";
        champCommentaire.keyboardType = UIKeyboardTypeDefault ;
        champCommentaire.clearButtonMode = UITextFieldViewModeWhileEditing;
        champCommentaire.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        champCommentaire.delegate = self;
        champCommentaire.tag = 1 ;
        [self.view addSubview:champCommentaire];
 
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(26,335, 362, 39);
        [photoButton setTitle:@"AJOUTER UNE PHOTO" forState:UIControlStateNormal];
        [photoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [photoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [photoButton setBackgroundColor:[UIColor colorWithRed:220.0/255.0 \
                                                        green:220.0/255.0 \
                                                         blue:220.0/255.0 \
                                                        alpha:1.0]];
        [photoButton.layer setShadowOffset:CGSizeMake(2, 2)];
        [photoButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [photoButton.layer setShadowOpacity:0.5];
        [photoButton addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:photoButton];
        
        photoAdded = false ;
        
        photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 413, 362, 39)];
        photoLabel.backgroundColor = [UIColor clearColor];
        photoLabel.textColor = [UIColor darkGrayColor];
        photoLabel.textAlignment = NSTextAlignmentCenter;
        photoLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:photoLabel];
        
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(26,578, 362, 39);
        [okButton setTitle:@"ENVOYER" forState:UIControlStateNormal];
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
       // taille d'écran non gérée
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
        
    [self.champCommentaire resignFirstResponder];
    
    return YES;
    
}

-(void) suivant:(id)sender {
    
    if (photoAdded) {
        
        [self tryConnectMultipart:0];
        
    } else {
        
        [self tryConnectFormUrlEncoded:0];
        
    }
    
}


-(void) addPhoto:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - Image picker delegate methdos
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        
        if ([[UIScreen mainScreen] scale]== 3.0) {
            
            // retina hd
            
            imageScaled = [self imageWithImage:image scaledToSize:CGSizeMake(342*image.size.width/image.size.height,342)];
            
            
        } else {
            
            // retina
            
            imageScaled = [self imageWithImage:image scaledToSize:CGSizeMake(512*image.size.width/image.size.height,512)];
  
        }
        
    } else {
        
        imageScaled = [self imageWithImage:image scaledToSize:CGSizeMake(1024*image.size.width/image.size.height,1024)];
        
    }

    [picker dismissViewControllerAnimated:NO completion:nil];
    
    photoAdded = true ;
    photoLabel.text = @"Photo ajoutée";
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(void) tryConnectFormUrlEncoded:(NSUInteger)index {
    
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    
    
    waitingAlert = [[UIAlertView alloc] initWithTitle:@"Merci de patienter..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] ;
    [waitingAlert show];
    
    
    if (index==4) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
        UIAlertView *alert1 = [[UIAlertView alloc]
                               initWithTitle:@"Problème de réseau"
                               message:@"La connection au serveur a échoué"
                               delegate:self
                               cancelButtonTitle:nil
                               otherButtonTitles:@"OK", nil];
        alert1.tag=988;
        [alert1 show];
        
    }
    else {
        nbConnection = index + 1;
        
        
        NSMutableURLRequest *theRequest= nil;
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        
        theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/lib/php/mobile/velObsUpdatePoi.php",[[VelObsSingleton sharedPref] serverName]]]
                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                       timeoutInterval:5.0];
        [theRequest setHTTPMethod:@"POST"];
        
       NSString *post = [NSString stringWithFormat:@"id=%@&comment=%@",[[[VelObsSingleton sharedPref] poi] idd],champCommentaire.text ];
        
        NSLog(post);
        
        
        NSData *requestBodyData = [post dataUsingEncoding:NSUTF8StringEncoding];
        theRequest.HTTPBody = requestBodyData;
        
        [theRequest setValue:[NSString stringWithFormat:@"%d",
                              [post length]]
          forHTTPHeaderField:@"Content-length"];
        
        [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        if (theConnection) {
            receivedData = [NSMutableData data];
        } else {
            // connection failed.
        }
        
    }
    
}



-(void) tryConnectMultipart:(NSUInteger)index {
    
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    
    
    waitingAlert = [[UIAlertView alloc] initWithTitle:@"Merci de patienter..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] ;
    [waitingAlert show];
    
    
    if (index==4) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
        UIAlertView *alert1 = [[UIAlertView alloc]
                               initWithTitle:@"Problème de réseau"
                               message:@"La connection au serveur a échoué"
                               delegate:self
                               cancelButtonTitle:nil
                               otherButtonTitles:@"OK", nil];
        alert1.tag=988;
        [alert1 show];
        
    }
    else {
        nbConnection = index + 1;
       
        NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
       
        [_params setObject:[NSString stringWithString:[[[VelObsSingleton sharedPref] poi] idd] ] forKey:@"id"];
        [_params setObject:champCommentaire.text forKey:@"comment"];

        NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";

        NSString* FileParamConstant = @"photo1";
        
        NSURL* requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/lib/php/mobile/velObsUpdatePoi.php",[[VelObsSingleton sharedPref] serverName]]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setHTTPShouldHandleCookies:NO];
        [request setTimeoutInterval:30];
        [request setHTTPMethod:@"POST"];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];

        NSMutableData *body = [NSMutableData data];
        
        for (NSString *param in _params) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        NSData *imageData = UIImageJPEGRepresentation(imageScaled, 0.7);
        if (imageData) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDateFormatter* f = [[NSDateFormatter alloc] init] ;
            [f setDateFormat:@"yyyyMMddhhmmss"];
            NSString* filename = [ [f stringFromDate:[NSDate date]] stringByReplacingOccurrencesOfString:@":" withString:@""];
            
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n", FileParamConstant,filename] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];

        [request setHTTPBody:body];

        NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        [request setURL:requestURL];

        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (theConnection) {
            receivedData = [NSMutableData data];
        } else {
            // connection failed.
        }
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    
    UIAlertView *alert1 = [[UIAlertView alloc]
                           initWithTitle:@"Un problème de réseau est survenu"
                           message:nil
                           delegate:self
                           cancelButtonTitle:@"Annuler"
                           otherButtonTitles:@"Réessayer", nil];
    alert1.tag=999;
    [alert1 show];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView  clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ((alertView.tag == 987)||(alertView.tag == 988)) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } else if (alertView.tag == 999) {
        NSLog(@"Error requete") ;
        
        if (buttonIndex==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            if (photoAdded) {
                [self tryConnectMultipart:0];
            } else {
                [self tryConnectFormUrlEncoded:0];
            }
            
            
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

