//
//  TripDetailViewController.h
//  CabKi
//
//  Created by Administrator on 18/03/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>
@interface TripDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate>
{
    UITableView *detail_tb;
    MBProgressHUD *HUD;
    NSArray *objj;
    NSMutableArray *data;
    NSString *pricestr;
    NSString *datestr;
    NSString *typestr;
    NSString *totalstr;
    NSString *referencestr;
    NSString *durationstr;
    NSString *bookingstatus_str;
    NSString *source_str;
    NSString *destination_str;
    NSString *source_lat;
    NSString *source_long;
    NSString *destination_lat;
    NSString *destination_long;
    MKMapView* _mapView;
    // the data representing the route points.
    MKPolyline* _routeLine;
    
    
    // the view we create for the line on the map
    MKPolylineView* _routeLineView;
    
    // the rect that bounds the loaded points
    MKMapRect _routeRect;
    NSMutableArray *cablocation_array;
    //NSString *cab_lat;
   // NSString *cab_long;
    NSMutableArray *cab_lat_arr;
    NSMutableArray *cab_long_arr;
    CLGeocoder *geocoder;
    double lat,lon;
}
@property(nonatomic,retain)IBOutlet UITableView *detail_tb;
@property(nonatomic,retain)IBOutlet UIButton *back_btn;
@property (nonatomic, retain) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) MKPolyline* routeLine;
@property (nonatomic, retain) MKPolylineView* routeLineView;
@property(nonatomic, retain) CLLocationManager *locationManager;
-(IBAction)backbtn_action:(id)sender;
-(void)TripHistoryDetailResponseMessage : (NSDictionary *) dict;
-(void) loadRoute;

// use the computed _routeRect to zoom in on the route.
-(void) zoomInOnRoute;

@end
