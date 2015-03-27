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

@interface SignupThird : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD *HUD;
    BOOL imagFlag;
    NSData *data;
    NSString *firstName;
    NSString *lastName;
}
-(void)ResponseMessage : (NSDictionary *) dict;
- (IBAction)CancelBtn:(id)sender;
- (IBAction)nextBtn:(id)sender;
- (IBAction)choosePhoto:(id)sender;
-(IBAction)hidekey:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *profilepic;
@property (nonatomic, assign) id currentResponder;

@property (weak, nonatomic) IBOutlet UITextField *fname;
@property (weak, nonatomic) IBOutlet UITextField *lname;
@property (retain, nonatomic) IBOutlet NSString *user_id;
@end
