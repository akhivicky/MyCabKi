//
//  ItemCellViewCell.m
//  nvert
//
//  Created by Akhilesh Mourya on 7/17/14.
//  Copyright (c) 2014 YpsilongITSolutions. All rights reserved.
//

#import "ItemCellViewCell.h"

@implementation ItemCellViewCell
@synthesize lablename,iconimg;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
