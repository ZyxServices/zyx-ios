//
//  XZPersonalHomeViewController.m
//  SportClub
//
//  Created by zhaowei on 8/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZPersonalHomeViewController.h"
#import "XZPersonalCircleTableViewController.h"
#import "XZPersonalCollectTableViewController.h"
#import "XZPersonalWalletTableViewController.h"
#import "BaseTableViewController.h"
#import "CommualHeaderView.h"
#import "HMSegmentedControl.h"
#import "ColorUtility.h"

#import "XZPersonalOrderViewController.h"
#import "XZPersonalSetTableViewController.h"
#import "XZPersonalFansViewController.h"
@interface XZPersonalHomeViewController () <TableViewScrollingProtocol> {
    BOOL _stausBarColorIsBlack;
}

@property (nonatomic, weak) UIView *navView;
@property (nonatomic, strong) HMSegmentedControl *segCtrl;
@property (nonatomic, strong) CommualHeaderView *headerView;

@property (nonatomic, strong) NSArray  *titleList;
@property (nonatomic, weak) UIViewController *showingVC;
@property (nonatomic, strong) NSMutableDictionary *offsetYDict; // 存储每个tableview在Y轴上的偏移量
@end

@implementation XZPersonalHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _titleList = @[@"我的圈子", @"我的收藏", @"我的钱包"];
    
    [self configNav];
    [self addController];
    [self addHeaderView];
    [self segmentedControlChangedValue:_segCtrl];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return _stausBarColorIsBlack ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

#pragma mark - BaseTabelView Delegate
- (void)tableViewScroll:(UITableView *)tableView offsetY:(CGFloat)offsetY{
    if (offsetY > headerImgHeight - topBarHeight) {
        if (![_headerView.superview isEqual:self.view]) {
            [self.view insertSubview:_headerView belowSubview:_navView];
        }
        CGRect rect = self.headerView.frame;
        rect.origin.y = topBarHeight - headerImgHeight;
        self.headerView.frame = rect;
    } else {
        if (![_headerView.superview isEqual:tableView]) {
            for (UIView *view in tableView.subviews) {
                if ([view isKindOfClass:[UIImageView class]]) {
                    [tableView insertSubview:_headerView belowSubview:view];
                    break;
                }
            }
        }
        CGRect rect = self.headerView.frame;
        rect.origin.y = 0;
        self.headerView.frame = rect;
    }
    
    
    if (offsetY>0) {
        CGFloat alpha = offsetY/136;
        self.navView.alpha = alpha;
        
        if (alpha > 0.6 && !_stausBarColorIsBlack) {
            self.navigationController.navigationBar.tintColor = [UIColor blackColor];
            _stausBarColorIsBlack = YES;
            [self setNeedsStatusBarAppearanceUpdate];
        } else if (alpha <= 0.6 && _stausBarColorIsBlack) {
            self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"d80204"];
            _stausBarColorIsBlack = NO;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else {
        self.navView.alpha = 0;
        self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"d80204"];
        _stausBarColorIsBlack = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)tableViewDidEndDragging:(UITableView *)tableView offsetY:(CGFloat)offsetY {
    //    _headerView.canNotResponseTapTouchEvent = NO;  这四行被屏蔽内容，每行下面一行的效果一样
    _headerView.userInteractionEnabled = YES;
    
    NSString *addressStr = [NSString stringWithFormat:@"%p", _showingVC];
    if (offsetY > headerImgHeight - topBarHeight) {
        [self.offsetYDict enumerateKeysAndObjectsUsingBlock:^(NSString  *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:addressStr]) {
                _offsetYDict[key] = @(offsetY);
            } else if ([_offsetYDict[key] floatValue] <= headerImgHeight - topBarHeight) {
                _offsetYDict[key] = @(headerImgHeight - topBarHeight);
            }
        }];
    } else {
        if (offsetY <= headerImgHeight - topBarHeight) {
            [self.offsetYDict enumerateKeysAndObjectsUsingBlock:^(NSString  *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                _offsetYDict[key] = @(offsetY);
            }];
        }
    }
}

- (void)tableViewDidEndDecelerating:(UITableView *)tableView offsetY:(CGFloat)offsetY {
    //    _headerView.canNotResponseTapTouchEvent = NO; 这四行被屏蔽内容，每行下面一行的效果一样
    _headerView.userInteractionEnabled = YES;
    
    NSString *addressStr = [NSString stringWithFormat:@"%p", _showingVC];
    if (offsetY > headerImgHeight - topBarHeight) {
        [self.offsetYDict enumerateKeysAndObjectsUsingBlock:^(NSString  *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:addressStr]) {
                _offsetYDict[key] = @(offsetY);
            } else if ([_offsetYDict[key] floatValue] <= headerImgHeight - topBarHeight) {
                _offsetYDict[key] = @(headerImgHeight - topBarHeight);
            }
        }];
    } else {
        if (offsetY <= headerImgHeight - topBarHeight) {
            [self.offsetYDict enumerateKeysAndObjectsUsingBlock:^(NSString  *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                _offsetYDict[key] = @(offsetY);
            }];
        }
    }
}

