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
@interface XZDiscoverViewController ()
@property (nonatomic, strong) HMSegmentedControl *segCtrl;
@property (nonatomic, strong) NSArray  *titleList;
@property (nonatomic, weak) UIViewController *showingVC;
@end

@implementation XZDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
      _titleList = @[@"我的关注", @"大咖动态", @"精选圈子"];
    [self addHeaderView];
}
- (void)addHeaderView {

    _segCtrl = [[HMSegmentedControl alloc] initWithSectionTitles:_titleList];
    _segCtrl.frame = CGRectMake(0, 64, XZScreenWidth, 40);
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
    [self.view addSubview:_segCtrl];
    
    [_segCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl*)sender {
    
}
@end
