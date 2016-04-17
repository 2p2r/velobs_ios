//
//  CategoryViewController.m
//  velobs
//

#import "CategoryViewController.h"
#import "LocationPropertiesViewController.h"
#import "VelObsSingleton.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

@synthesize thePicker;
@synthesize parser;
@synthesize listeCategory;
@synthesize tempElement;
@synthesize currentAttribute;



-(void) tryConnect:(NSUInteger)index {
    
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
        
        NSURLRequest *theRequest= nil;
 
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
       
            theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/lib/php/mobile/getMobileCategory.php",[[VelObsSingleton sharedPref] serverName]]]
                                        cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:5.0];
      
         NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
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
    //parser = [[NSXMLParser alloc] initWithData:receivedData];
    
    NSString *data = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSString *datatrimmed = [data stringByReplacingOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, 1)];
    parser = [[NSXMLParser alloc] initWithData:[datatrimmed dataUsingEncoding:NSUTF8StringEncoding]];
    
    [parser setDelegate:self];
    [parser parse];
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];

    [thePicker reloadAllComponents];
}

- (void)alertView:(UIAlertView *)alertView  clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ((alertView.tag == 987)||(alertView.tag == 988)) {
      
        [self.navigationController popViewControllerAnimated:YES];
    } else if (alertView.tag == 999) {
        NSLog(@"Error requete") ;
        
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self tryConnect:0];
        }
        
    }
}




- (void)parserDidStartDocument:(NSXMLParser *)parser {
    if (listeCategory == nil)
        listeCategory = [[NSMutableArray alloc] initWithCapacity:0];
    else {
        [listeCategory removeAllObjects];
    }
    
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"souscategorie"]) {
        nbCategory = nbCategory +1;
        
        tempElement = [[SousCategory  alloc] init];
        [listeCategory addObject:tempElement];

        [tempElement setLib:[attributeDict objectForKey: @"nom"]];
        [tempElement setIdd:[attributeDict objectForKey: @"id"]];
       
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(currentAttribute)
    {
        [currentAttribute appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    
    UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Erreur de chargement"
                              message:@"le fichier des catégories n'a pas pu être interprété"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
    [alert show];
    
    
}


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
    
    [self setTitle:@"Catégorie"];
    selected = false ;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 2/6\nSélection de la catégorie qui\ncaractérise votre observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        
        [self.view addSubview:labelExplicatif];
        
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
        
        thePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 190, 280, 160)];
        thePicker.delegate = self;
        thePicker.showsSelectionIndicator = YES;
        [self.view addSubview:thePicker];
        
        
        
    } else if (screenBounds.size.height == 568) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 2/6\nSélection de la catégorie qui\ncaractérise votre observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
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
        
        thePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 220, 280, 160)];
        thePicker.delegate = self;
        thePicker.showsSelectionIndicator = YES;
        [self.view addSubview:thePicker];
        
        
    } else if (screenBounds.size.height == 667) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD4.7.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,375,135);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(24, 153, 327, 35)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 2/6\nSélection de la catégorie qui\ncaractérise votre observation";
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
        
        thePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(24, 257, 328, 187)];
        thePicker.delegate = self;
        thePicker.showsSelectionIndicator = YES;
        [self.view addSubview:thePicker];
        
        
    } else if (screenBounds.size.height == 736) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD5.5.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,414,149);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(26, 168, 362, 39)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Étape 2/6\nSélection de la catégorie qui\ncaractérise votre observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        
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
        
        thePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(26, 284, 362, 206)];
        thePicker.delegate = self;
        thePicker.showsSelectionIndicator = YES;
        [self.view addSubview:thePicker];
        
        
        
        
    } else {
        // taille d'écran non gérée
    }
    
    
    [self tryConnect:0];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void) suivant:(id)sender {
    
    if (selected == false) {
        [[VelObsSingleton sharedPref] setCategorie:[[listeCategory objectAtIndex:0] idd ]];
    }
     
    LocationPropertiesViewController *locViewController = [[LocationPropertiesViewController alloc] init];
    [self.navigationController pushViewController:locViewController animated:YES ] ;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
   
    selected = true ;
    [[VelObsSingleton sharedPref] setCategorie:[[listeCategory objectAtIndex:row] idd ]];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return listeCategory.count;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title;
    title = [[listeCategory objectAtIndex:row] lib] ;
    return title;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
