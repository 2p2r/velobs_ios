//
//  ReviewProxViewController.m
//  velobs
//

#import "ReviewProxViewController.h"
#import "UpdateProxViewController.h"
#import "VelObsSingleton.h"
#import "InternetImage.h"

@interface ReviewProxViewController ()

@end

@implementation ReviewProxViewController



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
    
    [self setTitle:@"Observation"];
    
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        
        UIImage *myTopImage = [UIImage imageNamed:@"bandeau.png"];
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:myTopImage];
        topImageView.frame = CGRectMake(0,0,320,115);
        [self.view addSubview:topImageView];
        
        UILabel *labelExplicatif =[[UILabel alloc] initWithFrame:CGRectMake(10, 130, 300, 30)];
        labelExplicatif.backgroundColor =[UIColor clearColor];
        labelExplicatif.text = @"Description de l'observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        
        [self.view addSubview:labelExplicatif];
        
        if ([[VelObsSingleton sharedPref].poi.photo isEqualToString:@""]) {
            
            UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 170, 280, 170)];
            scrollview.contentSize = CGSizeMake(280, 170);
            
            
            UILabel *labeldistance =[[UILabel alloc] initWithFrame:CGRectMake(0,0, 280,170)];
            labeldistance.backgroundColor =[UIColor clearColor];
            labeldistance.text = [NSString stringWithFormat:@"À %@ mètres, dans la ville de %@\n\nCatégorie : %@\n\nDescription : %@",[VelObsSingleton sharedPref].poi.distance,[VelObsSingleton sharedPref].poi.ville,[VelObsSingleton sharedPref].poi.cat,[VelObsSingleton sharedPref].poi.desc];
           
            labeldistance.textColor = [UIColor darkGrayColor];
            labeldistance.textAlignment = NSTextAlignmentLeft;
            labeldistance.font = [UIFont systemFontOfSize:14.0];
            labeldistance.numberOfLines = 0 ;
            labeldistance.lineBreakMode = NSLineBreakByWordWrapping;
          
            
            CGSize maximumLabel4Size = CGSizeMake(280,1000);
            CGSize expectedLabelSize = [labeldistance.text sizeWithFont:labeldistance.font
                                                   constrainedToSize:maximumLabel4Size
                                                       lineBreakMode:labeldistance.lineBreakMode];
            
            
            
            
            if (expectedLabelSize.height > 170) {
                CGRect newFrameLabel = labeldistance.frame;
                newFrameLabel.size.height = expectedLabelSize.height;
                labeldistance.frame = newFrameLabel;
                scrollview.contentSize = CGSizeMake(280, expectedLabelSize.height);
                
            }

            [scrollview addSubview:labeldistance];
            [self.view addSubview:scrollview];

        } else {
            
            
            UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 170, 280, 170)];
            scrollview.contentSize = CGSizeMake(280, 430);
            
            
            UILabel *labeldistance =[[UILabel alloc] initWithFrame:CGRectMake(0,0, 280,170)];
            labeldistance.backgroundColor =[UIColor clearColor];
            labeldistance.text = [NSString stringWithFormat:@"À %@ mètres, dans la ville de %@\n\nCatégorie : %@\n\nDescription : %@",[VelObsSingleton sharedPref].poi.distance,[VelObsSingleton sharedPref].poi.ville,[VelObsSingleton sharedPref].poi.cat,[VelObsSingleton sharedPref].poi.desc];
            
            labeldistance.textColor = [UIColor darkGrayColor];
            labeldistance.textAlignment = NSTextAlignmentLeft;
            labeldistance.font = [UIFont systemFontOfSize:14.0];
            labeldistance.numberOfLines = 0 ;
            labeldistance.lineBreakMode = NSLineBreakByWordWrapping;
            
            CGSize maximumLabel4Size = CGSizeMake(280,1000);
            CGSize expectedLabelSize = [labeldistance.text sizeWithFont:labeldistance.font
                                                      constrainedToSize:maximumLabel4Size
                                                          lineBreakMode:labeldistance.lineBreakMode];
            
            if (expectedLabelSize.height > 170) {
                CGRect newFrameLabel = labeldistance.frame;
                newFrameLabel.size.height = expectedLabelSize.height;
                labeldistance.frame = newFrameLabel;
                scrollview.contentSize = CGSizeMake(280, expectedLabelSize.height+240+20);
                imageObs = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, expectedLabelSize.height+20, 240, 240.0)];
                [scrollview addSubview:imageObs];
                
                
            } else {
                
                imageObs = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 190.0, 240.0, 240.0)];
                [scrollview addSubview:imageObs];
                
            }
            
            imageObs.contentMode = UIViewContentModeScaleAspectFit;
            
            InternetImage *asynchImage = [[InternetImage alloc] initWithUrl:[NSString stringWithFormat:@"http://velobs.mooveatis.com/resources/pictures/%@",[VelObsSingleton sharedPref].poi.photo] andIndex:0];
            
            [asynchImage downloadImage:self];
            
            [scrollview addSubview:labeldistance];
            [self.view addSubview:scrollview];
          
        }
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20,360, 280, 30);
        [okButton setTitle:@"METTRE À JOUR" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Description de l'observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        
        if ([[VelObsSingleton sharedPref].poi.photo isEqualToString:@""]) {
            
            UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 170, 280, 240)];
            scrollview.contentSize = CGSizeMake(280, 240);
            
            
            UILabel *labeldistance =[[UILabel alloc] initWithFrame:CGRectMake(0,0, 280,170)];
            labeldistance.backgroundColor =[UIColor clearColor];
            labeldistance.text = [NSString stringWithFormat:@"À %@ mètres, dans la ville de %@\n\nCatégorie : %@\n\nDescription : %@",[VelObsSingleton sharedPref].poi.distance,[VelObsSingleton sharedPref].poi.ville,[VelObsSingleton sharedPref].poi.cat,[VelObsSingleton sharedPref].poi.desc];
            
            labeldistance.textColor = [UIColor darkGrayColor];
            labeldistance.textAlignment = NSTextAlignmentLeft;
            labeldistance.font = [UIFont systemFontOfSize:14.0];
            labeldistance.numberOfLines = 0 ;
            labeldistance.lineBreakMode = NSLineBreakByWordWrapping;
            
            CGSize maximumLabel4Size = CGSizeMake(280,1000);
            CGSize expectedLabelSize = [labeldistance.text sizeWithFont:labeldistance.font
                                                      constrainedToSize:maximumLabel4Size
                                                          lineBreakMode:labeldistance.lineBreakMode];
            
            if (expectedLabelSize.height > 170) {
                CGRect newFrameLabel = labeldistance.frame;
                newFrameLabel.size.height = expectedLabelSize.height;
                labeldistance.frame = newFrameLabel;
                scrollview.contentSize = CGSizeMake(280, expectedLabelSize.height);
                
            }
            
            [scrollview addSubview:labeldistance];
            [self.view addSubview:scrollview];
            
        }
        
        else {
            
            UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 170, 280, 240)];
            scrollview.contentSize = CGSizeMake(280, 430);
            
            
            UILabel *labeldistance =[[UILabel alloc] initWithFrame:CGRectMake(0,0, 280,170)];
            labeldistance.backgroundColor =[UIColor clearColor];
            labeldistance.text = [NSString stringWithFormat:@"À %@ mètres, dans la ville de %@\n\nCatégorie : %@\n\nDescription : %@",[VelObsSingleton sharedPref].poi.distance,[VelObsSingleton sharedPref].poi.ville,[VelObsSingleton sharedPref].poi.cat,[VelObsSingleton sharedPref].poi.desc];
            
            labeldistance.textColor = [UIColor darkGrayColor];
            labeldistance.textAlignment = NSTextAlignmentLeft;
            labeldistance.font = [UIFont systemFontOfSize:14.0];
            labeldistance.numberOfLines = 0 ;
            labeldistance.lineBreakMode = NSLineBreakByWordWrapping;
            
            CGSize maximumLabel4Size = CGSizeMake(280,1000);
            CGSize expectedLabelSize = [labeldistance.text sizeWithFont:labeldistance.font
                                                      constrainedToSize:maximumLabel4Size
                                                          lineBreakMode:labeldistance.lineBreakMode];
            
            if (expectedLabelSize.height > 170) {
                CGRect newFrameLabel = labeldistance.frame;
                newFrameLabel.size.height = expectedLabelSize.height;
                labeldistance.frame = newFrameLabel;
                scrollview.contentSize = CGSizeMake(280, expectedLabelSize.height+240+20);
                imageObs = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, expectedLabelSize.height+20, 240, 240.0)];
                
                
            } else {
                imageObs = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 190.0, 240.0, 240.0)];
                
            }
            
            imageObs.contentMode = UIViewContentModeScaleAspectFit;
            
            InternetImage *asynchImage = [[InternetImage alloc] initWithUrl:[NSString stringWithFormat:@"http://velobs.mooveatis.com/resources/pictures/%@",[VelObsSingleton sharedPref].poi.photo] andIndex:0];
            
            [asynchImage downloadImage:self];
            
            [scrollview addSubview:labeldistance];
            [scrollview addSubview:imageObs];
            [self.view addSubview:scrollview];
            
        }
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20,448, 280, 30);
        [okButton setTitle:@"METTRE À JOUR" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Description de l'observation";
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
        
        
        if ([[VelObsSingleton sharedPref].poi.photo isEqualToString:@""]) {
            
            UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(24, 199, 327, 281)];
            scrollview.contentSize = CGSizeMake(327, 281);
            
            
            UILabel *labeldistance =[[UILabel alloc] initWithFrame:CGRectMake(0,0, 327,281)];
            labeldistance.backgroundColor =[UIColor clearColor];
            labeldistance.text = [NSString stringWithFormat:@"À %@ mètres, dans la ville de %@\n\nCatégorie : %@\n\nDescription : %@",[VelObsSingleton sharedPref].poi.distance,[VelObsSingleton sharedPref].poi.ville,[VelObsSingleton sharedPref].poi.cat,[VelObsSingleton sharedPref].poi.desc];
            
            labeldistance.textColor = [UIColor darkGrayColor];
            labeldistance.textAlignment = NSTextAlignmentLeft;
            labeldistance.font = [UIFont systemFontOfSize:14.0];
            labeldistance.numberOfLines = 0 ;
            labeldistance.lineBreakMode = NSLineBreakByWordWrapping;
            
            CGSize maximumLabel4Size = CGSizeMake(327,1170);
            CGSize expectedLabelSize = [labeldistance.text sizeWithFont:labeldistance.font
                                                      constrainedToSize:maximumLabel4Size
                                                          lineBreakMode:labeldistance.lineBreakMode];
            
            
            if (expectedLabelSize.height > 281) {
                
                CGRect newFrameLabel = labeldistance.frame;
                newFrameLabel.size.height = expectedLabelSize.height;
                labeldistance.frame = newFrameLabel;
                scrollview.contentSize = CGSizeMake(327, expectedLabelSize.height);
                
            }
            
            [scrollview addSubview:labeldistance];
            [self.view addSubview:scrollview];
            
        } else {
            
            UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(24, 199, 328, 281)];
            scrollview.contentSize = CGSizeMake(328, 503);
            
            
            UILabel *labeldistance =[[UILabel alloc] initWithFrame:CGRectMake(0,0, 328,199)];
            labeldistance.backgroundColor =[UIColor clearColor];
            labeldistance.text = [NSString stringWithFormat:@"À %@ mètres, dans la ville de %@\n\nCatégorie : %@\n\nDescription : %@",[VelObsSingleton sharedPref].poi.distance,[VelObsSingleton sharedPref].poi.ville,[VelObsSingleton sharedPref].poi.cat,[VelObsSingleton sharedPref].poi.desc];
            
            labeldistance.textColor = [UIColor darkGrayColor];
            labeldistance.textAlignment = NSTextAlignmentLeft;
            labeldistance.font = [UIFont systemFontOfSize:14.0];
            labeldistance.numberOfLines = 0 ;
            labeldistance.lineBreakMode = NSLineBreakByWordWrapping;
            
            CGSize maximumLabel4Size = CGSizeMake(328,1170);
            CGSize expectedLabelSize = [labeldistance.text sizeWithFont:labeldistance.font
                                                      constrainedToSize:maximumLabel4Size
                                                          lineBreakMode:labeldistance.lineBreakMode];
            
            if (expectedLabelSize.height > 199) {
                CGRect newFrameLabel = labeldistance.frame;
                newFrameLabel.size.height = expectedLabelSize.height;
                labeldistance.frame = newFrameLabel;
                scrollview.contentSize = CGSizeMake(328, expectedLabelSize.height+281+24);
                imageObs = [[UIImageView alloc] initWithFrame:CGRectMake(24.0, expectedLabelSize.height+24, 281, 281)];
                
                
            } else {
                imageObs = [[UIImageView alloc] initWithFrame:CGRectMake(24.0, 222.0, 281.0, 281.0)];
                
            }
            
            imageObs.contentMode = UIViewContentModeScaleAspectFit;
            
            InternetImage *asynchImage = [[InternetImage alloc] initWithUrl:[NSString stringWithFormat:@"http://velobs.mooveatis.com/resources/pictures/%@",[VelObsSingleton sharedPref].poi.photo] andIndex:0];
            
            [asynchImage downloadImage:self];
            
            [scrollview addSubview:labeldistance];
            [scrollview addSubview:imageObs];
            [self.view addSubview:scrollview];
            
        }
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(24,524, 327, 35);
        [okButton setTitle:@"METTRE À JOUR" forState:UIControlStateNormal];
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
        labelExplicatif.text = @"Description de l'observation";
        labelExplicatif.textColor = [UIColor darkGrayColor];
        labelExplicatif.textAlignment = NSTextAlignmentCenter;
        labelExplicatif.font = [UIFont boldSystemFontOfSize:18.0];
        labelExplicatif.numberOfLines = 0 ;
        CGSize labelSize = [labelExplicatif.text sizeWithAttributes:@{NSFontAttributeName:labelExplicatif.font}];
        labelExplicatif.frame = CGRectMake(
                                           labelExplicatif.frame.origin.x, labelExplicatif.frame.origin.y,
                                           labelExplicatif.frame.size.width, labelSize.height);
        [self.view addSubview:labelExplicatif];
        
        
        if ([[VelObsSingleton sharedPref].poi.photo isEqualToString:@""]) {
            
            UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(26, 219, 362, 310)];
            scrollview.contentSize = CGSizeMake(362, 310);
            
            
            UILabel *labeldistance =[[UILabel alloc] initWithFrame:CGRectMake(0,0, 362,310)];
            labeldistance.backgroundColor =[UIColor clearColor];
            labeldistance.text = [NSString stringWithFormat:@"À %@ mètres, dans la ville de %@\n\nCatégorie : %@\n\nDescription : %@",[VelObsSingleton sharedPref].poi.distance,[VelObsSingleton sharedPref].poi.ville,[VelObsSingleton sharedPref].poi.cat,[VelObsSingleton sharedPref].poi.desc];
            
            labeldistance.textColor = [UIColor darkGrayColor];
            labeldistance.textAlignment = NSTextAlignmentLeft;
            labeldistance.font = [UIFont systemFontOfSize:14.0];
            labeldistance.numberOfLines = 0 ;
            labeldistance.lineBreakMode = NSLineBreakByWordWrapping;
            
            CGSize maximumLabel4Size = CGSizeMake(362,1290);
            CGSize expectedLabelSize = [labeldistance.text sizeWithFont:labeldistance.font
                                                      constrainedToSize:maximumLabel4Size
                                                          lineBreakMode:labeldistance.lineBreakMode];
            
            
            if (expectedLabelSize.height > 310) {
                
                CGRect newFrameLabel = labeldistance.frame;
                newFrameLabel.size.height = expectedLabelSize.height;
                labeldistance.frame = newFrameLabel;
                scrollview.contentSize = CGSizeMake(362, expectedLabelSize.height);
                
            }
            
            [scrollview addSubview:labeldistance];
            [self.view addSubview:scrollview];
            
        }
        
        else {
            
            UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(26, 219, 362, 310)];
            scrollview.contentSize = CGSizeMake(362, 555);
            
            
            UILabel *labeldistance =[[UILabel alloc] initWithFrame:CGRectMake(0,0, 362,219)];
            labeldistance.backgroundColor =[UIColor clearColor];
            labeldistance.text = [NSString stringWithFormat:@"À %@ mètres, dans la ville de %@\n\nCatégorie : %@\n\nDescription : %@",[VelObsSingleton sharedPref].poi.distance,[VelObsSingleton sharedPref].poi.ville,[VelObsSingleton sharedPref].poi.cat,[VelObsSingleton sharedPref].poi.desc];
            
            labeldistance.textColor = [UIColor darkGrayColor];
            labeldistance.textAlignment = NSTextAlignmentLeft;
            labeldistance.font = [UIFont systemFontOfSize:14.0];
            labeldistance.numberOfLines = 0 ;
            labeldistance.lineBreakMode = NSLineBreakByWordWrapping;
            
            CGSize maximumLabel4Size = CGSizeMake(362,1290);
            CGSize expectedLabelSize = [labeldistance.text sizeWithFont:labeldistance.font
                                                      constrainedToSize:maximumLabel4Size
                                                          lineBreakMode:labeldistance.lineBreakMode];
            
            if (expectedLabelSize.height > 219) {
                CGRect newFrameLabel = labeldistance.frame;
                newFrameLabel.size.height = expectedLabelSize.height;
                labeldistance.frame = newFrameLabel;
                scrollview.contentSize = CGSizeMake(362, expectedLabelSize.height+310+26);
                imageObs = [[UIImageView alloc] initWithFrame:CGRectMake(26.0, expectedLabelSize.height+26, 310, 310.0)];
                
                
            } else {
                imageObs = [[UIImageView alloc] initWithFrame:CGRectMake(26.0, 245.0, 310.0, 310.0)];
                
            }
            
            imageObs.contentMode = UIViewContentModeScaleAspectFit;
            
            InternetImage *asynchImage = [[InternetImage alloc] initWithUrl:[NSString stringWithFormat:@"http://velobs.mooveatis.com/resources/pictures/%@",[VelObsSingleton sharedPref].poi.photo] andIndex:0];
            
            [asynchImage downloadImage:self];
            
            [scrollview addSubview:labeldistance];
            [scrollview addSubview:imageObs];
            [self.view addSubview:scrollview];
            
        }

        
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(26,578, 362, 39);
        [okButton setTitle:@"METTRE À JOUR" forState:UIControlStateNormal];
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

-(void) internetImageReady:(InternetImage*)downloadedImage
{
    if (downloadedImage.Image!=nil) {
        imageObs.image = downloadedImage.Image;
    }
    
}


-(void) suivant:(id)sender {
    
    UpdateProxViewController *updateViewController = [[UpdateProxViewController alloc] init];
    [self.navigationController pushViewController:updateViewController animated:YES ] ;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

