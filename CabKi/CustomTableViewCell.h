//
//  CustomTableViewCell.h
//  CabKi
//
//  Created by Administrator on 28/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
@property (weak, nonatomic) IBOutlet UITextField *expiryField;
@property (weak, nonatomic) IBOutlet UILabel *rightValue;
@property (weak, nonatomic) IBOutlet UILabel *leftValue;
@property (weak, nonatomic) IBOutlet UIButton *expiryBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UIButton *resendbtn;
@property (weak, nonatomic) IBOutlet UIButton *addProfilePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *profilepic;
@property (weak,nonatomic) IBOutlet UIImageView *arrow_img;
-(IBAction)hidekey:(id)sender;
@end
