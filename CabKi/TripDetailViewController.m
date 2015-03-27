//
//  TripDetailViewController.m
//  CabKi
//
//  Created by Administrator on 18/03/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripDetailViewController.h"
#import "WebServiceClass.h"

@interface TripDetailViewController ()

@end

@implementation TripDetailViewController
@synthesize detail_tb,locationManager,mapView;
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    objj =[[NSArray alloc] init];
    data=[[NSMutableArray alloc]init];
    cablocation_array=[[NSMutableArray alloc]init];
    cab_lat_arr=[[NSMutableArray alloc]init];
    cab_long_arr=[[NSMutableArray alloc]init];
    geocoder = [[CLGeocoder alloc] init];
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter=1.0f;
    
#ifdef __IPHONE_8_0
    
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
    unsigned rgbValue = 0;
    NSScanner *scanner1 = [NSScanner scannerWithString:@"#393939"];
    [scanner1 setScanLocation:1]; // bypass '#' character
    [scanner1 scanHexInt:&rgbValue];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    for(int i=0;i<locations.count;i++){
        
        CLLocation * newLocation = [locations objectAtIndex:i];
        
        float spanX = 0.00025;
        float spanY = 0.00025;
        
        lat=newLocation.coordinate.latitude;
        lon=newLocation.coordinate.longitude;
        
        MKCoordinateRegion region;
        region.center.latitude = newLocation.coordinate.latitude;
        region.center.longitude = newLocation.coordinate.longitude;
        
        region.span.latitudeDelta = spanX;
        region.span.longitudeDelta = spanY;
        [self.mapView setRegion:region animated:YES];
        
        
    }
    
    
}

