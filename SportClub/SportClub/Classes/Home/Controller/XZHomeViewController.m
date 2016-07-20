//
//  XZHomeViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeViewController.h"
#import "XZLogRegisterViewController.h"
#import "XZNavigationController.h"
#import "XZHomeHeaderView.h"
#import "XZHomefooterView.h"
#import "XZHomeLiveTableViewCell.h"
#import "XZRedTimelineTableViewCell.h"
#import "XZMomentsTableViewCell.h"
#import "XZCollectionViewCell.h"
#import "XZMomentsTitleViewCell.h"
#import "XZPersonalHomeViewController.h"

#import "XZPersonalFansViewController.h" //测试

@interface XZHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *cirleDevas;
    NSArray *liveDevas;
    NSDictionary *liveWatchNums;
    NSArray *userDevas;
    NSArray *activityDevas;
    NSArray *concernDevas;
}
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) XZHomeHeaderView *headerView;
@property (nonatomic, strong) XZHomeFooterView *footerView;
@property (strong, nonatomic) NSMutableArray *imagesArray;

@end

@implementation XZHomeViewController
-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        self.imagesArray = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<=4; i++) {
            [self.imagesArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _imagesArray;
}
#pragma life clcle

- (void)loadView{
    _contentTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    self.view = _contentTableView;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *token = [Helper_UserDefault objectForKey:@"TOKEN"];
    if (token) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 36, 36);
        [btn addTarget:self action:@selector(personal) forControlEvents:UIControlEventTouchUpInside];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:18];
        
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = item;
    } else {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"user_placeholder"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 36, 36);
        [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:18];
        
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = item;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    self.contentTableView.tableHeaderView = [self headerView];
    self.contentTableView.tableFooterView = [self footerView];
    
    [self loadNetWork];
}

- (void)loadNetWork {
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/deva/getAll"];
    [XZNetManager post:url params:nil success:^(id json) {
        XZLog(@"%@",json);
        
        cirleDevas = json[@"data"][@"cirleDevas"]; //首页圈子
        liveDevas = json[@"data"][@"liveDevas"];//首页直播
        liveWatchNums = json[@"data"][@"liveWatchNums"];//首页直播人数
        userDevas = json[@"data"][@"userDevas"];//首页推荐用户
        activityDevas = json[@"data"][@"activtyDevas"];//首页活动
        concernDevas = json[@"data"][@"concerDevas"];//首页动态

        if(![cirleDevas isKindOfClass:[NSArray class]] || ![liveDevas isKindOfClass:[NSArray class]] || ![userDevas isKindOfClass:[NSArray class]] || ![liveWatchNums isKindOfClass:[NSDictionary class]] || ![activityDevas isKindOfClass:[NSArray class]] || ![concernDevas isKindOfClass:[NSArray class]]) {
            cirleDevas = [NSArray array];
            liveDevas = [NSArray array];
            liveWatchNums = [NSDictionary dictionary];
            userDevas = [NSArray array];
            activityDevas = [NSArray array];
            concernDevas = [NSArray array];
            return ;
        }
        [self.contentTableView reloadData];
        
        self.contentTableView.tableHeaderView = [[XZHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 226) withDataArray:activityDevas];
        self.contentTableView.tableFooterView = [XZHomeFooterView  footerWithDataArray:userDevas];
    } failure:^(NSError *error) {
         [MBProgressHUD showError:error.localizedDescription];
        XZLog(@"%@",error);
    }];
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        XZHomeLiveTableViewCell *cell1 = [XZHomeLiveTableViewCell cellWithTableView:tableView withDataArray:liveDevas andWatchNums:liveWatchNums];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    } else if (indexPath.row == 1) {
        XZRedTimelineTableViewCell *cell2 = [XZRedTimelineTableViewCell cellWithTableView:tableView withDataArray:concernDevas andIndexPath:indexPath];
        return cell2;
    } else if (indexPath.row == 2) {
        XZMomentsTitleViewCell *cell3 = [XZMomentsTitleViewCell cellWithTableView:tableView];
        return cell3;
    } else {
        XZMomentsTableViewCell *cell4= [XZMomentsTableViewCell cellWithTableView:tableView withDataArray:cirleDevas andIndexPath:indexPath];
        return cell4;
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 282;
    } else if (indexPath.row == 1) {
        return  [XZRedTimelineTableViewCell cellHeight];
    } else if (indexPath.row == 2){
        return 45;
    } else {
        return 164;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (XZHomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[XZHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 226) withDataArray:activityDevas];
    }
    return _headerView;
}

- (XZHomeFooterView *)footerView{
    if (!_footerView) {
        
        _footerView = [XZHomeFooterView  footerWithDataArray:userDevas];
    }
    return _footerView;
}

#pragma mark -setupNav
- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)login{
    XZLogRegisterViewController *login = [XZLogRegisterViewController new];
    XZNavigationController *na = [[XZNavigationController alloc] initWithRootViewController:login];
    [self presentViewController:na animated:YES completion:nil];
}

-(void)personal {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"XZPersonalHomeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)search
{
}
@end
