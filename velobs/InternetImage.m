//
//  InternetImage.m
//  velobs
//

#import "InternetImage.h"

@implementation InternetImage

@synthesize ImageUrl, Image, workInProgress, index  ;

-(id) initWithUrl:(NSString*)urlToImage andIndex:(NSUInteger)indexInit
{
	self = [super init];
	
	if(self)
	{
		self.ImageUrl = urlToImage;
		self.index = indexInit ;
	}
	
	return self;
}


- (void)setDelegate:(id)new_delegate
{
    m_Delegate = new_delegate;
}	

-(void)downloadImage:(id)delegate
{
    
    m_Delegate = delegate;
	
	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:ImageUrl] 
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.0];
	imageConnection = [[NSURLConnection alloc] initWithRequest:imageRequest delegate:self];
	
	if(imageConnection)
	{
		workInProgress = YES;
		m_ImageRequestData = [NSMutableData data] ;
	}
}

-(void)abortDownload
{
   	if(workInProgress == YES)
	{
		[imageConnection cancel];
		workInProgress = NO;
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [m_ImageRequestData setLength:0];
	
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [m_ImageRequestData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // error
	workInProgress = NO;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(workInProgress == YES)
	{
		workInProgress = NO;
		UIImage* downloadedImage = [[UIImage alloc] initWithData:m_ImageRequestData];
		self.Image = downloadedImage;
        
		if ([m_Delegate respondsToSelector:@selector(internetImageReady:)])
		{
			[m_Delegate internetImageReady:self ];
		}
	}	
}


@end
