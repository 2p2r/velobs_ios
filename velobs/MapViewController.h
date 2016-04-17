//
//  MapViewController.h
//  velobs
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation *pinObs;


@end
