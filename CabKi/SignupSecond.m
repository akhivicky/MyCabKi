//
//  SignupFirst.m
//  CabKi
//
//  Created by Administrator on 21/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "SignupSecond.h"

@interface SignupSecond ()

@end
//Don't recieve a code?
@implementation SignupSecond
@synthesize code,number,cominingNumber,user_id,currentResponder;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Processing..";
    HUD.square=YES;
    NSString *lableText=[NSString stringWithFormat:@"We have sent a text message with the code to the number +%@", cominingNumber];
    number.text=lableText;
    
    [code becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)CancelBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtn:(id)sender {
    [self.currentResponder resignFirstResponder];
    
 
    if([code1 length]<4)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Enter a 4 digit valid code.", @"Ok", nil);
        return;
    }
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:code1 forKey:@"verification_key"];
    [dict setValue:user_id forKey:@"user_id"];
     
    [HUD show:YES];
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    [obj ValidateEmailAndPhone:dict :self :codevalidation :@"codeverification":HUD];
    
    
    
}

- (IBAction)resendCode:(id)sender {
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
   [dict setValue:user_id forKey:@"user_id"];
    
    
    [HUD show:YES];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    [obj ValidateEmailAndPhone:dict :self :resendcode :@"codeverification":HUD];
    
    
    
    
}
-(void)ResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    
    NSLog(@"response=%@",dict);
    
    NSString *status=[dict objectForKey:@"status"];
    
    
    
    if ([status isEqualToString:@"true"]) {
        
        
        if ([[dict objectForKey:@"resend_status"] isEqualToString:@"Resend"]) {
           
            _AlertView_WithOut_Delegate(@"INFO", @"We have sent you a new authorisation code.", @"Ok", nil);
            
            return;
        }
        
        
        SignupThird *obj_s=[[SignupThird alloc] initWithNibName:@"SignupThird" bundle:nil];
        
        
        obj_s.user_id=user_id;
        
        
        [self.navigationController pushViewController:obj_s animated:YES];
        
        
        
        
    }else{
        
        _AlertView_WithOut_Delegate(@"ERROR", [dict valueForKey:@"message"], @"Ok", nil);
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier=@"cell";
    
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.row==1) {
        
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        
        
        cell=[arr objectAtIndex:0];
        
        cell.cellTextField.placeholder=@"Enter code here";
        
        cell.cellTextField.textAlignment=NSTextAlignmentCenter;
        
        
        [cell.cellTextField becomeFirstResponder];
        
        cell.cellTextField.tag=1;
          cell.cellTextField.secureTextEntry=YES;

        [cell.cellTextField setKeyboardType:UIKeyboardTypeNumberPad];
        
    }else if(indexPath.row==0 || indexPath.row==2 || indexPath.row==3){
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS1" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        
        if(indexPath.row==2){
        cell.lbl.text=[NSString stringWithFormat:@"We have sent a text message with the code to the number +%@", cominingNumber];
        }
        if(indexPath.row==3){
            cell.lbl.text=@"Don't recieve a code?";
        }
        
    }else if(indexPath.row==4){
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS2" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        
        [cell.resendbtn addTarget:self action:@selector(resendCode:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (indexPath.row==0) {
        cell.lbl.text=@"";
         cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
    }
    
    

    
    
    
    return cell;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.currentResponder=textField;
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField.tag==1) {
        
        code1=textField.text;
    }
    
    return YES;
}




@end
