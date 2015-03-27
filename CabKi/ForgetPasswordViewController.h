//
//  ForgetPasswordViewController.h
//  CabKi
//
//  Created by Administrator on 02/01/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "MBProgressHUD.h"
#import "WebServiceClass.h"
@interface ForgetPasswordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    MBProgressHUD *HUD;
    NSString *email;
}

- (IBAction)sendBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
-(void)ResponseMessage : (NSDictionary *) dict;
@property (nonatomic, assign) id currentResponder;
@end
