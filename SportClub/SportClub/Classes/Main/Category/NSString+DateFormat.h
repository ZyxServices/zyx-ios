//
//  NSString+DateFormat.h
//  HTUser
//
//  Created by JD on 15/9/4.
//  Copyright (c) 2015年 hjd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateFormat)

/**
 *  用时间拽string调用 并传入时间格式 返回对应时间格式string e.g: yyyy-MM-dd HH:mm:ss
 *
 *  @param formatStr 时间格式
 *
 *  @return 对应时间格式string
 */
- (NSString *)stringByFormatString:(NSString *)formatStr;

@end
