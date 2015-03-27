//
//  MenuViewController.h
//  PayVK
//
//  Created by Mahesh Dhakad on 6/30/14.
//  Copyright (c) 2014 Mahesh Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "ViewController.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, retain) IBOutlet UITableView *tv;
@property (nonatomic, retain) IBOutlet UIImageView *pic;
@property (nonatomic, retain) IBOutlet UILabel *name;


@end
