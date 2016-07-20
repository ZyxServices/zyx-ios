//
//  XZDiscoverViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZDiscoverViewController.h"
#import "HMSegmentedControl.h"
#import "ColorUtility.h"
#import "XZAttentionTableViewController.h"
#import "XZStarTableViewController.h"
#import "XZFeaturedCircleTableViewController.h"
#import "XZPersonalWalletTableViewController.h"

@interface XZDiscoverViewController ()
@property (nonatomic, strong) HMSegmentedControl *segCtrl;
@property (nonatomic, strong) NSArray  *titleList;
@property (nonatomic, weak) UIViewController *showingVC;
@end

@implementation XZDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleList = @[@"我的关注", @"大咖动态", @"精选圈子"];
    [self addHeaderView];
    [self addViewController];
    [self segmentedControlChangedValue:_segCtrl];
}

- (void)addHeaderView {
    
    _segCtrl = [[HMSegmentedControl alloc] initWithSectionTitles:_titleList];
    _segCtrl.frame = CGRectMake(0, 64, XZScreenWidth, 40);
    _segCtrl.backgroundColor = [ColorUtility colorWithHexString:@"f7f7f7"];
    _segCtrl.selectionIndicatorHeight = 1.0f;
    _segCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segCtrl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segCtrl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segCtrl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [ColorUtility colorWithHexString:@"d80204"]};
    _segCtrl.selectionIndicatorColor = [ColorUtility colorWithHexString:@"d80204"];
    _segCtrl.selectedSegmentIndex = 0;
    _segCtrl.borderType = HMSegmentedControlBorderTypeBottom;
    _segCtrl.borderColor = [UIColor colorWithHexString:@"e5e5e5"];
    [self.view addSubview:_segCtrl];
    
    [_segCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)addViewController {
    XZAttentionTableViewController *vc1 = (XZAttentionTableViewController *)[[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"XZAttentionTableViewController"];
    [self addChildViewController:vc1];

    
    XZStarTableViewController *vc2 = (XZStarTableViewController *)[[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"XZStarTableViewController"];
    [self addChildViewController:vc2];

    XZFeaturedCircleTableViewController *vc3 = (XZFeaturedCircleTableViewController *)[[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"XZFeaturedCircleTableViewController"];
    [self addChildViewController:vc3];
    
    [self.view addSubview:vc1.view];
    [self.view addSubview:vc2.view];
    [self.view addSubview:vc3.view];
    vc1.view.frame = CGRectMake(0, 104 , XZScreenHeight, XZScreenHeight-104 - self.tabBarController.tabBar.height);
    vc2.view.frame = CGRectMake(0, 104 , XZScreenHeight, XZScreenHeight-104 - self.tabBarController.tabBar.height);
    vc3.view.frame = CGRectMake(0, 104 , XZScreenHeight, XZScreenHeight-104 - self.tabBarController.tabBar.height);

}

- (void)segmentedControlChangedValue:(HMSegmentedControl*)sender {
    UITableViewController *newVC = self.childViewControllers[sender.selectedSegmentIndex];
    [self.view bringSubviewToFront:newVC.view];

}
@end
