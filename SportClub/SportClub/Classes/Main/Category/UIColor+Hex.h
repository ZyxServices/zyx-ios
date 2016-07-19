//
//  UIColor+Hex.h
//  CarDanBusiness
//
//  Created by JHRZ on 15/4/29.
//  Copyright (c) 2015年 rongzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
