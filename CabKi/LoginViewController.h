//
//  LoginViewController.h
//  CabKi
//
//  Created by Administrator on 30/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CustomTableViewCell.h"
#import "WebServiceClass.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "CabHomeViewController.h"

@interface LoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    MBProgressHUD *HUD;
    NSString *email, *password;
    UILabel *lblUser;
    BOOL user_flag;
}
- (IBAction)cancelBtn:(id)sender;
- (IBAction)Loginbtn:(id)sender;
-(void)ResponseMessage : (NSDictionary *) dict;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (nonatomic, assign) id currentResponder;
@end
