//
//  SignupFirst.m
//  CabKi
//
//  Created by Administrator on 21/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "SignupFourth.h"

@interface SignupFourth ()

@end

@implementation SignupFourth
@synthesize cardNumber,expiry,postCode,securityCode,expirationDatePicker,montharrr,user_id,currentResponder,iconIdentiferArray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    tmp = [[NSMutableDictionary alloc] init];
   
    tmp[@"fa-calendar"]			= @(FACalendar);
    tmp[@"fa-credit-card"]		= @(FACreditCard);
    tmp[@"fa-home"]				= @(FAHome);
    tmp[@"fa-lock"]				= @(FALock);
    
    
    if (nil == iconIdentiferArray) {
        iconIdentiferArray = [[tmp allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }

    
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Processing..";
    HUD.square=YES;
    
    [self.cardNumber becomeFirstResponder];
    
    yeararray=[[NSMutableArray alloc]init];
    montharrr  = @[@"01 - January", @"02 - February", @"03 - March",
                   @"04 - April", @"05 - May", @"06 - June", @"07 - July", @"08 - August", @"09 - September",
                   @"10 - October", @"11 - November", @"12 - December"];
    int yr=2014;
    
    for (int i=0; i<12; i++) {
        
        NSString *yer=[[NSString alloc] initWithFormat:@"%d",yr];
        [yeararray addObject:yer];
        yr++;
        
    }


    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
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
    
    if (indexPath.row==1 || indexPath.row==3 || indexPath.row==4) {
        
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        
        
        cell=[arr objectAtIndex:0];
        
    }else if(indexPath.row==0 || indexPath.row==5){
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS1" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        
    }
    else if(indexPath.row==2){
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS4" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        
        [cell.expiryBtn addTarget:self action:@selector(openPickerview) forControlEvents:UIControlEventTouchUpInside];
        cell.expiryField.placeholder=@"Expiry";
        self.expiry=cell.expiryField;
        
        
    }
    
    if (indexPath.row==0) {
        cell.lbl.text=@"";
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        

    }
    
    UILabel *button = [[UILabel alloc] init];
    button.frame = CGRectMake(-5, 0, 24, 18);
    
    
    cell.cellTextField.leftViewMode = UITextFieldViewModeAlways;
    
    button.textColor=[UIColor grayColor];
    
   
    
    if (indexPath.row==1) {
        
        button.text = [NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[iconIdentiferArray objectAtIndex:1]]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:1]]]];
        
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:15] range:NSMakeRange(0, 1)];
        
        
        [button setAttributedText:attributedString];
        
        
        button.textAlignment=NSTextAlignmentCenter;
        
        cell.cellTextField.leftView = button;
        
      
        cell.cellTextField.placeholder=@"Card Number";
        
        
        
        
        [cell.cellTextField becomeFirstResponder];
        
        cell.cellTextField.tag=1;
        [cell.cellTextField setKeyboardType:UIKeyboardTypeNumberPad];
        self.cardNumber=cell.cellTextField;
        
        
    }else if(indexPath.row==2){
        
        button.text = [NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[iconIdentiferArray objectAtIndex:0]]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:0]]]];
        
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:15] range:NSMakeRange(0, 1)];
        
        [button setAttributedText:attributedString];
        button.textAlignment=NSTextAlignmentCenter;
        
        cell.cellTextField.leftView = button;
        
        cell.expiryField.leftViewMode = UITextFieldViewModeAlways;
        
        
        cell.expiryField.leftView = button;

    }else if(indexPath.row==3){
        
        button.frame = CGRectMake(-5, 0, 24, 18);
        
        button.text = [NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[iconIdentiferArray objectAtIndex:3]]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:3]]]];
        
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:18] range:NSMakeRange(0, 1)];
        
        
        
        [button setAttributedText:attributedString];
        button.textAlignment=NSTextAlignmentCenter;
        
        cell.cellTextField.leftView = button;
        

        [cell.cellTextField setKeyboardType:UIKeyboardTypeNumberPad];
        
        cell.cellTextField.placeholder=@"Security Code";
        cell.cellTextField.tag=2;
        
        self.securityCode=cell.cellTextField;
        
    }
    else if(indexPath.row==4){
        button.frame = CGRectMake(-5, 0, 24, 18);
        
        
        
        
        
        button.text = [NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[iconIdentiferArray objectAtIndex:2]]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:2]]]];
        
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:18] range:NSMakeRange(0, 1)];
        
        [button setAttributedText:attributedString];
        
        button.textAlignment=NSTextAlignmentCenter;
        
        cell.cellTextField.leftView = button;
        
        
        
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        
        
        cell.cellTextField.placeholder=@"Post Code";
        
        cell.cellTextField.tag=3;
        self.postCode=cell.cellTextField;
        
    }if (indexPath.row==5) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        cell.lbl.text=@"Card details are encrypted. They are not charged until you complete a journey.";
        
    }
    
    return cell;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField==self.cardNumber) {
      
    __block NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 20) {
        return NO;
    }
    
    [textField setText:newString];
    }
    else if (textField==self.securityCode) {
        if (textField.text.length > 2) {
            [textField setText:string];
            
            return NO;
            
        }else{
            
            return YES;
        }
    }else if (textField==self.postCode){
        return YES;
    }
    return NO;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.currentResponder=textField;
    if (textField==self.postCode) {
       // [self animateTextField:self.postCode up:YES];
    }
    if (textField==self.expiry) {
        [self configurePickerView];
    }
    
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField.tag==1) {
        
        cardnumber=textField.text;
    }else if(textField.tag==2)
    {
        security=textField.text;
        
    }else if(textField.tag==3){
        
        postcode=textField.text;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (BOOL)validateCustomerInfo {
    
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Please try again"
                                                    message:@"Please enter all required information"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    
    NSError* error = nil;
    [self.stripeCard validateCardReturningError:&error];
    
    
    if (error) {
        
        alert.message = [error localizedDescription];
        [alert show];
        return NO;
    }
    
    return YES;
}
- (void)performStripeOperation {
    
    
    //2
    [Stripe createTokenWithCard:self.stripeCard publishableKey:STRIPE_TEST_PUBLIC_KEY completion:^(STPToken *token, NSError *error) {
        
    }];
    
    [Stripe createTokenWithCard:self.stripeCard
                 publishableKey:STRIPE_TEST_PUBLIC_KEY
                     completion:^(STPToken* tokenn, NSError* error) {
                         if(error)
                         {
                             [HUD hide:YES];
                             [self handleStripeError:error];
                         }
                         
                         else{
                             token=tokenn.tokenId;
                             NSRange r = NSMakeRange(0, 2);
                             NSString *cup = [cardnumber substringWithRange: r];
                             
                             
                          
                             
                             
                             
                             
                             
                             
                             NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                             if ([cup isEqualToString:@"51"] || [cup isEqualToString:@"52"] || [cup isEqualToString:@"53"] || [cup isEqualToString:@"54"] || [cup isEqualToString:@"55"]) {
                                 
                                 [dict setValue:@"Mastercard" forKey:@"cardtype"];
                                 
                             }else{
                                 
                                 [dict setValue:@"Visacard" forKey:@"cardtype"];
                                 
                             }
                             
                             [dict setValue:user_id forKey:@"user_id"];
                             [dict setValue:token forKey:@"token"];
                             
                             [dict setValue:postcode forKey:@"postcode"];
                             
                             
                             [HUD show:YES];
                             
                             WebServiceClass *obj=[[WebServiceClass alloc] init];
                             
                             [obj ValidateEmailAndPhone:dict :self :ADDCREDITCARD :@"cardvalidation":HUD];
                         }
                     }];
}

- (void)handleStripeError:(NSError *)error {
    
    
    if ([error.domain isEqualToString:@"StripeDomain"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    //2
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please try again"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}




- (IBAction)CancelBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtn:(id)sender {
    
    [self.currentResponder resignFirstResponder];
    
  
    if([cardnumber length]<16)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"This payment card is invalid.", @"Ok", nil);
        return;
    }
    if([expiry.text length]==0)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Please enter a valid expiry date.", @"Ok", nil);
        return;
    }
    if([security length]==0 || [security length]<3)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Please enter a valid security code.", @"Ok", nil);
        return;
    }
    if([postcode length]==0)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Please enter a valid postcode.", @"Ok", nil);
        return;
        
        
    }
    
    
    //validating stripe
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Loading..";
    HUD.square=YES;
    [HUD show:YES];
    
    self.stripeCard = [[STPCard alloc] init];
    cardnumber=[cardnumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.stripeCard.number = cardnumber;
    self.stripeCard.cvc = security;
    
    int expmon=[month intValue];
    int expyr=[year intValue];
    
    self.stripeCard.expMonth = expmon;
    self.stripeCard.expYear =expyr;   //2
    if ([self validateCustomerInfo]) {
        [self performStripeOperation];
    }else{
        [HUD hide:YES];
    }
    
    
    
    
    
    
}
-(void)ResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    NSLog(@"response=%@",dict);
    
    NSMutableArray *obj=[dict valueForKey:@"result"];
    
    if ([[obj valueForKey:@"status"] isEqualToString:@"true"]) {
        
        HomeViewController *loginController=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        
        
        InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
        obj_HVC.topViewController =  loginController;
        
        [self.navigationController pushViewController:obj_HVC animated:YES];
        
    }else{
        
        _AlertView_WithOut_Delegate(@"ERROR", [obj valueForKey:@"msg"], @"Ok", nil);
        
    }
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component==0) {
        return 12;
    }else if (component==1){
        return [yeararray count];
    }else{
        return 0;
    }
    
    
}

