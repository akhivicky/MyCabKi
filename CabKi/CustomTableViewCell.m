//
//  CustomTableViewCell.m
//  CabKi
//
//  Created by Administrator on 28/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize cellTextField,lbl,resendbtn,addProfilePhoto,profilepic,expiryBtn;
@synthesize arrow_img;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)hidekey:(id)sender{
    
    [sender resignFirstResponder];
    
}

@end
