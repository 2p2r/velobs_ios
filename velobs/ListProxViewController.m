//
//  ListProxViewController.m
//  velobs
//

#import "ListProxViewController.h"
#import "CategoryViewController.h"
#import "ReviewProxViewController.h"
#import "VelObsSingleton.h"

@interface ListProxViewController ()

@end

@implementation ListProxViewController


@synthesize parser;
@synthesize listeOldObs;
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
        
        
        NSMutableURLRequest *theRequest= nil;
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        
        theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/lib/php/mobile/checkProxPoi.php",[[VelObsSingleton sharedPref] serverName]]]
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                timeoutInterval:5.0];
        
        [theRequest setHTTPMethod:@"POST"];
        
        
        NSString *post = [NSString stringWithFormat:@"lat=%g&lng=%g",[[VelObsSingleton sharedPref] localisation].coordinate.latitude,[[VelObsSingleton sharedPref] localisation].coordinate.longitude];
       
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
    
    [proxTableView reloadData];
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
    if (listeOldObs == nil)
        listeOldObs = [[NSMutableArray alloc] initWithCapacity:0];
    else {
        [listeOldObs removeAllObjects];
    }
    
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"poi"]) {
        nbOldObs = nbOldObs +1;
        
        tempElement = [[OldObs  alloc] init];
        [listeOldObs addObject:tempElement];
        
        [tempElement setIdd:[attributeDict objectForKey: @"id"]];
        
        
    } else if([elementName isEqualToString:@"category"])
    {
        currentAttribute = [NSMutableString string];
    }
    else if([elementName isEqualToString:@"adresse"])
    {
        currentAttribute = [NSMutableString string];
    }
    else if([elementName isEqualToString:@"ville"])
    {
        currentAttribute = [NSMutableString string];
    }
    else if([elementName isEqualToString:@"desc"])
    {
        currentAttribute = [NSMutableString string];
    }
    else if([elementName isEqualToString:@"distance"])
    {
        currentAttribute = [NSMutableString string];
    }
    else if([elementName isEqualToString:@"status"])
    {
        currentAttribute = [NSMutableString string];
    }
    else if([elementName isEqualToString:@"photo"])
    {
        currentAttribute = [NSMutableString string];
    } else if([elementName isEqualToString:@"num"])
    {
        currentAttribute = [NSMutableString string];
    }
    

    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
   
    if([elementName isEqualToString:@"category"])
    {
        [tempElement setCat:currentAttribute];
    }
    else if([elementName isEqualToString:@"adresse"])
    {
        [tempElement setAdresse:currentAttribute];
    }
    else if([elementName isEqualToString:@"ville"])
    {
        [tempElement setVille:currentAttribute];
    }
    else if([elementName isEqualToString:@"desc"])
    {
        [tempElement setDesc:currentAttribute];
    }
    else if([elementName isEqualToString:@"distance"])
    {
        [tempElement setDistance:currentAttribute];
    }
    else if([elementName isEqualToString:@"status"])
    {
        [tempElement setStatus:currentAttribute];
    }
    else if([elementName isEqualToString:@"photo"])
    {
        [tempElement setPhoto:currentAttribute];
    }
    else if([elementName isEqualToString:@"num"])
    {
        [tempElement setRepere:currentAttribute];
    }

    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(currentAttribute)
    {
        [currentAttribute appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSLog([parseError localizedDescription]);
    
    
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    
           UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Erreur de chargement"
                              message:@"le fichier des observations n'a pas pu être interprété"
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
    
    [self setTitle:@"Doublons"];
    
    [self tryConnect:0];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(15, 130, 290, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Liste des observations à proximité";
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
        [okButton setTitle:@"NOUVELLE OBSERVATION" forState:UIControlStateNormal];
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
        
        proxTableView=[[UITableView alloc]init];
        proxTableView.frame = CGRectMake(20,180,280,200);
        proxTableView.dataSource=self;
        proxTableView.delegate=self;
        proxTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [proxTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [proxTableView reloadData];
        [self.view addSubview:proxTableView];
        
        
    } else if (screenBounds.size.height == 568) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Liste des observations à proximité";
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
        [okButton setTitle:@"NOUVELLE OBSERVATION" forState:UIControlStateNormal];
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
        
        proxTableView=[[UITableView alloc]init];
        proxTableView.frame = CGRectMake(20,180,280,300);
        proxTableView.dataSource=self;
        proxTableView.delegate=self;
        proxTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [proxTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [proxTableView reloadData];
        [self.view addSubview:proxTableView];
        
        
    } else if (screenBounds.size.height == 667) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD4.7.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,375,135);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(24, 153, 327, 35)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Liste des observations à proximité";
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
        [okButton setTitle:@"NOUVELLE OBSERVATION" forState:UIControlStateNormal];
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
        
        proxTableView=[[UITableView alloc]init];
        proxTableView.frame = CGRectMake(24,211,328,351);
        proxTableView.dataSource=self;
        proxTableView.delegate=self;
        proxTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [proxTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [proxTableView reloadData];
        
        [self.view addSubview:proxTableView];
        
        
    } else if (screenBounds.size.height == 736) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeauHD5.5.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,414,149);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(26, 168, 362, 39)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Liste des observations à proximité";
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
        [okButton setTitle:@"NOUVELLE OBSERVATION" forState:UIControlStateNormal];
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
        
        proxTableView=[[UITableView alloc]init];
        proxTableView.frame = CGRectMake(26,232,362,387);
        proxTableView.dataSource=self;
        proxTableView.delegate=self;
        proxTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [proxTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [proxTableView reloadData];
        [self.view addSubview:proxTableView];
        
        
        
        
    } else {
        // taille écran non gérée
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void) suivant:(id)sender {
    
    CategoryViewController *catViewController = [[CategoryViewController alloc] init];
    [self.navigationController pushViewController:catViewController animated:YES ] ;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listeOldObs.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
   
    cell.textLabel.text = [[listeOldObs objectAtIndexedSubscript:indexPath.row] cat ];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"à %@ mètres, %@ ",[[listeOldObs objectAtIndexedSubscript:indexPath.row] distance ],[[listeOldObs objectAtIndexedSubscript:indexPath.row] adresse ]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[VelObsSingleton sharedPref] setPoi:[listeOldObs objectAtIndex:indexPath.row]];
    
    ReviewProxViewController *proxViewController = [[ReviewProxViewController alloc] init];
   
    
    [self.navigationController pushViewController:proxViewController animated:YES ] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

