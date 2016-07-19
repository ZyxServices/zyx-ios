//
//  XZPersonalSetTableViewController.m
//  SportClub
//
//  Created by zhaowei on 13/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZPersonalSetTableViewController.h"

@interface XZPersonalSetTableViewController ()

@end

@implementation XZPersonalSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)signOut:(id)sender {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [params setObject:[Helper_UserDefault objectForKey:@"TOKEN"] forKey:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/signout"];
    [XZNetManager get:url params:params success:^(id json) {
        [Helper_UserDefault removeObjectForKey:@"TOKEN"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        XZLog(@"%@",json);
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.localizedDescription];
        //        XZLog(@"%@",error);
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return 10;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    return 5;
}
@end
