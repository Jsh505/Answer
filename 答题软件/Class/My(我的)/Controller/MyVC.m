//
//  MyVc.m
//  笑园之窗
//
//  Created by 贾仕海 on 2017/12/28.
//  Copyright © 2017年 xyzc. All rights reserved.
//

#import "MyVC.h"
#import "MyTableHeaderView.h"
#import "MyTableViewCell.h"
#import "MessageVC.h"
#import "PersonalInformationTVC.h"
#import "MyCollectionVC.h"
#import "UserSetVC.h"
#import "AboutVC.h"
#import "FeedbackVC.h"
#import "SetVC.h"

@interface MyVC ()

@property (nonatomic, strong) MyTableHeaderView * headerView;
@end

@implementation MyVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIEdgeInsets contentInset = self.coustromTableView.contentInset;
    contentInset.top = - JSH_StatusBarHeight;
    [self.coustromTableView setContentInset:contentInset];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_TabBarHeight);
    self.coustromTableView.tableHeaderView = self.headerView;
    
    [self.view addSubview:self.coustromTableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self.headerView.userImageView jsh_sdsetImageWithHeaderimg:[UserSignData share].user.icon];
    self.headerView.nickNameLB.text = [UserSignData share].user.nick_name;
    self.headerView.phoneLB.text = [UserSignData share].user.phone;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}




#pragma mark - Custom Accessors (控件响应方法)

- (void)messageButtonCilick
{
    MessageVC * vc = [[MessageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)zhangjielianxiBUttonCilick
{
    PersonalInformationTVC * vc = [[UIStoryboard storyboardWithName:@"PersonalInformationTVC" bundle:nil] instantiateViewControllerWithIdentifier:@"PersonalInformationTVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)myshoucangButtonCilick
{
    MyCollectionVC * vc = [[MyCollectionVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)zhanghuguanliButtonCilick
{
    UserSetVC * vc = [[UserSetVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - IBActions(xib响应方法)


#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = @[@"关于得分王i",@"意见反馈",@"设置"];
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCellident"];
    if (!cell) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"MyTableViewCell" owner:nil options:nil];
        cell = array[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLB.text = array[indexPath.row];
    cell.titleImageView.image = [UIImage imageNamed:array[indexPath.row]];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    if (sec == 0 && row == 0)
    {
        //关于
        AboutVC * vc = [[AboutVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sec == 0 && row == 1)
    {
        //反馈意见
        FeedbackVC * vc = [[FeedbackVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sec == 0 && row == 2)
    {
        //设置
        SetVC * vc = [[SetVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - Setter/Getter

- (MyTableHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [MyTableHeaderView loadViewFromXIB];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 280 / 375);
        [_headerView.messageButton addTarget:self action:@selector(messageButtonCilick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.zhangjielianxiBUtton addTarget:self action:@selector(zhangjielianxiBUttonCilick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.myshoucangButton addTarget:self action:@selector(myshoucangButtonCilick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.zhanghuguanliButton addTarget:self action:@selector(zhanghuguanliButtonCilick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

@end
