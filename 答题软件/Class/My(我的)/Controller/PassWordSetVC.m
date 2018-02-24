//
//  PassWordSetVC.m
//  笑园之窗
//
//  Created by 贾仕海 on 2018/1/2.
//  Copyright © 2018年 xyzc. All rights reserved.
//

#import "PassWordSetVC.h"

@interface PassWordSetVC ()

@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *nPassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *rPassWordTF;

@end

@implementation PassWordSetVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
}


#pragma mark - Custom Accessors (控件响应方法)


#pragma mark - IBActions(xib响应方法)

- (IBAction)commitButtonCilick:(id)sender
{
    //提交
}

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)


#pragma mark - Setter/Getter

@end
