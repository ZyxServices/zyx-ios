//
//  XZFeatureCircleTableViewCell.h
//  SportClub
//
//  Created by zhaowei on 20/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZFeatureCircleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *circleName;
@property (weak, nonatomic) IBOutlet UILabel *circleNums;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@end
