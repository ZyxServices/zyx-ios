//
//  XZHomefooterView.h
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZHomeFooterView : UIView
+ (instancetype)footerWithDataArray:(NSArray *)dataArray;
@property (nonatomic, retain) NSArray *data;
@end