-(IBAction)backbtn_action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self tripHistoryDetail_webservices];
}
-(void)tripHistoryDetail_webservices
{
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Loading..";
    HUD.square=YES;
    [HUD show:YES];

    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    NSString *userid_str;
    NSString *user_type;
    NSString *bookingid_str;
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    if([def valueForKey:@"user_id"]!=nil){
        userid_str=[def valueForKey:@"user_id"];
        bookingid_str=[def valueForKey:@"booking_id"];
        user_type=@"1";
    }else{
        userid_str=[def valueForKey:@"cab_id"];
        bookingid_str=[def valueForKey:@"booking_id"];
        user_type=@"2";
    }

    
    [dict setValue:userid_str forKey:@"user_id"];
    [dict setValue:bookingid_str forKey:@"booking_id"];
    [dict setValue:user_type forKey:@"user_type"];
    [obj ValidateEmailAndPhone:dict :self :TripHistoryDetaiAPI :@"TripHistoryDetail":HUD];
    
}
-(void)TripHistoryDetailResponseMessage : (NSDictionary *) dict{
    
    
    objj=[dict valueForKey:@"trip_history"];

    data=[objj objectAtIndex:0];
    pricestr=[data valueForKey:@"price"];
    datestr=[data valueForKey:@"date"];
    typestr=[data valueForKey:@"type"];
    totalstr=[data valueForKey:@"total"];
    referencestr=[data valueForKey:@"reference"];
    durationstr=[data valueForKey:@"duration"];
    bookingstatus_str=[data valueForKey:@"booking_status"];
    source_str=[data valueForKey:@"source_address"];
    source_lat=[data valueForKey:@"source_lat"];
    source_long=[data valueForKey:@"source_long"];
    destination_str=[data valueForKey:@"destination_address"];
    destination_lat=[data valueForKey:@"destination_lat"];
    destination_long=[data valueForKey:@"destination_long"];
    cablocation_array=[data valueForKey:@"cab_loc"];
//    for (int i=0; i<[cablocation_array count]; i++) {
//        NSMutableArray *cab=[cablocation_array objectAtIndex:i];
//        cab_lat=[cab valueForKey:@"latitute"];
//        cab_long=[cab valueForKey:@"longitude"];
//    }
    cab_lat_arr=[cablocation_array valueForKey:@"latitute"];
    cab_long_arr=[cablocation_array valueForKey:@"longitude"];
    
    if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
        [HUD hide:YES];
            [self loadRoute];
            
            // add the overlay to the map
            if (nil != self.routeLine) {
                [self.mapView addOverlay:self.routeLine];
            }
            
            // zoom in on the route.
            [self zoomInOnRoute];
      
       
        [detail_tb reloadData];
        
    }
    
    
}
//table view methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    

    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }else{
        return 2;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerView.tag = section;
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *headerString = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-10, 40)];
    
    if (section==0) {
         headerString.text = @"Price";
    }else{
        headerString.text=@"Details";
    }
   
    
    headerString.textAlignment= NSTextAlignmentLeft;
    
    headerString.textColor =[UIColor grayColor];
    [headerView addSubview:headerString];
    headerString.font=[UIFont boldSystemFontOfSize:11];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier=@"cell";
    
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewHomeOption" owner:self options:nil];
        
        cell = [arr objectAtIndex:0];
    }
    cell.arrow_img.hidden=YES;
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.leftValue.text=pricestr;
            cell.rightValue.text=datestr;
        }else if (indexPath.row==1){
            cell.leftValue.text=@"Type";
            cell.rightValue.text=typestr;
        }else {
            cell.leftValue.text=@"Total";
            cell.rightValue.text=totalstr;
        }
    }else{
        
        if (indexPath.row==0){
        cell.leftValue.text=@"Reference";
        cell.rightValue.text=referencestr;
        }else if (indexPath.row==1){
        cell.leftValue.text=@"Duration";
        cell.rightValue.text=durationstr;
        }
    }
    return cell;
    
}
// creates the route (MKPolyline) overlay
-(void) loadRoute
{
    //NSString* filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"csv"];
    
    
    //NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    //NSString * fileContents = @"22.725677,75.877454\r22.725731,75.877536\r22.725744,75.877635\r22.725778,75.877728\r22.725798,75.877827\r22.725828,75.877921\r22.725852,75.878021";

    //NSString *fileContents=[NSString stringWithFormat:@"%@,%@\r%@,%@",cab_lat,cab_long,cab_lat,cab_long];
    NSString *wholeSTR=nil;
    for (int p=0; p<[cab_long_arr count]; p++)
    {
        NSString *sinlelat_long=[NSString stringWithFormat:@"%@,%@",[cab_lat_arr objectAtIndex:p],[cab_long_arr objectAtIndex:p]];
        if (p==0)
        {
            wholeSTR=sinlelat_long;
        }
        else
        {
            wholeSTR=[NSString stringWithFormat:@"%@\r%@",wholeSTR,sinlelat_long];
        }
        
    }
    NSLog(@"print rrrrrrr=%@",wholeSTR);
    NSArray* pointStrings = [wholeSTR componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    // while we create the route points, we will also be calculating the bounding box of our route
    // so we can easily zoom in on it.
    MKMapPoint northEastPoint;
    MKMapPoint southWestPoint;
    
    // create a c array of points.
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * pointStrings.count);
    
    for(int idx = 0; idx < pointStrings.count; idx++)
    {
        // break the string down even further to latitude and longitude fields.
        NSString* currentPointString = [pointStrings objectAtIndex:idx];
        NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        CLLocationDegrees latitude  = [[latLonArr objectAtIndex:0] doubleValue];
        CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];
        
        
        // create our coordinate and add it to the correct spot in the array
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        
        //
        // adjust the bounding box
        //
        
        // if it is the first point, just use them, since we have nothing to compare to yet.
        if (idx == 0) {
            northEastPoint = point;
            southWestPoint = point;
        }
        else
        {
            if (point.x > northEastPoint.x)
                northEastPoint.x = point.x;
            if(point.y > northEastPoint.y)
                northEastPoint.y = point.y;
            if (point.x < southWestPoint.x)
                southWestPoint.x = point.x;
            if (point.y < southWestPoint.y)
                southWestPoint.y = point.y;
        }
        
        pointArr[idx] = point;
        
    }
    
    // create the polyline based on the array of points.
    self.routeLine = [MKPolyline polylineWithPoints:pointArr count:pointStrings.count];
    
    _routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
    // clear the memory allocated earlier for the points
    free(pointArr);
    
}

-(void) zoomInOnRoute
{
    [self.mapView setVisibleMapRect:_routeRect];
}
#pragma mark MKMapViewDelegate
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKOverlayView* overlayView = nil;
    
    if(overlay == self.routeLine)
    {
        //if we have not yet created an overlay view for this overlay, create it now.
        if(nil == self.routeLineView)
        {
            self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine] ;
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 3;
        }
        
        overlayView = self.routeLineView;
        
    }
    
    return overlayView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
