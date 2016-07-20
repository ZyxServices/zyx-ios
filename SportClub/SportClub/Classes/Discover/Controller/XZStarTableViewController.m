//
//  XZStarTableViewController.m
//  SportClub
//
//  Created by zhaowei on 20/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZStarTableViewController.h"
#import "XZStarTableViewCell.h"
@interface XZStarTableViewController ()
@property (nonatomic, strong)  XZStarTableViewCell *prototypeCell;
@property (nonatomic, strong) NSArray *data;
@end

@implementation XZStarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNetWork];

    
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"star"];
    self.data = @[@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数据测试一哈数",@"icon":@"1",@"name":@"zhaowei"},@{@"content":@[@"1",@"2",@"3"], @"type":@"1",@"title":@"UITableView是一次性计算完所有Cell的高度，如果有1W个Cell，那么- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath就会触发1W次。",@"icon":@"1",@"name":@"zhaowei"}]; //type =1 3张图 type＝2 直播图
}
- (void)loadNetWork {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [params setObject:[Helper_UserDefault objectForKey:@"TOKEN"] forKey:@"token"];
    [params setObject:@"10" forKey:@"n"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/cren/starRandom"];
    
    
    //大咖动态接口
    [XZNetManager post:url params:params success:^(id json) {        
        XZLog(@"%@",json);
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.localizedDescription];
        //        XZLog(@"%@",error);
    }];
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
    static NSString *identifier = @"star";
    XZStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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
