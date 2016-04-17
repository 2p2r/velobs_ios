//
//  InternetImage.h
//  velobs
//

#import <UIKit/UIKit.h>

@interface InternetImage : NSObject {
@private NSMutableData *m_ImageRequestData;
@private id m_Delegate;
@private NSURLConnection *imageConnection;
@public NSString* ImageUrl;
@public UIImage* Image;
@public NSUInteger index;
	bool workInProgress;
}


@property (nonatomic, retain) NSString* ImageUrl;
@property (nonatomic, retain) UIImage* Image;
@property (nonatomic, assign) bool workInProgress;
@property (nonatomic) NSUInteger index;


-(void)setDelegate:(id)new_delegate;
-(id)initWithUrl:(NSString*)urlToImage andIndex:(NSUInteger)index;
-(void)downloadImage:(id)delegate;
-(void)abortDownload;

@end


@interface NSObject (InternetImageDelegate)
- (void)internetImageReady:(InternetImage*)internetImage;
@end
