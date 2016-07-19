//
//  XZCollectionViewCell.h
//  SportClub
//
//  Created by ZengChanghuan on 16/7/1.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *online;
@property (weak, nonatomic) IBOutlet UIButton *number;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
