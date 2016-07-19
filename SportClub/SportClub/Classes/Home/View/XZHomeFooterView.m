//
//  XZHomefooterView.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeFooterView.h"
#import "XZHomeUserCell.h"



static NSString *XZUserCollectionViewCellID = @"userCollectionViewCellID";

@interface XZHomeFooterView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *userCollectionView;
@property (weak, nonatomic) IBOutlet UIView *moreUserView;

@end



@implementation XZHomeFooterView
+(instancetype)footerWithDataArray:(NSArray *)dataArray
{
    XZHomeFooterView *footView = [[[NSBundle mainBundle]loadNibNamed:@"XZHomeFooterView" owner:nil options:nil]lastObject];
    footView.data = dataArray;
    return footView;
}
- (IBAction)moreUser:(id)sender {
}

-(void)awakeFromNib
{
    CGRect rect = CGRectMake(0, 0, XZScreenWidth, 115);
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 20, 15, 20);
    self.userCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    self.userCollectionView.dataSource = self;
    self.userCollectionView.delegate = self;
    [self.userCollectionView registerNib:[UINib nibWithNibName:@"XZHomeUserCell" bundle:nil] forCellWithReuseIdentifier:XZUserCollectionViewCellID];
    self.userCollectionView.backgroundColor = [UIColor whiteColor];
    [self.moreUserView addSubview:self.userCollectionView];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XZHomeUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XZUserCollectionViewCellID forIndexPath:indexPath];
    NSDictionary *dict = _data[indexPath.row];
   [cell.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURL,dict[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

#pragma makr -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
