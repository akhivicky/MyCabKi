//
//  LoginViewController.m
//  CabKi
//
//  Created by Administrator on 30/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "LoginViewController.h"
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#include <dlfcn.h>

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize tableView1;
@synthesize currentResponder;
- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.tableView1.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Processing..";
    HUD.square=YES;

  //setting customer as a default user
    user_flag=false;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 39;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString *identifier=@"cell";
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.row==1 || indexPath.row==2) {
        
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        
        cell=[arr objectAtIndex:0];
        
        if (indexPath.row==1){
            
        cell.cellTextField.placeholder=@"Enter Email here";
        [cell.cellTextField setKeyboardType:UIKeyboardTypeEmailAddress];
        cell.cellTextField.tag=1;
            [cell.cellTextField becomeFirstResponder];
            
        }
        else{
            
            cell.cellTextField.placeholder=@"Enter Password here";
            cell.cellTextField.secureTextEntry=YES;
            [cell.cellTextField setKeyboardType:UIKeyboardTypeDefault];
            cell.cellTextField.tag=2;
            cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        }
        
        cell.cellTextField.textAlignment=NSTextAlignmentLeft;
        
       
        
    }else if(indexPath.row==0 || indexPath.row==4){
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS1" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        
      
        if (indexPath.row==0) {
            
            cell.lbl.text=@"";
            
        }
        
        
        if(indexPath.row==4){
            lblUser=cell.lbl;
            cell.lbl.text=@"Are you a Driver?";
        }
        
         cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        
    }else if(indexPath.row==3){
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS2" owner:self options:nil];
        
        cell=[arr objectAtIndex:0];
        
        [cell.resendbtn setTitle:@"Forgot Password?" forState:UIControlStateNormal];
        [cell.resendbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.resendbtn addTarget:self action:@selector(forgotPassword) forControlEvents:UIControlEventTouchUpInside];
          cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.resendbtn.titleLabel.font=[UIFont systemFontOfSize:12];

    }else if(indexPath.row==5){
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS2" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        
        [cell.resendbtn addTarget:self action:@selector(swithUserMode:) forControlEvents:UIControlEventTouchUpInside];
        [cell.resendbtn setTitle:@"Switch to Driver View" forState:UIControlStateNormal];
        
    }
    
    return cell;
}
-(void)swithUserMode : (UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"Switch to Driver View"]) {
        user_flag=true;
        lblUser.text=@"Are you a Passenger?";
        [btn setTitle:@"Switch to Passenger View" forState:UIControlStateNormal];
    }else{
        user_flag=false;
         lblUser.text=@"Are you a Driver?";
         [btn setTitle:@"Switch to Driver View" forState:UIControlStateNormal];
    }
    
}
-(void)forgotPassword{
    ForgetPasswordViewController *obj=[[ForgetPasswordViewController alloc] initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:obj animated:YES];
}
- (IBAction)cancelBtn:(id)sender {
    
[self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.currentResponder=textField;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.currentResponder=textField;
    
    if (textField.tag==1)
    {
        email=textField.text;
    }
    else if(textField.tag==2)
    {
        password=textField.text;
    }
    
    return YES;
}
- (IBAction)Loginbtn:(id)sender {
    
    [self.currentResponder resignFirstResponder];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    

    [dict setValue:email forKey:@"email"];
    [dict setValue:password forKey:@"password"];
    [dict setValue:[def valueForKey:@"devicetoken"] forKey:@"gcm_id"];
    [dict setValue:@"iphone" forKey:@"user_type"];
    
    [HUD show:YES];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    if (!user_flag) {
        [obj ValidateEmailAndPhone:dict :self :LOGIN_API :@"customer_login":HUD];
    }else{
        [obj ValidateEmailAndPhone:dict :self :CAB_LOGIN :@"customer_login":HUD];
    }
}
-(void)ResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    
    NSLog(@"response=%@",dict);
    
    NSArray *dictArray= [dict objectForKey:@"response"];
    NSDictionary *obj=[dictArray objectAtIndex:0];
    
    if ([[obj valueForKey:@"status"] isEqualToString:@"true"]) {
        
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
          InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
         if (!user_flag) {
             
          [def setObject:[obj valueForKey:@"profile_pic"] forKey:@"picurl"];
          [def setObject:[obj valueForKey:@"user_id"] forKey:@"user_id"];
          [def setObject:[obj valueForKey:@"fullname"] forKey:@"fullname"];
          [def setObject:nil forKey:@"cab_id"];
             
             HomeViewController *loginController=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
             obj_HVC.topViewController =  loginController;
             
             
             
         }else{
             
             [def setObject:[obj valueForKey:@"cab_id"] forKey:@"cab_id"];
             [def setObject:nil forKey:@"user_id"];
             
              AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             [appDelegate settingLocationManager];
             
             CabHomeViewController *loginController=[[CabHomeViewController alloc]initWithNibName:@"CabHomeViewController" bundle:nil];
             obj_HVC.topViewController =  loginController;
             
             
             
         }
        
        
       
        [self.navigationController
         pushViewController:obj_HVC animated:YES];
        
        
        
    }else{
        
        _AlertView_WithOut_Delegate(@"ERROR", [obj valueForKey:@"msg"], @"Ok", nil);
        
    }
    
}


@end
