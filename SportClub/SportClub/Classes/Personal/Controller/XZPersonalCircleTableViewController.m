//
//  XZPersonalCircleTableViewController.m
//  SportClub
//
//  Created by zhaowei on 14/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZPersonalCircleTableViewController.h"
#import "XZMyCircleTableViewCell.h"
@interface XZPersonalCircleTableViewController ()

@end

@implementation XZPersonalCircleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"circle";
    XZMyCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
