//
//  HomeVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/13.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "HomeVC.h"
#import "SDCycleScrollView.h"
#import "HomeFourButtonView.h"
#import "HomeTableViewHeaderView.h"
#import "HomeTableViewCell.h"
#import "SimulationTestVC.h"
#import "OverTheYearsVC.h"

@interface HomeVC ()

@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic, strong) SDCycleScrollView * cycleScrollTextView;
@property (nonatomic, strong) HomeFourButtonView * fourButtonView;

@end

@implementation HomeVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"搜索" highImage:@"搜索"];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_TabBarHeight);
    self.coustromTableView.tableHeaderView = self.headerView;
    
    [self.view addSubview:self.coustromTableView];
}

#pragma mark - Custom Accessors (控件响应方法)

- (void)search
{
    //搜索
}

#pragma mark - IBActions(xib响应方法)

- (void)lianxiBUttonCilick
{
    
}

- (void)testButtonCilick
{
    SimulationTestVC * vc = [[SimulationTestVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)zhentiButtonCilick
{
    OverTheYearsVC * vc = [[OverTheYearsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cuotiButtonCilick
{
    
}

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

#pragma mark UITableViewDataSource


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HomeTableViewHeaderView * view = [HomeTableViewHeaderView loadViewFromXIB];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCellident"];
    if (!cell) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:nil options:nil];
        cell = array[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - Setter/Getter

- (UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 320 / 375)];
        [_headerView addSubview:self.cycleScrollView];
        
        UIImageView * laba = [[UIImageView alloc] initWithFrame:CGRectMake(5, SCREEN_WIDTH * 200 / 375 - 25, 24, 24)];
        laba.image = [UIImage imageNamed:@"首页喇叭"];
        [_headerView addSubview:laba];
        
        [_headerView addSubview:self.cycleScrollTextView];
        [_headerView addSubview:self.fourButtonView];
    }
    return _headerView;
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView)
    {
        //    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:Default_General_Image];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 200 / 375 - 30) shouldInfiniteLoop:YES imageNamesGroup:@[@"大图",@"大图",@"大图"]];
        _cycleScrollView.showPageControl = NO;
        //        _cycleScrollView.titlesGroup = @[@"1111",@"2222",@"3333"];
        _cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
        _cycleScrollView.titleLabelTextColor = [UIColor titleColor];
        //加载网络视图
        //    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    }
    return _cycleScrollView;
}

- (SDCycleScrollView *)cycleScrollTextView
{
    if (!_cycleScrollTextView)
    {
        //    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:Default_General_Image];
        _cycleScrollTextView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(30, SCREEN_WIDTH * 200 / 375 - 30, SCREEN_WIDTH - 30, 30) shouldInfiniteLoop:YES imageNamesGroup:@[@"轮播1",@"轮播2",@"轮播1"]];
        _cycleScrollTextView.showPageControl = NO;
        _cycleScrollTextView.titlesGroup = @[@"1111",@"2222",@"3333"];
        _cycleScrollTextView.onlyDisplayText = YES;
        _cycleScrollTextView.titleLabelBackgroundColor = [UIColor whiteColor];
        _cycleScrollTextView.titleLabelTextColor = [UIColor titleColor];
        //加载网络视图
        //    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    }
    return _cycleScrollTextView;
}

- (HomeFourButtonView *)fourButtonView
{
    if (!_fourButtonView)
    {
        _fourButtonView = [HomeFourButtonView loadViewFromXIB];
        _fourButtonView.frame = CGRectMake(0, SCREEN_WIDTH * 200 / 375, SCREEN_WIDTH, SCREEN_WIDTH * 120 / 375);
       
        [_fourButtonView.lianxiBUtton addTarget:self action:@selector(lianxiBUttonCilick) forControlEvents:UIControlEventTouchUpInside];
        [_fourButtonView.testButton addTarget:self action:@selector(testButtonCilick) forControlEvents:UIControlEventTouchUpInside];
        [_fourButtonView.zhentiButton addTarget:self action:@selector(zhentiButtonCilick) forControlEvents:UIControlEventTouchUpInside];
        [_fourButtonView.cuotiButton addTarget:self action:@selector(cuotiButtonCilick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fourButtonView;
}

@end
