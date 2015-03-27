//
//  ForgetPasswordViewController.m
//  CabKi
//
//  Created by Administrator on 02/01/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController
@synthesize tableView1;
@synthesize currentResponder;

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Processing..";
    HUD.square=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier=@"cell";
    
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.row==1) {
        
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        
            cell=[arr objectAtIndex:0];
            cell.cellTextField.placeholder=@"Enter Email here";
            [cell.cellTextField setKeyboardType:UIKeyboardTypeEmailAddress];
            cell.cellTextField.tag=1;
         self.currentResponder=cell.cellTextField;
        
       
        cell.cellTextField.textAlignment=NSTextAlignmentLeft;
        
        [cell.cellTextField becomeFirstResponder];
        
    }else if(indexPath.row==0){
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS1" owner:self options:nil];
        cell=[arr objectAtIndex:0];
           cell.lbl.text=@"";
        
    }
    return cell;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
     self.currentResponder=textField;
    
    if (textField.tag==1)
    {
        email=textField.text;
    }
   
    
    return YES;
}
- (IBAction)sendBtn:(id)sender {
    
    [self.currentResponder resignFirstResponder];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:email forKey:@"email"];
    
    [HUD show:YES];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    
    [obj ValidateEmailAndPhone:dict :self :FORGOTPASS :@"forgetpassword":HUD];

}
-(void)ResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    NSLog(@"response=%@",dict);
    
   NSDictionary *obj= [dict objectForKey:@"response"];
    
    if ([[obj valueForKey:@"status"] isEqualToString:@"true"]) {
         _AlertView_WithOut_Delegate(@"Forgot Password", @"Password has been reset check your mail!", @"Ok", nil);
        [self.navigationController popViewControllerAnimated:YES];

        
    }else{
        
        _AlertView_WithOut_Delegate(@"ERROR", [obj valueForKey:@"msg"], @"Ok", nil);
        
    }
    
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
