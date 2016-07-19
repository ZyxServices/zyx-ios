//
//  XZHomeLiveTableViewCell.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeLiveTableViewCell.h"
#import "XZCollectionViewCell.h"
#import "XZLineLayout.h"
@interface XZHomeLiveTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation XZHomeLiveTableViewCell

NSString *const XZMyCollectionViewIdentifier = @"CollectionViewIdentifierID";

+(instancetype)cellWithTableView:(UITableView *)tableView withDataArray:(NSArray *)dataArray andWatchNums:(NSDictionary *)liveWatchNums
{
    static NSString *homeLiveID = @"homeLiveID";
    XZHomeLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeLiveID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XZHomeLiveTableViewCell class]) owner:nil options:nil] lastObject];
    }
    cell.data = dataArray;
    cell.numDic = liveWatchNums;
    if (cell.data.count>0) {
        [cell.collectionView reloadData];
    }
    return cell;
}
-(CGFloat)height{
    return 282;
}
- (void)awakeFromNib {
    // Initialization code
    CGRect rect = CGRectMake(0, 45, XZScreenWidth, 202);
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[XZLineLayout new]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XZCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:XZMyCollectionViewIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreLive:(id)sender {
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCollectionViewCell *liveCell = [collectionView dequeueReusableCellWithReuseIdentifier:XZMyCollectionViewIdentifier forIndexPath:indexPath];
    NSDictionary *dict = _data[indexPath.row];
    [liveCell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURL,dict[@"bgmUrl"]]] placeholderImage:nil];
    liveCell.title.text =  dict[@"title"];
    int num = [[dict objectForKey:@"id"] intValue];
    int wathchNum =  [[_numDic objectForKey:[NSString stringWithFormat:@"%d",num]] intValue];
    [liveCell.number setTitle:[NSString stringWithFormat:@"%d",wathchNum] forState:UIControlStateNormal];
    return liveCell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZLog(@"indexPath.row = %ld",(long)indexPath.row);
}


@end
