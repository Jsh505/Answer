//
//  HomeVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/13.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "HomeVC.h"
#import "ZLNaviContrViewController.h"
#import "PYSearch.h"
#import "SearchRuesltVC.h"
#import "SDCycleScrollView.h"
#import "HomeFourButtonView.h"
#import "HomeTableViewHeaderView.h"
//#import "HomeTableViewCell.h"
#import "ChapterExercisesVC.h"
#import "SimulationTestVC.h"
#import "OverTheYearsVC.h"
#import "ExaminationInfoVC.h"
#import "WrongExerciseVC.h"
#import "FL_Button.h"
#import "HomeTitleViewCell.h"
#import "LookMoreVC.h"

//二级列表
#import "ChapterExercisesCellModel.h"
#import "ChapterExercisesSectionModel.h"
#import "ChapterExercisesHeaderView.h"
#import "ChapterExercisesCell.h"
#import "ExaminationInfoVC.h"

@interface HomeVC () <PYSearchViewControllerDelegate, SDCycleScrollViewDelegate>
{
    int _page;
}

@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic, strong) SDCycleScrollView * cycleScrollTextView;
@property (nonatomic, strong) HomeFourButtonView * fourButtonView;

@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) FL_Button * titleButton;
@property (nonatomic, strong) UITableView * titleTableView;

@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableArray * titleDataSource;
@property (nonatomic, strong) NSMutableArray * imageArray;
@property (nonatomic, strong) NSMutableArray * urlArray;
@property (nonatomic, strong) NSMutableArray * textArray;
@property (nonatomic, strong) NSMutableArray * hotArray;

@property (nonatomic, assign) NSInteger tapSection; //记录当前点击的section，用于willDisplayCell方法中cell出现时的动画。

@end

@implementation HomeVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.coustromTableView.frame = CGRectMake(0, JSH_NavbarAndStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_TabBarHeight);
    self.coustromTableView.tableHeaderView = self.headerView;
    [self addPush2LoadMoreWithTableView:self.coustromTableView WithIsInset:NO];
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.coustromTableView];
    
    self.dataSource = [[NSMutableArray alloc] init];
    self.titleDataSource = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];
    self.urlArray = [[NSMutableArray alloc] init];
    self.textArray = [[NSMutableArray alloc] init];
    self.hotArray = [[NSMutableArray alloc] init];
    
    [self loadData];
    _page = 1;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)loadData
{
    [PPNetworkHelper GET:@"/exam/index" parameters:nil hudString:nil responseCache:^(id responseCache)
     {
         //热门搜索
         self.hotArray = [responseCache objectForKey:@"hotArr"];
         //分组
         self.titleDataSource = [responseCache objectForKey:@"group"];
         [self.titleButton setTitle:self.titleDataSource[0] forState:UIControlStateNormal];
         [UserSignData share].user.localGroup = self.titleDataSource[0];
         [self.titleTableView reloadData];
         //轮播图
         for (NSDictionary * dic in [responseCache objectForKey:@"slideshow"])
         {
             [self.imageArray addObject:[dic objectForKey:@"img"]];
             [self.urlArray addObject:[dic objectForKey:@"url"]];
         }
         self.cycleScrollView.imageURLStringsGroup = self.imageArray;
         //轮播文本
         self.textArray = [responseCache objectForKey:@"infoArr"];
         self.cycleScrollTextView.titlesGroup = self.textArray;
         //精选考题
         for (NSDictionary * dic in [[responseCache objectForKey:@"exam"] objectForKey:@"unit"])
         {
             ChapterExercisesSectionModel * model = [[ChapterExercisesSectionModel alloc] initWithDictionary:dic];
             model.isFold = YES;
             model.section = [[NSMutableArray alloc] init];
             for (NSDictionary * sectionDic in [dic objectForKey:@"section"])
             {
                 ChapterExercisesCellModel * cellModel = [[ChapterExercisesCellModel alloc] initWithDictionary:sectionDic];
                 [model.section addObject:cellModel];
             }
             [self.dataSource addObject:model];
         }
         [self.coustromTableView reloadData];
    } success:^(id responseObject)
    {
        if (self.dataSource.count != 0)
        {
            return ;
        }
        //热门搜索
        self.hotArray = [responseObject objectForKey:@"hotArr"];
        //分组
        self.titleDataSource = [responseObject objectForKey:@"group"];
        [self.titleButton setTitle:self.titleDataSource[0] forState:UIControlStateNormal];
        [UserSignData share].user.localGroup = self.titleDataSource[0];
        [self.titleTableView reloadData];
        //轮播图
        for (NSDictionary * dic in [responseObject objectForKey:@"slideshow"])
        {
            [self.imageArray addObject:[dic objectForKey:@"img"]];
            [self.urlArray addObject:[dic objectForKey:@"url"]];
        }
        self.cycleScrollView.imageURLStringsGroup = self.imageArray;
        //轮播文本
        self.textArray = [responseObject objectForKey:@"infoArr"];
        self.cycleScrollTextView.titlesGroup = self.textArray;
        //精选考题
        for (NSDictionary * dic in [[responseObject objectForKey:@"exam"] objectForKey:@"unit"])
        {
            ChapterExercisesSectionModel * model = [[ChapterExercisesSectionModel alloc] initWithDictionary:dic];
            model.isFold = YES;
            model.section = [[NSMutableArray alloc] init];
            for (NSDictionary * sectionDic in [dic objectForKey:@"section"])
            {
                ChapterExercisesCellModel * cellModel = [[ChapterExercisesCellModel alloc] initWithDictionary:sectionDic];
                [model.section addObject:cellModel];
            }
            [self.dataSource addObject:model];
        }
        [self.coustromTableView reloadData];
    } failure:^(NSString *error)
    {
        [MBProgressHUD showErrorMessage:error];
    }];
}

