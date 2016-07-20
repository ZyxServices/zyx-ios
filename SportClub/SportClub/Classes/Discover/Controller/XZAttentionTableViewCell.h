//
//  XZAttentionTableViewCell.h
//  SportClub
//
//  Created by zhaowei on 20/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZAttentionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UILabel *numbers;

@property (nonatomic ,assign) CGFloat height;
-(void)setModel:(NSDictionary *)dic;
@end
