//
//  MyCollectionVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/15.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "MyCollectionVC.h"
#import "ChapterExercisesCellModel.h"
#import "ChapterExercisesSectionModel.h"
#import "ChapterExercisesHeaderView.h"
#import "ChapterExercisesCell.h"
#import "ExaminationInfoVC.h"

@interface MyCollectionVC ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger tapSection; //记录当前点击的section，用于willDisplayCell方法中cell出现

@end

@implementation MyCollectionVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_SafeBottomMargin);
    
    [self.view addSubview:self.coustromTableView];
    
    self.dataSource = [[NSMutableArray alloc] init];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    
    [PPNetworkHelper POST:@"/user/collect_list/" parameters:parametersDic hudString:nil success:^(id responseObject)
     {
         if ([responseObject count] > 0)
         {
             for (NSDictionary * dic in responseObject)
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
             [MBProgressHUD showInfoMessage:@"暂时没有收藏"];
         }
     } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
     }];
}

#pragma mark - Custom Accessors (控件响应方法)


#pragma mark - IBActions(xib响应方法)


#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

#pragma mark - Deletate/DataSource (相关代理)

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ChapterExercisesSectionModel *model = self.dataSource[section];
    return model.isFold ? 0 : model.section.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExaminationInfoVC * vc = [[ExaminationInfoVC alloc] init];
    ChapterExercisesSectionModel *sectionModel = self.dataSource[indexPath.section];
    ChapterExercisesCellModel * cellModel = sectionModel.section[indexPath.row];
    vc.type = cellModel.typeKey;
    vc.unit = sectionModel.unit;
    vc.section = cellModel.section;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Setter/Getter


@end
