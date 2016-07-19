//
//  XZPersonalFansViewController.m
//  SportClub
//
//  Created by zhaowei on 12/7/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZPersonalFansViewController.h"
#import "XZMyFansTableViewCell.h"
#import "XZMyFansView.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface XZPersonalFansViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray                 *_dataArray;             //数据源
    UIView                  *_topView;
    UITableView          *_tableView;
    NSMutableArray   *_indexArray;           //存下标数组
    NSMutableDictionary * _sectionDict; //存处理过以后的数据
}
@end

@implementation XZPersonalFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArray = [NSArray arrayWithObjects:@"控件", @"感觉",@"iu",@"你吧",@"温柔",@"啊啊",@"骗局",@"门口",@"呃呃",@"快播",@"218",nil];
    _indexArray = [NSMutableArray array];
    _sectionDict = [NSMutableDictionary dictionary];
    
    if (_type == 1) {
        self.title = @"我的关注";
        [self addTopView];
    }else {
        self.title = @"我的粉丝";
        [self addTopView2];
    }
   
    
    [self addTableView];
    [self ProcessData];  //整理数据
}
- (void)addTopView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    _topView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
//    [self.view addSubview:_topView];
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 50)];
    search.placeholder = @"搜索";
    search.backgroundColor = [UIColor clearColor];
    search.tintColor = [UIColor clearColor];
    [search setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [search sizeToFit];
    [_topView addSubview:search];
    
    XZMyFansView *daka = [[XZMyFansView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 65)];
    daka.imgView.image = [UIImage imageNamed:@"icon_big shot"];
    daka.nameLabel.text = @"大咖";
    [_topView addSubview:daka];
    
    XZMyFansView *quanzi = [[XZMyFansView alloc] initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH, 65)];
    quanzi.imgView.image = [UIImage imageNamed:@"icon_Build a circle"];
    quanzi.nameLabel.text = @"圈子";
    [_topView addSubview:quanzi];
}
- (void)addTopView2 {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _topView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    //    [self.view addSubview:_topView];
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 50)];
    search.placeholder = @"搜索";
    search.backgroundColor = [UIColor clearColor];
    search.tintColor = [UIColor clearColor];
    [search setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [search sizeToFit];
    [_topView addSubview:search];
}

#pragma mark - 列表
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,  SCREEN_WIDTH, SCREEN_HEIGHT-64) style:0];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _topView;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 64, SCREEN_WIDTH-64, 0.5);
    [self.view addSubview:_tableView];
}
-(void)ProcessData{
    for (int i = 0; i < _dataArray.count; i ++) {
        NSString *str = _dataArray[i]; //一开始的内容
        if (str.length) {  //下面那2个转换的方法一个都不能少
            NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
            //汉字转拼音
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            }
            //拼音转英文
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
                //字符串截取第一位
                NSString *firstStr = [[ms substringToIndex:1] uppercaseString];
                //如果不是字母开头的，转为＃
                BOOL isLetter = [self MatchLetter:firstStr];
                if (!isLetter)
                    firstStr = @"#";
                
                //如果还没有索引
                if (_indexArray.count <= 0) {
                    //保存当前这个做索引
                    [_indexArray addObject:firstStr];
                    //用这个字母做字典的key，将当前的标题保存到key对应的数组里面去
                    NSMutableArray *array = [NSMutableArray arrayWithObject:str];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:array,firstStr, nil];
                    _sectionDict = dic;
                }else{
                    //如果索引里面包含了当前这个字母，直接保存数据
                    if ([_indexArray containsObject:firstStr]) {
                        //取索引对应的数组，保存当前标题到数组里面
                        NSMutableArray *array = _sectionDict[firstStr];
                        [array addObject:str];
                        //重新保存数据
                        [_sectionDict setObject:array forKey:firstStr];

                    }else{
                        //如果没有包含，说明是新的索引
                        [_indexArray addObject:firstStr];
                        //用这个字母做字典的key，将当前的标题保存到key对应的数组里面去
                        NSMutableArray *array = [NSMutableArray arrayWithObject:str];
                        [_sectionDict setObject:array forKey:firstStr];
                    }
                }
            }
        }
    }
    
    //将字母排序
    NSArray *compareArray = [[_sectionDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _indexArray = [NSMutableArray arrayWithArray:compareArray];
    
    //判断第一个是不是字母，如果不是放到最后一个
    BOOL isLetter = [self MatchLetter:_indexArray[0]];
    if (!isLetter) {
        //获取数组的第一个元素
        NSString *firstStr = [_indexArray firstObject];
        //移除第一项元素
        [_indexArray removeObjectAtIndex:0];
        //插入到最后一个位置
        [_indexArray insertObject:firstStr atIndex:_indexArray.count];
    }
    
    [_tableView reloadData];
}

#pragma mark - tableView代理
//列表分为几组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _indexArray.count;
}

//每一组分多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sectionDict[_indexArray[section]] count];
}

//每一个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

//每一个分组的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24;
}

//每一个分组里面显示的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 24)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 24)];
    label.text = _indexArray[section];
    label.textColor = [UIColor colorWithHexString:@"999999"];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myfans";
    
    XZMyFansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XZMyFansTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *currentArray = _sectionDict[_indexArray[indexPath.section]];
    cell.nameLabel.text =currentArray[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:@"3"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//设置右侧索引的标题，这里返回的是一个数组哦！
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexArray;
}

#pragma mark - 匹配是不是字母开头
-(BOOL)MatchLetter:(NSString *)str
{
    //判断是否以字母开头
    NSString *ZIMU = @"^[A-Za-z]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}

@end
