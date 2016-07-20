//
//  XZAttentionTableViewCell.m
//  SportClub
//
//  Created by zhaowei on 20/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZAttentionTableViewCell.h"

@implementation XZAttentionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(NSDictionary *)dic {
    if ([[dic objectForKey:@"type"] intValue] == 1) { //3张图
        if ([dic objectForKey:@"title"]) {
            _icon.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
            _icon.contentMode = UIViewContentModeScaleToFill;
            _name.text = [dic objectForKey:@"name"];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, XZScreenWidth-24, 20)];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:12];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.textColor = [UIColor colorWithHexString:@"333333"];
            NSString *title = [dic objectForKey:@"title"] ;
            CGRect rect = [title boundingRectWithSize:CGSizeMake(XZScreenWidth -24, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
            label.text = [dic objectForKey:@"title"];
            label.frame = CGRectMake(12, 0, rect.size.width, rect.size.height);
            [self.content addSubview:label];
            
            for(int i=0; i<3; i++) {
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i* (XZScreenWidth-4*5)/3 + i*5, label.frame.origin.y +5 + label.frame.size.height, (XZScreenWidth-4*5)/3, 60)];
                [self.content addSubview:img];
                img.contentMode = UIViewContentModeScaleToFill;
                NSArray *array = [dic objectForKey:@"content"];
                img.image = [UIImage imageNamed:array[i]];
                if (i==2) {
                    self.content.frame = CGRectMake(0, 63, XZScreenWidth, img.frame.origin.y+ img.frame.size.height);
                    _height = img.frame.origin.y+ img.frame.size.height + 63 + 5 +26;
                }
            }
            
        }
    }
    
}
@end
