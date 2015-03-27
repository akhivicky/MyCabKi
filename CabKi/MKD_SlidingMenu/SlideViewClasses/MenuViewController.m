//
//  MenuViewController.m
//  PayVK
//
//  Created by Mahesh Dhakad on 6/30/14.
//  Copyright (c) 2014 Mahesh Dhakad. All rights reserved.
//

#import "MenuViewController.h"
#import "ItemCellViewCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UnderRightViewController.h"
#import "TripHistoryViewController.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, assign) CGFloat peekLeftAmount;
@property (nonatomic, assign) CGFloat peekRightAmount;

@end


@implementation MenuViewController
@synthesize menuItems;
@synthesize peekLeftAmount;
@synthesize peekRightAmount;
@synthesize tv,name;

- (void)awakeFromNib
{
    
  self.menuItems = [NSArray arrayWithObjects:@"Request", @"Trip History",@"Wallet",@"Settings", @"Logout", nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    
    
    self.peekRightAmount = 40.0f;
    
    [self.slidingViewController setAnchorRightRevealAmount:230.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    self.menuItems =[NSArray arrayWithObjects:@"Request", @"Trip History",@"Wallet",@"Settings", @"Logout", nil];

    
    CGRect frame;
    frame.origin.x = 15;
    frame.origin.y = 70;
    frame.size.width = 60;
    frame.size.height = 60;
    
    
    UIImageView  *asyncImageView = [[UIImageView alloc] initWithFrame:frame];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSURL *urlimg = [NSURL URLWithString:[def valueForKey:@"picurl"]];
    
    
    asyncImageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    asyncImageView.layer.cornerRadius=asyncImageView.bounds.size.width/2;
    asyncImageView.layer.cornerRadius=asyncImageView.bounds.size.height/2;
    asyncImageView.layer.borderWidth=2.1;
    asyncImageView.layer.masksToBounds = YES;
    asyncImageView.layer.borderColor=[[UIColor lightTextColor] CGColor];
    
   
    UIImage *myImage = nil;
    myImage=[UIImage imageNamed:@"user_profile_pic_imag2.png"];
    [asyncImageView setImageWithURL:urlimg placeholderImage:myImage];
    
    [self.view addSubview:asyncImageView];
    

    
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:@"#ffdc00"];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
  
    name.text=[def valueForKey:@"fullname"];
    
     name.textColor=[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    
    
    
    
    
    
    //chenging title color
    

    NSScanner *scanner1 = [NSScanner scannerWithString:@"#393939"];
    [scanner1 setScanLocation:1]; // bypass '#' character
    [scanner1 scanHexInt:&rgbValue];
    
    self.tv.backgroundColor=[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    
    self.view.backgroundColor=[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];

}


#pragma mark - Table View Delegate Methods
#pragma mark -


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return 0;//@"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
  return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"ItemCellViewCell";
    
    ItemCellViewCell *cell = [tv dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"ItemCellViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }

   // cell.contentView.backgroundColor = [UIColor clearColor];
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:@"#ffdc00"];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    cell.backgroundColor=[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];

    cell.lablename.text = [self.menuItems objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        cell.iconimg.image=[UIImage imageNamed:@"requesticon.png"];
        
    }
    if (indexPath.row==1) {
        cell.iconimg.image=[UIImage imageNamed:@"triphistoryicon.png"];
       
        
    }
    else if (indexPath.row==2) {
        
        cell.iconimg.image=[UIImage imageNamed:@"walleticon.png"];
    }
    else if (indexPath.row==3) {
        
        cell.iconimg.image=[UIImage imageNamed:@"settingicon.png"];
    }
    else if (indexPath.row==4) {
        
        cell.iconimg.image=[UIImage imageNamed:@"settingicon.png"];
        
    }
  
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
   
        //[self.navigationController popViewControllerAnimated:YES];
        
    }
    
     else if (indexPath.row==3) {
         
        
    }
   else if (indexPath.row==1) {
       TripHistoryViewController *obj_THVC=[[TripHistoryViewController alloc]initWithNibName:@"TripHistoryViewController" bundle:nil];
       [self.navigationController pushViewController:obj_THVC animated:YES];

    }
   else if (indexPath.row==2) {

    }
   else if (indexPath.row==4) {
       
       NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
       
       [def setObject:nil forKey:@"cab_id"];
       [def setObject:nil forKey:@"user_id"];
       
         AppDelegate  *theAppDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
       
       ViewController * controller=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    UINavigationController   *nav=[[UINavigationController alloc]initWithRootViewController:controller];
       
   
    
    [nav setNavigationBarHidden:YES];
       
    theAppDelegate.window.rootViewController=nav;
    [theAppDelegate.window makeKeyAndVisible];

    
       [self.navigationController popToRootViewControllerAnimated:YES];
   }
    
}


- (IBAction)revealRecharge:(id)sender
{
    
}




@end
