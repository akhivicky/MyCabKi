//
//  AddressModel.h
//  nvert
//
//  Created by Akhilesh Mourya on 6/30/14.
//  Copyright (c) 2014 YpsilongITSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject


@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *venue_id;
@property (nonatomic,retain) NSString *postal_code;
@property (nonatomic,retain) NSString *distance;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@end
