//
//  XZMomentsTableViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZMomentsTableViewCell.h"
#import "NSString+DateFormat.h"
@interface XZMomentsTableViewCell()

@end
@implementation XZMomentsTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView withDataArray:(NSArray *)dataArray andIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"momentsID";
    XZMomentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        
    }
    if (dataArray.count<3) {
        return cell;
    }
    
    NSDictionary *dict = dataArray[indexPath.row - 3];
//    cell.name.text = [dict objectForKey:@""];
    cell.title.text = [dict objectForKey:@"title"];
    cell.content.text = [dict objectForKey:@"details"];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURL,dict[@"headImgUrl"]]] placeholderImage:nil];
    cell.time.text = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"createTime"]] stringByFormatString:@"MM-dd HH:mm"];
    return cell;
}
- (CGFloat)height
{
    return 120;
}
- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
