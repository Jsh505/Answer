//
//  MyCollectionVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/15.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "MyCollectionVC.h"
#import "HomeTableViewCell.h"

@interface MyCollectionVC ()

@end

@implementation MyCollectionVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_SafeBottomMargin);
    
    [self.view addSubview:self.coustromTableView];
}

#pragma mark - Custom Accessors (控件响应方法)


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


@end
