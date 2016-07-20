//
//  XZAttentionTableViewController.m
//  SportClub
//
//  Created by zhaowei on 20/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZAttentionTableViewController.h"
#import "XZAttentionTableViewCell.h"
@interface XZAttentionTableViewController ()
@property (nonatomic, strong)  XZAttentionTableViewCell *prototypeCell;
@property (nonatomic, strong) NSArray *data;
@end

@implementation XZAttentionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"attention"];
    self.data = @[@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数",@"icon":@"1",@"name":@"zhaowei"},@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"UITableView是一次性计算完所有Cell的高度，如果有1W个Cell，那么- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次。",@"icon":@"1",@"name":@"zhaowei"},@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"UITableView是一次性计算完所有Cell的高度，如果有1W个Cell，那么- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次indexPath就会触发1W次。",@"icon":@"1",@"name":@"zhaowei"}]; //type =1 3张图 type＝2 直播图
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"attention";
    XZAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSDictionary *dict = self.data[indexPath.row];
    [cell setModel:dict];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.data[indexPath.row];
    [self.prototypeCell setModel:dict];
    return [self.prototypeCell height];
}
@end