- (void)loadListData
{
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:self.titleButton.titleLabel.text forKey:@"group"];
    [parametersDic setObject:@"精选考题" forKey:@"group_type"];
    [parametersDic setObject:@(_page) forKey:@"pageNumber"];
    
    [PPNetworkHelper POST:@"/exam/paging/" parameters:parametersDic hudString:@"获取中..." success:^(id responseObject)
     {
         if (_page == 1)
         {
             [self.dataSource removeAllObjects];
         }
         if ([[responseObject objectForKey:@"unit"] count] > 0)
         {
             for (NSDictionary * dic in [responseObject objectForKey:@"unit"])
             {
                 ChapterExercisesSectionModel * model = [[ChapterExercisesSectionModel alloc] initWithDictionary:dic];
                 model.isFold = YES;
                 model.section = [[NSMutableArray alloc] init];
                 for (NSDictionary * sectionDic in [dic objectForKey:@"section"])
                 {
                     ChapterExercisesCellModel * cellModel = [[ChapterExercisesCellModel alloc] initWithDictionary:sectionDic];
                     [model.section addObject:cellModel];
                 }
                 [self.dataSource addObject:model];
             }
             [self.coustromTableView reloadData];
         }
         else
         {
             if (_page == 1)
             {
                 [MBProgressHUD showInfoMessage:@"暂无数据"];
             }
             else
             {
                 _page --;
                 [MBProgressHUD showInfoMessage:@"没有更多了"];
             }
         }
        [self endRefreshing];
    } failure:^(NSString *error)
    {
        [MBProgressHUD showErrorMessage:error];
        _page = 1;
        [self endRefreshing];
    }];
}

- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView
{
    _page ++;
    [self loadListData];
}

#pragma mark - Custom Accessors (控件响应方法)

- (void)search
{
    //搜索
    {
        [self.titleTableView removeFromSuperview];
        // 1. Create an Array of popular search
        NSArray *hotSeaches = self.hotArray;
        // 2. Create a search view controller
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            // Called when search begain.
            // eg：Push to a temp view controller
            SearchRuesltVC * vc = [[SearchRuesltVC alloc] init];
            vc.searchText = searchText;
            [searchViewController.navigationController pushViewController:vc animated:YES];
        }];
        // 3. Set style for popular search and search history
        searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
        //    [searchViewController setSearchBarBackgroundColor:[UIColor mainColor]];
        searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
        // 4. Set delegate
        searchViewController.delegate = self;
        // 5. Present a navigation controller
        ZLNaviContrViewController *nav = [[ZLNaviContrViewController alloc] initWithRootViewController:searchViewController];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)titleButtonClicked:(UIButton *)send
{
    //选择类型
    send.selected = !send.selected;
    if (send.selected)
    {
        [self.view addSubview:self.titleTableView];
    }
    else
    {
        [self.titleTableView removeFromSuperview];
    }
}

