//
//  XZRedTimelineTableViewCell.h
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const XZRedTimelineCellIdentifier;

@interface XZRedTimelineTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView withDataArray:(NSArray *)dataArray andIndexPath:(NSIndexPath *)indexPath;
/**
 *  返回Cell的总高度
 */
+ (CGFloat)cellHeight;
@property (nonatomic, retain) NSArray *data;
@end
