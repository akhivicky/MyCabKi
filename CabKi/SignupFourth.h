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
#import "Stripe.h"
#import "NSString+FontAwesome.h"
#import "InitialSlidingViewController.h"

#define STRIPE_TEST_PUBLIC_KEY @"pk_test_YfTiXfM21LZKVr4SiXULH5rb"

@interface SignupFourth : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
        NSMutableDictionary *tmp;
    MBProgressHUD *HUD;
    NSString *month;
    NSString *year;
    NSMutableArray *yeararray;
    NSString *token;
    NSString *cardnumber;
    NSString *security;
    NSString *postcode;
    
    
}
-(void)ResponseMessage : (NSDictionary *) dict;
- (IBAction)CancelBtn:(id)sender;
- (IBAction)nextBtn:(id)sender;
-(IBAction)hidekey:(id)sender;
@property (nonatomic, strong) NSArray *iconIdentiferArray;
@property (nonatomic,retain) NSArray *montharrr;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
@property (weak, nonatomic) IBOutlet UITextField *expiry;

@property (weak, nonatomic) IBOutlet UITextField *securityCode;
@property (weak, nonatomic) IBOutlet UITextField *postCode;
@property (strong, nonatomic) UIPickerView *expirationDatePicker;
@property (strong, nonatomic) STPCard* stripeCard;
@property (retain, nonatomic) IBOutlet NSString *user_id;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) id currentResponder;
@end
