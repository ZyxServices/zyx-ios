//
//  XZFeaturedCircleTableViewController.m
//  SportClub
//
//  Created by zhaowei on 20/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZFeaturedCircleTableViewController.h"
#import "XZFeatureCircleTableViewCell.h"
#import "XZAttentionTableViewCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface XZFeaturedCircleTableViewController () <SDCycleScrollViewDelegate>
@property (nonatomic, strong)  XZAttentionTableViewCell *prototypeCell;
@property (nonatomic, strong) NSArray *data;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *topScrollView;

@end

@implementation XZFeaturedCircleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"attention"];
    self.data = @[@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数",@"icon":@"1",@"name":@"zhaowei"},@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"UITableView是一次性计算完所有Cell的高度，如果有1W个Cell，那么- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次。",@"icon":@"1",@"name":@"zhaowei"},@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"UITableView是一次性计算完所有Cell的高度，如果有1W个Cell，那么- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次。",@"icon":@"1",@"name":@"zhaowei"},@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"UITableView是一次性计算完所有Cell的高度，如果有1W个Cell，那么- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次。",@"icon":@"1",@"name":@"zhaowei"},@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"UITableView是一次性计算完所有Cell的高度，如果有1W个Cell，那么- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次。",@"icon":@"1",@"name":@"zhaowei"}];
    
    _topScrollView.delegate = self;
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg"
                            ];
    _topScrollView.imageURLStringsGroup = imageNames;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        static NSString *identifier = @"attention";
        XZAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        NSDictionary *dict = self.data[0];
        [cell setModel:dict];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else  {
        static NSString *identifier = @"featureCircle";
        XZFeatureCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.circleName.text = [NSString stringWithFormat:@"测试%ld",(long)indexPath.row];
        cell.circleNums.text = @"共计2014个帖子";
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        NSDictionary *dict = self.data[0];
        [self.prototypeCell setModel:dict];
        return [self.prototypeCell height];
    } else  {
        return 67;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

#pragma mark SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

@end
