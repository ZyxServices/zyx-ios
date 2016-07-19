//
//  XZEditShippingTableViewController.m
//  SportClub
//
//  Created by zhaowei on 13/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZEditShippingTableViewController.h"

@interface XZEditShippingTableViewController ()

@end

@implementation XZEditShippingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc] init];//去除多余的分割线
}
@end
