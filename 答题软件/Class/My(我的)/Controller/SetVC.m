//
//  SetVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/23.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "UserSetVC.h"
#import "PassWordSetVC.h"

@interface UserSetVC ()

@end

@implementation UserSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号管理";
}

- (IBAction)setPasswordButtonCilick:(id)sender
{
    //设置密码
    PassWordSetVC * vc = [[PassWordSetVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)canelButtonCilick:(id)sender
{
    //退出
}

@end