- (void)headerViewSingleTap
{
    //查看更多
    LookMoreVC * vc = [[LookMoreVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - IBActions(xib响应方法)

- (void)lianxiBUttonCilick
{
    ChapterExercisesVC * vc = [[ChapterExercisesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    WrongExerciseVC * vc = [[WrongExerciseVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)

-(void)jq_tapHeaderView:(UIGestureRecognizer *)tap
{
    ChapterExercisesHeaderView *headerView = (ChapterExercisesHeaderView *)tap.view;
    
    NSInteger section = headerView.tag;
    self.tapSection = section;  //记录当前点击的section，用于willDisplayCell方法中cell出现时的动画。
    
    ChapterExercisesSectionModel *foldModel = self.dataSource[section];
    
    //没有row的时候，不改变折叠状态
    if (foldModel.section.count==0)
    {
        return;
    }
    //最后一项一直打开
    foldModel.isFold = !foldModel.isFold;
    
    
//    [self.coustromTableView reloadData];
    //虽然有折叠效果，但是headerView会闪一下。
    [self.coustromTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Deletate/DataSource (相关代理)

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView != self.titleTableView)
    {
        return self.dataSource.count;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView != self.titleTableView)
    {
        return 70;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView != self.titleTableView)
    {
        ChapterExercisesHeaderView *headerView = [ChapterExercisesHeaderView loadViewFromXIB];
        headerView.tag = section;
        
        ChapterExercisesSectionModel *foldModel = self.dataSource[section];
        headerView.model = foldModel;
        
        //点击头部view
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jq_tapHeaderView:)];
        [headerView addGestureRecognizer:tap];
        
        return headerView;
    }
    else
    {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView != self.titleTableView)
    {
        ChapterExercisesSectionModel *model = self.dataSource[section];
        return model.isFold ? 0 : model.section.count;
    }
    else
    {
        return self.titleDataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != self.titleTableView)
    {
        return 60;
    }
    else
    {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != self.titleTableView)
    {
        ChapterExercisesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChapterExercisesCellident"];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ChapterExercisesCell" owner:nil options:nil];
            cell = array[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        ChapterExercisesSectionModel *sectionModel = self.dataSource[indexPath.section];
        ChapterExercisesCellModel * cellModel = sectionModel.section[indexPath.row];
        
        cell.model = cellModel;
        return cell;
    }
    else
    {
        HomeTitleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTitleViewCellident"];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"HomeTitleViewCell" owner:nil options:nil];
            cell = array[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.titleLB.text = self.titleDataSource[indexPath.row];
        return cell;
    }
}

//属性字符串
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != self.titleTableView)
    {
        ExaminationInfoVC * vc = [[ExaminationInfoVC alloc] init];
        ChapterExercisesSectionModel *sectionModel = self.dataSource[indexPath.section];
        ChapterExercisesCellModel * cellModel = sectionModel.section[indexPath.row];
        vc.type = @"精选考题";
        vc.unit = sectionModel.unit;
        vc.section = cellModel.section;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        self.titleButton.selected = NO;
        [self.titleTableView removeFromSuperview];
        [self.titleButton setTitle:self.titleDataSource[indexPath.row] forState:UIControlStateNormal];
        [UserSignData share].user.localGroup = self.titleDataSource[indexPath.row];
        _page = 1;
        [self loadListData];
    }
}


#pragma mark - Setter/Getter

- (UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 320 / 375 + 44)];
        [_headerView addSubview:self.cycleScrollView];
        
        UIImageView * laba = [[UIImageView alloc] initWithFrame:CGRectMake(5, SCREEN_WIDTH * 200 / 375 - 25, 24, 24)];
        laba.image = [UIImage imageNamed:@"首页喇叭"];
        [_headerView addSubview:laba];
        
        [_headerView addSubview:self.cycleScrollTextView];
        [_headerView addSubview:self.fourButtonView];
        
        HomeTableViewHeaderView * view = [HomeTableViewHeaderView loadViewFromXIB];
        view.frame = CGRectMake(0, SCREEN_WIDTH * 320 / 375 - 1, SCREEN_WIDTH, 44);
        UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewSingleTap)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [view addGestureRecognizer:singleRecognizer];
        
        [_headerView addSubview:view];
    }
    return _headerView;
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView)
    {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 200 / 375 - 30) delegate:self placeholderImage:Default_General_Image];
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.onlyDisplayText = NO;
        _cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
        _cycleScrollView.titleLabelTextColor = [UIColor mainTextColor];
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
        _cycleScrollTextView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(30, SCREEN_WIDTH * 200 / 375 - 30, SCREEN_WIDTH - 30, 30) delegate:self placeholderImage:Default_General_Image];
        _cycleScrollTextView.showPageControl = NO;
//        _cycleScrollTextView.titlesGroup = @[@"1111",@"2222",@"3333"];
        _cycleScrollTextView.onlyDisplayText = YES;
        _cycleScrollTextView.titleLabelBackgroundColor = [UIColor whiteColor];
        _cycleScrollTextView.titleLabelTextColor = [UIColor mainTextColor];
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

- (UIView *)titleView
{
    if (!_titleView)
    {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JSH_NavbarAndStatusBarHeight)];
        _titleView.backgroundColor = [UIColor mainColor];
        
        UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        searchButton.frame = CGRectMake(SCREEN_WIDTH - 50, JSH_StatusBarHeight, 50, JSH_NavBarHeight);
        [searchButton setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
        searchButton.backgroundColor = [UIColor clearColor];
        [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:searchButton];
        
        [_titleView addSubview:self.titleButton];
    }
    return _titleView;
}

- (FL_Button *)titleButton
{
    if (!_titleButton)
    {
        _titleButton = [FL_Button buttonWithType:UIButtonTypeCustom];
        _titleButton.frame = CGRectMake(50, JSH_StatusBarHeight, SCREEN_WIDTH - 100, JSH_NavBarHeight);
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_titleButton setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        [_titleButton setTitle:@"" forState: UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _titleButton.backgroundColor = [UIColor clearColor];
        [_titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _titleButton.status = FLAlignmentStatusCenter;
    }
    return _titleButton;
}

- (UITableView *)titleTableView
{
    {
        if (!_titleTableView) {
            _titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, JSH_NavbarAndStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight) style:UITableViewStylePlain];
            _titleTableView.delegate = self;
            _titleTableView.dataSource = self;
            _titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _titleTableView.showsVerticalScrollIndicator = NO;
            _titleTableView.showsHorizontalScrollIndicator = NO;
            _titleTableView.backgroundColor = [UIColor clearColor];
        }
        return _titleTableView;
    }
}


@end
