//
//  SignupFirst1.m
//  CabKi
//
//  Created by Administrator on 28/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "SignupFirst1.h"
#import "NSString+FontAwesome.h"
@interface SignupFirst1 ()

@end

@implementation SignupFirst1
@synthesize iconIdentiferArray,iconSearchArray, currentResponder;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tmp = [[NSMutableDictionary alloc] init];
    
    tmp[@"fa-envelope"]				= @(FAEnvelope);
    
    tmp[@"fa-lock"]				= @(FALock);
    tmp[@"fa-mobile"]				= @(FAMobile);
    
    if (nil == iconIdentiferArray) {
        iconIdentiferArray = [[tmp allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Processing..";
    HUD.square=YES;
    
     self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    
     if (indexPath.row==1 || indexPath.row==2 || indexPath.row==3) {
         
         
         NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
         
         
         cell=[arr objectAtIndex:0];
       
     }else if(indexPath.row==0 || indexPath.row==4){
         NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS1" owner:self options:nil];
         cell=[arr objectAtIndex:0];

     }
    
    if (indexPath.row==0) {
        cell.lbl.text=@"";
         cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
    }
    
   
    
   cell.cellTextField.leftViewMode = UITextFieldViewModeAlways;
    
   
    if (indexPath.row==1) {
     
        
        cell.cellTextField.placeholder=@"Email";
        
        
        
        
        [cell.cellTextField becomeFirstResponder];
        
        cell.cellTextField.tag=1;
        
    }else if(indexPath.row==2){
        
        
        
        [cell.cellTextField setKeyboardType:UIKeyboardTypeNumberPad];
        
       cell.cellTextField.placeholder=@"Mobile";
        cell.cellTextField.tag=2;
        
        
    }else if(indexPath.row==3){
        
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
       
        
        cell.cellTextField.placeholder=@"Password";
        cell.cellTextField.secureTextEntry=YES;
        
        cell.cellTextField.tag=3;
       
    }if (indexPath.row==4) {
        
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        
    }
    

  
    
    return cell;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
   self.currentResponder=textField;
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
  
    if (textField.tag==1) {
        
        email=textField.text;
    }else if(textField.tag==2)
    {
        mobile1=textField.text;
    }else{
        password=textField.text;
    }
    
    return YES;
}
- (IBAction)CancelBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextBtn:(id)sender{
    
    [self.currentResponder resignFirstResponder];
    
    
    
    
    mobile=mobile1;
    
    if(![JRTextHelper textIsValidEmailFormat:email]){
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Please enter a valid email.", @"Ok", nil);
        return;
        
    }
    
    if(![JRTextHelper isNumeric:mobile])
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Please enter a valid mobile number.", @"Ok", nil);
        return;
    }
    if([password length]<5)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"'Password must not be less than 5 characters.", @"Ok", nil);
        return;
    }
    
    
    NSString *firstLetter = [mobile substringWithRange:NSMakeRange(0, 1)];
    if ([firstLetter isEqualToString:@"0"]) {
        mobile = [mobile stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        

    }
        mobile=[NSString stringWithFormat:@"91%@", mobile];
    
    
    
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:email forKey:@"email"];
    [dict setValue:mobile forKey:@"phone"];
    [dict setValue:password forKey:@"password"];
    
    [HUD show:YES];
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    [obj ValidateEmailAndPhone:dict :self :emailandphonevalidation :@"emailvalidation":HUD];
    
    
    
}
-(void)ResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    NSLog(@"response=%@",dict);
    
    NSString *status=[dict objectForKey:@"status"];
    
    if ([status isEqualToString:@"true"]) {
        
        SignupSecond *obj_s=[[SignupSecond alloc] initWithNibName:@"SignupSecond" bundle:nil];
        
        obj_s.cominingNumber=mobile;
        obj_s.user_id=[dict objectForKey:@"user_id"];
        
        
        [self.navigationController pushViewController:obj_s animated:YES];
        
        
    }else{
        
        _AlertView_WithOut_Delegate(@"ERROR", [dict valueForKey:@"message"], @"Ok", nil);
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
