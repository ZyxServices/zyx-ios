//
//  NSString+DateFormat.m
//  HTUser
//
//  Created by JD on 15/9/4.
//  Copyright (c) 2015年 hjd. All rights reserved.
//

#import "NSString+DateFormat.h"

@implementation NSString (DateFormat)

/// 用时间拽string调用 并传入时间格式 返回对应时间格式string e.g: yyyy-MM-dd HH:mm:ss
- (NSString *)stringByFormatString:(NSString *)formatStr
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:formatStr];
    NSTimeInterval time = [self doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [fmt stringFromDate:date];
}

@end