- (void)tableViewWillBeginDecelerating:(UITableView *)tableView offsetY:(CGFloat)offsetY {
    //    _headerView.canNotResponseTapTouchEvent = YES; 这四行被屏蔽内容，每行下面一行的效果一样
    _headerView.userInteractionEnabled = NO;
}

- (void)tableViewWillBeginDragging:(UITableView *)tableView offsetY:(CGFloat)offsetY {
    //    _headerView.canNotResponseTapTouchEvent = YES; 这四行被屏蔽内容，每行下面一行的效果一样
    _headerView.userInteractionEnabled = NO;
}

#pragma mark - Private
- (void)configNav {
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"d80204"];
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithHexString:@"d80204"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, kScreenWidth, 20)];
    titleLabel.text = @"个人中心";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    navView.alpha = 0;
    [self.view addSubview:navView];
    
    _navView = navView;
}

- (void)addController {
    XZPersonalCircleTableViewController *vc1 = (XZPersonalCircleTableViewController *)[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"XZPersonalCircleTableViewController"];
    vc1.delegate = self;
    XZPersonalCollectTableViewController *vc2 = (XZPersonalCollectTableViewController *)[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"XZPersonalCollectTableViewController"];
    vc2.delegate = self;
    XZPersonalWalletTableViewController *vc3 = (XZPersonalWalletTableViewController *)[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"XZPersonalWalletTableViewController"];
    vc3.delegate = self;
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
}

- (void)addHeaderView {
    CommualHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"CommualHeaderView" owner:nil options:nil] lastObject];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, headerImgHeight+switchBarHeight);
    self.headerView = headerView;
    self.segCtrl = headerView.segCtrl;
    
    _segCtrl.sectionTitles = _titleList;
    _segCtrl.backgroundColor = [ColorUtility colorWithHexString:@"e9e9e9"];
    _segCtrl.selectionIndicatorHeight = 2.0f;
    _segCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segCtrl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segCtrl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segCtrl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [ColorUtility colorWithHexString:@"d80204"]};
    _segCtrl.selectionIndicatorColor = [ColorUtility colorWithHexString:@"d80204"];
    _segCtrl.selectedSegmentIndex = 0;
    _segCtrl.borderType = HMSegmentedControlBorderTypeBottom;
    _segCtrl.borderColor = [UIColor lightGrayColor];
    
    [_segCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl*)sender {
    [_showingVC.view removeFromSuperview];
    
    BaseTableViewController *newVC = self.childViewControllers[sender.selectedSegmentIndex];
    if (!newVC.view.superview) {
        [self.view addSubview:newVC.view];
        newVC.view.frame = self.view.bounds;
    }
    
    NSString *nextAddressStr = [NSString stringWithFormat:@"%p", newVC];
    CGFloat offsetY = [_offsetYDict[nextAddressStr] floatValue];
    newVC.tableView.contentOffset = CGPointMake(0, offsetY);
    
    [self.view insertSubview:newVC.view belowSubview:self.navView];
    if (offsetY <= headerImgHeight - topBarHeight) {
        [newVC.view addSubview:_headerView];
        for (UIView *view in newVC.view.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [newVC.view insertSubview:_headerView belowSubview:view];
                break;
            }
        }
        CGRect rect = self.headerView.frame;
        rect.origin.y = 0;
        self.headerView.frame = rect;
    }  else {
        [self.view insertSubview:_headerView belowSubview:_navView];
        CGRect rect = self.headerView.frame;
        rect.origin.y = topBarHeight - headerImgHeight;
        self.headerView.frame = rect;
    }
    _showingVC = newVC;
}

#pragma mark - Getter/Setter
- (NSMutableDictionary *)offsetYDict {
    if (!_offsetYDict) {
        _offsetYDict = [NSMutableDictionary dictionary];
        for (BaseTableViewController *vc in self.childViewControllers) {
            NSString *addressStr = [NSString stringWithFormat:@"%p", vc];
            _offsetYDict[addressStr] = @(CGFLOAT_MIN);
        }
    }
    return _offsetYDict;
}

#pragma mark header method

- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)orderClick:(id)sender {
    XZPersonalOrderViewController *vc = (XZPersonalOrderViewController *)[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"XZPersonalOrderViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)personalSetClick:(id)sender {
    XZPersonalSetTableViewController *vc = (XZPersonalSetTableViewController *)[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"XZPersonalSetTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)attentionClick:(id)sender {
    XZPersonalFansViewController *vc = [XZPersonalFansViewController new];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)fansClick:(id)sender {
    XZPersonalFansViewController *vc = [XZPersonalFansViewController new];
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)dynamicClick:(id)sender {
}
- (IBAction)messageClick:(id)sender {
}

@end
