//
//  XZPersonalOrderViewController.m
//  SportClub
//
//  Created by zhaowei on 13/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZPersonalOrderViewController.h"

@interface XZPersonalOrderViewController ()
@property (weak, nonatomic) IBOutlet UITableView *UITableView;
@property (retain, nonatomic)  NSMutableArray *btnArray;
@property (retain, nonatomic)  UIView *lineView;
@end

@implementation XZPersonalOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btnArray = [NSMutableArray array];
    
    [self addHeadView];
}
- (void)addHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, XZScreenWidth, 34)];
    for (int i=0; i<5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(XZScreenWidth/5 *i, 0, XZScreenWidth/5, 34);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        [headView addSubview:btn];
        [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"d80204"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
        if (i==0) {
           [btn setTitle:@"全部" forState:UIControlStateNormal];
            btn.selected = YES;
        } else if (i==1) {
            [btn setTitle:@"待付款" forState:UIControlStateNormal];
        } else if (i==2) {
            [btn setTitle:@"待发货" forState:UIControlStateNormal];
        } else if (i==3) {
            [btn setTitle:@"待收货" forState:UIControlStateNormal];
        } else if (i==4) {
            [btn setTitle:@"待评价" forState:UIControlStateNormal];
        }
    }
    //添加分割线
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 32, XZScreenWidth, 1)];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [headView addSubview:_lineView];
    self.UITableView.tableHeaderView = headView;
}

- (void)btnClick:(UIButton *)btn {
    for (UIButton *subBtn in self.btnArray) {
        subBtn.selected = NO;
    }
    btn.selected = YES;
}

#pragma mark  tableviewdatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"order";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


@end
