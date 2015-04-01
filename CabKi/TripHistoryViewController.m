//
//  TripHistoryViewController.m
//  CabKi
//
//  Created by Administrator on 17/03/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripHistoryViewController.h"
#import "WebServiceClass.h"
#import "CustomTableViewCell.h"
#import "TripDetailViewController.h"
@interface TripHistoryViewController ()

@end

@implementation TripHistoryViewController
@synthesize trip_tb;

- (void)viewDidLoad {
    [super viewDidLoad];
     [self tripHistory_webservices];
    objj =[[NSArray alloc] init];
    data=[[NSMutableArray alloc]init];
    
}

-(void)tripHistory_webservices
{
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Loading..";
    HUD.square=YES;
    [HUD show:YES];
    
   
        WebServiceClass *obj=[[WebServiceClass alloc] init];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSString *userid_str;
    NSString *user_type;
    if([def valueForKey:@"user_id"]!=nil){
        userid_str=[def valueForKey:@"user_id"];
        user_type=@"1";
    }else{
         userid_str=[def valueForKey:@"cab_id"];
        user_type=@"2";
    }
    
    
        [dict setValue:userid_str forKey:@"user_id"];
        [dict setValue:user_type forKey:@"user_type"];
        [obj ValidateEmailAndPhone:dict :self :TripHistoryAPI :@"TripHistory":HUD];
        
}
-(void)TripHistoryResponseMessage : (NSDictionary *) dict{
    
    
    
    objj=[dict valueForKey:@"booking_id"];
    data=[objj objectAtIndex:0];
    
    if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
        
        //[self.navigationController popViewControllerAnimated:YES];
        [trip_tb reloadData];
        [HUD hide:YES];
        
    }
    
    
}
//table view methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return[objj count];
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
    
    NSString *pricestr=[[objj objectAtIndex:indexPath.row] valueForKey:@"price"];
     NSString *datestr=[[objj objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.leftValue.text=pricestr;
    cell.rightValue.text=datestr;
    
        return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bookingid_str=[[objj objectAtIndex:indexPath.row] valueForKey:@"booking_id"];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:bookingid_str forKey:@"booking_id"];
    
    TripDetailViewController *obj_TDVC=[[TripDetailViewController alloc]initWithNibName:@"TripDetailViewController" bundle:nil];
    [self.navigationController pushViewController:obj_TDVC animated:YES];
}

-(IBAction)backbtn_action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
