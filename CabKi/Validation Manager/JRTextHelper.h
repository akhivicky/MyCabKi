//
//  JRTextHelper.h
//  TriniPossed
//
//  Created by Manjit Bhuriya on 20/12/13.
//  Copyright (c) 2013 Manjit Bhuriya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRTextHelper : NSObject

+ (BOOL)textIsValidEmailFormat:(NSString *)text;

+ (BOOL)textIsValidPasswordFormat:(NSString *)text;

+(BOOL)isNumeric:(NSString*)inputString;

@end
