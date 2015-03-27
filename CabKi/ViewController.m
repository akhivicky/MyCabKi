//
//  ViewController.m
//  CabKi
//
//  Created by Administrator on 21/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()

@end

@implementation ViewController
@synthesize nav;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"hello akhilesh fsdfsdf");
    
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)CreateAccount:(id)sender {
    
    SignupFirst1 *obj=[[SignupFirst1 alloc] initWithNibName:@"SignupFirst1" bundle:nil];
    
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)login:(id)sender {
    
    LoginViewController *obj=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
}

@end
