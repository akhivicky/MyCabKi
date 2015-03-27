//
//  SignupFirst.h
//  CabKi
//
//  Created by Administrator on 21/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceClass.h"
#import "JRTextHelper.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "SignupThird.h"
#import "CustomTableViewCell.h"
@interface SignupSecond : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    MBProgressHUD *HUD;
    NSString *code1;
}
-(void)ResponseMessage : (NSDictionary *) dict;
@property (nonatomic, assign) id currentResponder;
- (IBAction)CancelBtn:(id)sender;
- (IBAction)nextBtn:(id)sender;

- (IBAction)resendCode:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (retain, nonatomic) IBOutlet NSString *cominingNumber;
@property (retain, nonatomic) IBOutlet NSString *user_id;


@end
