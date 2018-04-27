//
//  LoginVC.m
//  笑园之窗
//
//  Created by 贾仕海 on 2017/12/29.
//  Copyright © 2017年 xyzc. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "UserInfoModel.h"
#import "ZLNaviContrViewController.h"
#import "ForgetPasswordVC.h"

@interface LoginVC ()

@property (nonatomic, strong) UITextField * phoneTF;
@property (nonatomic, strong) UITextField * passWordTF;
//@property (nonatomic, strong) UITextField * codeTF;
//@property (nonatomic, strong) UIButton * codeButton;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIButton * forgetPassWordButton;

@end

@implementation LoginVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatLoginView];
}

#pragma mark - Custom Accessors (控件响应方法)

- (void)rightBarButtonClicked
{
    //注册
    RegisterVC * vc = [[RegisterVC alloc] init];
    ZLNaviContrViewController * nav = [[ZLNaviContrViewController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)codeButtonClicked:(UIButton *)button
{
    //发送验证码
    button.countDownFormat = @"%ds重试";
    [button countDownWithTimeInterval:60];
}

- (void)loginButtonClicked
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    //登录  username,password code均不能为空
    int comparisonResult = [self compareDate:dateString withDate:@"2018-05-10"];
    if(comparisonResult <0)
    {
        return;
    }
    
    //登录  username,password code均不能为空
    if (![NSString isMobile:self.phoneTF.text])
    {
        [MBProgressHUD showInfoMessage:@"请输入正确的手机号码"];
        return;
    }
    if (![NSString isPassword:self.passWordTF.text])
    {
        [MBProgressHUD showInfoMessage:@"请输入格式正确的密码"];
        return;
    }
    
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:self.phoneTF.text forKey:@"phone"];
    [parametersDic setObject:self.passWordTF.text forKey:@"password"];
    
    [PPNetworkHelper POST:@"/user/login/" parameters:parametersDic hudString:@"登录中..." success:^(id responseObject)
     {
        UserModel * model = [[UserModel alloc] initWithDictionary:[responseObject objectForKey:@"user"]];
         model.token = [responseObject objectForKey:@"token"];
         model.message = [NSArray arrayWithArray:[responseObject objectForKey:@"message"]];
         
         NSTimeInterval time=[model.birthday doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
         NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
         //设定时间格式,这里可以设置成自己需要的格式
         [dateFormatter setDateFormat:@"yyyy-MM-dd"];
         NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
        
         model.birthday = currentDateStr;
         
        [[UserSignData share] storageData:model];
         
        [[AppDelegate delegate] goHome];

    } failure:^(NSString *error)
    {
        [MBProgressHUD showErrorMessage:error];
    }];
}

- (void)forgetPassWordButtonClicked
{
    //忘记密码
    ForgetPasswordVC * vc = [[ForgetPasswordVC alloc] init];
    ZLNaviContrViewController * nav = [[ZLNaviContrViewController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - IBActions(xib响应方法)

- (IBAction)QQLogin:(id)sender
{
    //QQ
    
}

- (IBAction)WXLogin:(id)sender
{
    //微醺
}

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)

- (void)creatLoginView
{
//    self.phoneTF.text = @"18980623464";
//    self.passWordTF.text = @"123123";
    
    self.title = @"登录";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightBarButtonClicked) title:@"注册"];
    
    [self.view sd_addSubviews:@[self.passWordTF, self.phoneTF, self.loginButton]];
    
    self.passWordTF.sd_layout
    .centerYEqualToView(self.view)
    .centerXEqualToView(self.view)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.passWordTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.phoneTF.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.passWordTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.phoneTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
//    self.codeTF.sd_layout
//    .centerXEqualToView(self.view)
//    .topSpaceToView(self.passWordTF, 15)
//    .widthIs(SCREEN_WIDTH * 2/3)
//    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
//    self.codeTF.sd_cornerRadiusFromHeightRatio = @(0.5);
//
//    self.codeButton.sd_layout
//    .rightEqualToView(self.codeTF)
//    .topEqualToView(self.codeTF)
//    .widthIs(SCREEN_WIDTH * 2/3 * 130 / 400)
//    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
//    self.codeButton.sd_cornerRadiusFromHeightRatio = @(0.5);
//
//    makView.sd_layout
//    .leftEqualToView(self.codeButton)
//    .topEqualToView(self.codeTF)
//    .widthIs(SCREEN_WIDTH * 2/3 * 130 / 400 - 40)
//    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    
    self.loginButton.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.passWordTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.loginButton.sd_cornerRadiusFromHeightRatio = @(0.5);
    
//    self.forgetPassWordButton.sd_layout
//    .centerXEqualToView(self.view)
//    .topSpaceToView(self.loginButton, 0)
//    .widthIs(100)
//    .heightIs(40);
//    self.forgetPassWordButton.sd_cornerRadiusFromHeightRatio = @(0.5);

}


#pragma mark - Deletate/DataSource (相关代理)


#pragma mark - Setter/Getter

- (UITextField *)phoneTF
{
    if (!_phoneTF)
    {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.placeholder = @"用户名/手机号";
        _phoneTF.font = [UIFont systemFontOfSize:15];
        _phoneTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _phoneTF.layer.borderWidth = 1;
        _phoneTF.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneTF;
}

- (UITextField *)passWordTF
{
    if (!_passWordTF)
    {
        _passWordTF = [[UITextField alloc] init];
        _passWordTF.placeholder = @"用户密码";
        _passWordTF.font = [UIFont systemFontOfSize:15];
        _passWordTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _passWordTF.layer.borderWidth = 1;
        _passWordTF.textAlignment = NSTextAlignmentCenter;
        [_passWordTF setSecureTextEntry:YES];
    }
    return _passWordTF;
}

//- (UITextField *)codeTF
//{
//    if (!_codeTF)
//    {
//        _codeTF = [[UITextField alloc] init];
//        _codeTF.font = [UIFont systemFontOfSize:15];
//        _codeTF.layer.borderColor = [UIColor colorWithHexString:@"fad448"].CGColor;
//        _codeTF.layer.borderWidth = 1;
//        _codeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 0)];
//        _codeTF.leftViewMode = UITextFieldViewModeAlways;
//    }
//    return _codeTF;
//}
//
//- (UIButton *)codeButton
//{
//    if (!_codeButton)
//    {
//        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
//        [_codeButton setTitle:@"验证码" forState: UIControlStateNormal];
//        [_codeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _codeButton.backgroundColor = [UIColor colorWithHexString:@"fad448"];
//        [_codeButton addTarget:self action:@selector(codeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _codeButton;
//}

- (UIButton *)loginButton
{
    if (!_loginButton)
    {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginButton setTitle:@"立即登录" forState: UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor mainColor];
        [_loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)forgetPassWordButton
{
    if (!_forgetPassWordButton)
    {
        _forgetPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetPassWordButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_forgetPassWordButton setTitle:@"忘记密码" forState: UIControlStateNormal];
        [_forgetPassWordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_forgetPassWordButton addTarget:self action:@selector(forgetPassWordButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPassWordButton;
}

//比较两个日期大小
-(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{
    
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:startDate];
    date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
    NSLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}

@end
