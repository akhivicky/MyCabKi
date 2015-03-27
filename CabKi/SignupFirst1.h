//
//  SignupFirst1.h
//  CabKi
//
//  Created by Administrator on 28/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "WebServiceClass.h"
#import "JRTextHelper.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "SignupSecond.h"

@interface SignupFirst1 : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableDictionary *tmp;
    NSString *email, *password,*mobile, *mobile1;
    MBProgressHUD *HUD;
}
-(void)ResponseMessage : (NSDictionary *) dict;
@property (nonatomic, assign) id currentResponder;
@property (nonatomic, strong) NSArray *iconIdentiferArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *iconSearchArray;

- (IBAction)CancelBtn:(id)sender;
- (IBAction)nextBtn:(id)sender;
@end