#pragma mark - UIPicker delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView== expirationDatePicker) {
        
        
        if (component==0) {
            
         return self.montharrr[row];
            
        }else if (component==1){
            
         return [yeararray objectAtIndex:row];
            
        }
        
    }

    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
        NSInteger selectedmoth=row + 1;
    if (component==0) {
        
        month = [NSString stringWithFormat:@"%ld",(long)selectedmoth];
        
    }else{
        
        year = [NSString stringWithFormat:@"%@",[yeararray objectAtIndex:row]];
        
    }
    
    
}


#pragma mark - UIPicker configuration
-(void)openPickerview{
    [self configurePickerView];
}

- (void)pickerDoneButtonPressed {
    [self.view endEditing:YES];
    
    self.expiry.text=[NSString stringWithFormat:@"%@/%@", month,year];
    
    
    
}
- (void)configurePickerView {
    
    
    self.expirationDatePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,150,320,100)];
    self.expirationDatePicker.delegate = self;
    self.expirationDatePicker.dataSource = self;
    self.expirationDatePicker.showsSelectionIndicator = YES;
    
    //Create and configure toolabr that holds "Done button"
    UIToolbar *pickerToolbar = [[UIToolbar alloc] init];
    pickerToolbar.barStyle = UIBarStyleBlackTranslucent;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:nil
                                          action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(pickerDoneButtonPressed)];
    
    [pickerToolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    
    self.expiry.inputView = self.expirationDatePicker;
    self.expiry.inputAccessoryView = pickerToolbar;
    
    month=@"1";
    year=@"2014";
}



/////textfield up and down  ///////
-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    const int md=55;
    const float duration = 0.25f;
    int movement =  (up ? -md:md);
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    self.view.frame = CGRectOffset(self.view.frame,0, movement);
    [UIView commitAnimations];
}

-(IBAction)hidekey:(id)sender{
    
    [sender resignFirstResponder];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==self.postCode) {
     // [self animateTextField:self.postCode up:NO];
    }
    
}



@end
