//
//  SignupFirst.m
//  CabKi
//
//  Created by Administrator on 21/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "SignupThird.h"

@interface SignupThird ()

@end

@implementation SignupThird

@synthesize fname,lname,user_id,profilepic,currentResponder;

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Processing..";
    HUD.square=YES;
    imagFlag=false;
    
    [self.fname becomeFirstResponder];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==4) {
        return 70;
    }
    return 45;
    
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
        
    }else if(indexPath.row==0 || indexPath.row==3){
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS1" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        
    }
    else if(indexPath.row==4){
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS3" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        
    }
    
    if (indexPath.row==0 || indexPath.row==3) {
        cell.lbl.text=@"";
         cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
    }
    
//    UILabel *button = [[UILabel alloc] init];
//    button.frame = CGRectMake(-5, 0, 24, 18);
//    
//    button.textAlignment=UITextAlignmentCenter;
//    
//    cell.cellTextField.leftViewMode = UITextFieldViewModeAlways;
//    
//    button.textColor=[UIColor grayColor];
//    
//    cell.cellTextField.leftView = button;
    
    
    if (indexPath.row==1) {
        
//        button.text = [NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[iconIdentiferArray objectAtIndex:0]]];
//        
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:0]]]];
//        
//        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:15] range:NSMakeRange(0, 1)];
//        
//        [button setAttributedText:attributedString];
//        
//        
        
        
        cell.cellTextField.placeholder=@"First Name";
        
        
        
        
        [cell.cellTextField becomeFirstResponder];
        
        cell.cellTextField.tag=1;
       
        
    }else if(indexPath.row==2){
        
        
        
//        button.text = [NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:2]]];
//        
//        
//        
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:2]]]];
//        
//        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:17] range:NSMakeRange(0, 1)];
//        
//        [button setAttributedText:attributedString];
//        
//        
        
       
        
        cell.cellTextField.placeholder=@"Last Name";
        cell.cellTextField.tag=2;
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
       // self.lname=cell.cellTextField;
    }if (indexPath.row==4 || indexPath.row==3) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        
         [cell.addProfilePhoto addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
        profilepic=cell.profilepic;
        
        cell.profilepic.layer.cornerRadius = 10;
        cell.profilepic.clipsToBounds = YES;
        
        
    }
    
    
    
    
    return cell;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.currentResponder=textField;
    if (textField==self.lname) {
        [self animateTextField:self.lname up:YES];
    }
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField.tag==1) {
        
        firstName=textField.text;
    }else if(textField.tag==2)
    {
        lastName=textField.text;
    }
    
    return YES;
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
    
    
    if([firstName length]==0)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Pleas enter your first name.", @"Ok", nil);
        return;
    }
    if([lastName length]==0)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Pleas enter your last name.", @"Ok", nil);
        return;
    }
    if(!imagFlag)
    {
        
        _AlertView_WithOut_Delegate(@"ERROR", @"Please add your profile image.", @"Ok", nil);
        return;
    }
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:firstName forKey:@"firstname"];
    [dict setValue:lastName forKey:@"lastname"];
    [dict setValue:user_id forKey:@"user_id"];
    [dict setValue:data forKey:@"userimage"];
    
    [HUD show:YES];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    [obj ValidateEmailAndPhone:dict :self :nameValidation :@"namevalidation":HUD];
    
    
    
}

- (IBAction)choosePhoto:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: @"Take Photo", @"Choose Existing Photo", nil];
    [actionSheet showInView:self.view];
    
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takeNewPhotoFromCamera];
            break;
        case 1:
            [self choosePhotoFromExistingImages];
        default:
            break;
    }
}
- (void)takeNewPhotoFromCamera
{
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        controller.delegate = self;
        [self.navigationController presentViewController: controller animated: YES completion: nil];
    }
}
-(void)choosePhotoFromExistingImages
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
        controller.delegate = self;
        [self.navigationController presentViewController: controller animated: YES completion: nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
    
    UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
    
    UIImage *img1=[self compressImage:image];
    
   // NSData *dd=UIImagePNGRepresentation(image);
    
    data = UIImagePNGRepresentation(img1);
    UIImage *iidd=[UIImage imageWithData:data];
    
    [profilepic setImage:iidd];
    
//    profilepic.layer.backgroundColor=[[UIColor clearColor] CGColor];
//    profilepic.layer.cornerRadius=profilepic.bounds.size.width/2;
//    profilepic.layer.cornerRadius=profilepic.bounds.size.height/2;
//    profilepic.layer.borderWidth=2.1;
//    profilepic.layer.masksToBounds = YES;
//    profilepic.layer.borderColor=[[UIColor lightTextColor] CGColor];
    imagFlag=true;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];



}
-(UIImage *)compressImage :(UIImage *)image

{
    
//    NSData *imageData1 = UIImageJPEGRepresentation(image, 0.0f);
//    
    //int imageSize1   = imageData1.length;
    
    // NSLog(@"size of image in KB: %f ", imageSize1/1024.0);
    
    
    
    float actualHeight = 1000;
    
    float actualWidth = 1000;
    
    float maxHeight = 220;
    
    float maxWidth = 220;
    
    float imgRatio = actualWidth/actualHeight;
    
    float maxRatio = maxWidth/maxHeight;
    
    float compressionQuality = 1;//50 percent compression
    
    
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        
        if(imgRatio < maxRatio){
            
            //adjust width according to maxHeight
            
            imgRatio = maxHeight / actualHeight;
            
            actualWidth = imgRatio * actualWidth;
            
            actualHeight = maxHeight;
            
        }
        
        else if(imgRatio > maxRatio){
            
            //adjust height according to maxWidth
            
            imgRatio = maxWidth / actualWidth;
            
            actualHeight = imgRatio * actualHeight;
            
            actualWidth = maxWidth;
            
        }
        
        else{
            
            actualHeight = maxHeight;
            
            actualWidth = maxWidth;
            
        }
        
    }
    
    
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [image drawInRect:rect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    
    UIGraphicsEndImageContext();
    
   // int imageSize   = imageData.length;
    
    // NSLog(@"size of image in KB: %f ", imageSize/1024.0);
    
    return [UIImage imageWithData:imageData];
    
}
-(void)ResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    
    NSString *status=[dict objectForKey:@"status"];
    
    if ([status isEqualToString:@"true"]) {
        
        SignupFourth *obj_s=[[SignupFourth alloc] initWithNibName:@"SignupFourth" bundle:nil];
        
       obj_s.user_id=user_id;
        
        
        
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        
        [def setObject:[NSString stringWithFormat:@"%@ %@", firstName,lastName] forKey:@"fullname"];
        [def setObject:[dict objectForKey:@"profile_pic"]forKey:@"picurl"];
        
        
        
        [self.navigationController pushViewController:obj_s animated:YES];
        
        
    }else{
        
        _AlertView_WithOut_Delegate(@"ERROR", [dict valueForKey:@"message"], @"Ok", nil);
        
    }

    
}
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
    if (textField==self.lname) {
        [self animateTextField:self.lname up:NO];
    }
    
}


@end
