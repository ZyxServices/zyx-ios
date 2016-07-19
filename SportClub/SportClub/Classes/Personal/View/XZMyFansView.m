//
//  XZMyFansView.m
//  SportClub
//
//  Created by zhaowei on 13/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZMyFansView.h"

@implementation XZMyFansView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.backgroundColor = [UIColor whiteColor];
        // 添加按钮
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 40, 40)];
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius =20;
        [self addSubview:_imgView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame)+ 12, 15, 100, 21)];
        [self addSubview:_nameLabel];
    }
    return self;
}
@end
