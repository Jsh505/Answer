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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认退出?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        [[AppDelegate delegate] goLogin];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}

@end
