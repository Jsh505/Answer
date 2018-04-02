//
//  SetVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/24.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "SetVC.h"
#import <SDImageCache.h>

@interface SetVC ()
@property (weak, nonatomic) IBOutlet UILabel *sizeLb;

@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.sizeLb.text = [NSString stringWithFormat:@"%.2fMB",[SDImageCache sharedImageCache].getSize / 1000.0 /1000];
}

- (IBAction)cleanButtonCilick:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请确认是否清楚缓存" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            self.sizeLb.text = @"0.00MB";
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}

- (IBAction)updateButtonCilick:(id)sender
{
    
}

@end
