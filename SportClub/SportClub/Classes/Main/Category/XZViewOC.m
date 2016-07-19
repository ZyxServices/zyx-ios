//
//  XZViewOC.m
//  SportClub
//
//  Created by zhaowei on 14/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZViewOC.h"
IB_DESIGNABLE
@implementation XZViewOC

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor{
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}
@end
