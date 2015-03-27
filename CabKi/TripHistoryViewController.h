//
//  TripHistoryViewController.h
//  CabKi
//
//  Created by Administrator on 17/03/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface TripHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *trip_tb;
    MBProgressHUD *HUD;
    NSArray *objj;
    NSMutableArray *data;
   
}
@property(nonatomic,retain)IBOutlet UITableView *trip_tb;
@property(nonatomic,retain)IBOutlet UIButton *back_btn;

-(IBAction)backbtn_action:(id)sender;
-(void)TripHistoryResponseMessage : (NSDictionary *) dict;
@end
