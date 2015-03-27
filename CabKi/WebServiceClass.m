//
//  WebServiceClass.m
//  CabKi
//
//  Created by Administrator on 24/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "WebServiceClass.h"

@implementation WebServiceClass

-(void)ValidateEmailAndPhone : (NSDictionary *) dict : (id) obj : (NSString *) url : (NSString *) controllerflag  : (MBProgressHUD *) HUD{
    
    
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html",nil]];
    
    NSURL *baseURL=[NSURL URLWithString:url];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:dict constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        
        if ([controllerflag isEqualToString:@"namevalidation"]) {
           
            NSData *data=[dict valueForKey:@"userimage"];
            
            
            [formData appendPartWithFileData:data name:@"profile_pic" fileName:@"image.png" mimeType:@"image/png"];
            
            
        }
        
       
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error = nil;
        
        NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        if (error) {
            
            NSLog(@"Error serializing %@", error);
            
        }
        
        if ([controllerflag isEqualToString:@"emailvalidation"]) {
            
           SignupFirst1 *ss=(SignupFirst1 *)obj;
            [ss ResponseMessage:dictResponse];
            
            
        }else if ([controllerflag isEqualToString:@"codeverification"]) {
            
            SignupSecond *ss=(SignupSecond *)obj;
            [ss ResponseMessage:dictResponse];
        }else if ([controllerflag isEqualToString:@"namevalidation"]) {
            
            SignupThird *ss=(SignupThird *)obj;
            [ss ResponseMessage:dictResponse];

        }
        else if ([controllerflag isEqualToString:@"cardvalidation"]) {
            
            SignupFourth *ss=(SignupFourth *)obj;
            [ss ResponseMessage:dictResponse];
            
        }
        else if ([controllerflag isEqualToString:@"customer_login"]) {
            
            LoginViewController *ss=(LoginViewController *)obj;
            [ss ResponseMessage:dictResponse];
            
        }
        else if ([controllerflag isEqualToString:@"forgetpassword"]) {
            
            ForgetPasswordViewController *ss=(ForgetPasswordViewController *)obj;
            [ss ResponseMessage:dictResponse];
            
        } else if ([controllerflag isEqualToString:@"acceptrequest"]) {
            
            CustomerRequestViewController *ss=(CustomerRequestViewController *)obj;
            [ss ResponseMessage:dictResponse];
            
        }
        else if ([controllerflag isEqualToString:@"getmybooking"]) {
            
            CabHomeViewController *ss=(CabHomeViewController *)obj;
            [ss ResponseMessage:dictResponse];
            
        }
        else if ([controllerflag isEqualToString:@"getmybookingcustomer"]) {
            
            HomeViewController *ss=(HomeViewController *)obj;
            [ss ResponseMessage:dictResponse];
            
        }
        else if ([controllerflag isEqualToString:@"addprivatebooking"]) {
            
            CabHomeViewController *ss=(CabHomeViewController *)obj;
            [ss PrivateBookingResponseMessage:dictResponse];
            
        }
        else if ([controllerflag isEqualToString:@"adddestinationfromprivate"]) {
            
            CabprivatebookingPage *ss=(CabprivatebookingPage *)obj;
            [ss ResponseMessage:dictResponse];
            
        }
        else if ([controllerflag isEqualToString:@"completeprivatebooking"]) {
            
            CabprivatebookingPage *ss=(CabprivatebookingPage *)obj;
            [ss PrivatebookingCompleteResponseMessage:dictResponse];
            
        }
        else if ([controllerflag isEqualToString:@"CancelPrivateJob"]) {
            
            CabprivatebookingPage *ss=(CabprivatebookingPage *)obj;
            [ss PrivatebookingCancelResponseMessage:dictResponse];
            
        }else if ([controllerflag isEqualToString:@"PrivateJobClose"]) {
            
            PrivateBookingMeterReadingPage *ss=(PrivateBookingMeterReadingPage *)obj;
            [ss PrivatebookingCloseResponseMessage:dictResponse];
            
        }else if ([controllerflag isEqualToString:@"TripHistory"]) {
            
            TripHistoryViewController *ss=(TripHistoryViewController *)obj;
            [ss TripHistoryResponseMessage:dictResponse];
            
        }else if ([controllerflag isEqualToString:@"TripHistoryDetail"]) {
            
            TripDetailViewController *ss=(TripDetailViewController *)obj;
            [ss TripHistoryDetailResponseMessage:dictResponse];
            
        }

        
        
    }
     
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [HUD hide:YES];
        _AlertView_WithOut_Delegate(@"Error", @"Oops you are disconnected from internet! Try again.", @"Ok", nil);
        }
     
     ];
    
    
    [operation start];
    
    
}

@end
