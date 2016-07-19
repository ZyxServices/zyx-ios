//
//  Helper_UserDefault.m
//  cdleishisdk
//
//  Created by mrdai on 13-10-15.
//  Copyright (c) 2013年 cdleichi. All rights reserved.
//

#import "Helper_UserDefault.h"

@implementation Helper_UserDefault

static NSUserDefaults* userDefault;

+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        userDefault = [NSUserDefaults standardUserDefaults];
    });
}

+(void)setObject:(id)_object forKey:(NSString *)_key
{
    [userDefault setObject:_object forKey:_key];
    [userDefault synchronize];
}

+(id)objectForKey:(NSString *)_key
{
    return [userDefault objectForKey:_key];
}

+(void)removeObjectForKey:(NSString *)_key
{
    [userDefault removeObjectForKey:_key];
    [userDefault synchronize];
}


@end
