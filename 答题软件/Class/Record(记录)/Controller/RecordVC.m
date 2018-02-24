//
//  RecordVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/13.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "RecordVC.h"
#import "RecordTableViewCell.h"

@interface RecordVC ()

@end

@implementation RecordVC


#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"搜索" highImage:@"搜索"];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_TabBarHeight);
    
    [self.view addSubview:self.coustromTableView];
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
    return 5;
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
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - Setter/Getter

@end
