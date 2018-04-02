//
//  RecordVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/13.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "RecordVC.h"
#import "RecordTableViewCell.h"
#import "ExaminationInfoVC.h"
#import "RecordModel.h"
#import "TestResultVC.h"

@interface RecordVC ()

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation RecordVC


#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"搜索" highImage:@"搜索"];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_TabBarHeight);
    
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.coustromTableView];
    
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    
    [PPNetworkHelper POST:@"/online/record_list/" parameters:parametersDic hudString:@"获取中..." success:^(id responseObject)
     {
         [self.dataSource removeAllObjects];
         for (NSDictionary * dic in responseObject)
         {
             RecordModel * model = [[RecordModel alloc] initWithDictionary:dic];
             [self.dataSource addObject:model];
         }
         [self.coustromTableView reloadData];
    } failure:^(NSString *error)
    {
        [MBProgressHUD showErrorMessage:error];
    }];
}

#pragma mark - Custom Accessors (控件响应方法)

- (void)search
{
    //搜索
}

#pragma mark - IBActions(xib响应方法)


#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordTableViewCellident"];
    if (!cell) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"RecordTableViewCell" owner:nil options:nil];
        cell = array[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordModel * model = self.dataSource[indexPath.row];
    TestResultVC * vc = [[TestResultVC alloc] init];
    vc.recordModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Setter/Getter

@end
