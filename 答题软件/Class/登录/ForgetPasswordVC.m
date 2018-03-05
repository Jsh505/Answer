//
//  ForgetPasswordVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/24.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "ForgetPasswordVC.h"

@interface ForgetPasswordVC ()

@property (nonatomic, strong) UITextField * phoneTF;
@property (nonatomic, strong) UITextField * passWordTF;
@property (nonatomic, strong) UITextField * refundPassWordTF;
@property (nonatomic, strong) UITextField * codeTF;
@property (nonatomic, strong) UIButton * codeButton;
@property (nonatomic, strong) UIButton * loginButton;

@end

@implementation ForgetPasswordVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatLoginView];
}

#pragma mark - Custom Accessors (控件响应方法)

- (void)rightBarButtonClicked
{
    //注册
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)codeButtonClicked:(UIButton *)button
{
    //发送验证码
    button.countDownFormat = @"%ds重试";
    [button countDownWithTimeInterval:60];
}

- (void)loginButtonClicked
{
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
    if (![self.passWordTF.text isEqualToString:self.refundPassWordTF.text])
    {
        [MBProgressHUD showInfoMessage:@"请输入相同的密码"];
        return;
    }
    
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:self.phoneTF.text forKey:@"phone"];
    [parametersDic setObject:self.passWordTF.text forKey:@"password"];
    
    [PPNetworkHelper POST:@"/user/replacement/" parameters:parametersDic hudString:@"登录中..." success:^(id responseObject)
     {
         [MBProgressHUD showInfoMessage:@"找回成功"];
         [self dismissViewControllerAnimated:YES completion:nil];
         
     } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
     }];
}

- (void)forgetPassWordButtonClicked
{
    
}

#pragma mark - IBActions(xib响应方法)

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)

- (void)creatLoginView
{
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightBarButtonClicked) title:@"登录"];
    
    UIView * makView = [[UIView alloc] init];
    makView.backgroundColor = [UIColor mainColor];
    
    [self.view sd_addSubviews:@[self.passWordTF, self.refundPassWordTF, self.phoneTF, self.codeTF, makView, self.codeButton, self.loginButton]];
    
    self.codeTF.sd_layout
    .centerYEqualToView(self.view)
    .centerXEqualToView(self.view)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.codeTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.codeButton.sd_layout
    .rightEqualToView(self.codeTF)
    .topEqualToView(self.codeTF)
    .widthIs(SCREEN_WIDTH * 2/3 * 130 / 400)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.codeButton.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    makView.sd_layout
    .leftEqualToView(self.codeButton)
    .topEqualToView(self.codeTF)
    .widthIs(SCREEN_WIDTH * 2/3 * 130 / 400 - 40)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    
    self.phoneTF.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.codeTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.phoneTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.passWordTF.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.codeTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.passWordTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.refundPassWordTF.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.passWordTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.refundPassWordTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.loginButton.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.refundPassWordTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.loginButton.sd_cornerRadiusFromHeightRatio = @(0.5);
    
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
        _passWordTF.placeholder = @"更新设置密码";
        _passWordTF.font = [UIFont systemFontOfSize:15];
        _passWordTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _passWordTF.layer.borderWidth = 1;
        _passWordTF.textAlignment = NSTextAlignmentCenter;
        [_passWordTF setSecureTextEntry:YES];
    }
    return _passWordTF;
}

- (UITextField *)refundPassWordTF
{
    if (!_refundPassWordTF)
    {
        _refundPassWordTF = [[UITextField alloc] init];
        _refundPassWordTF.placeholder = @"再次输入密码";
        _refundPassWordTF.font = [UIFont systemFontOfSize:15];
        _refundPassWordTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _refundPassWordTF.layer.borderWidth = 1;
        _refundPassWordTF.textAlignment = NSTextAlignmentCenter;
        [_refundPassWordTF setSecureTextEntry:YES];
    }
    return _refundPassWordTF;
}

- (UITextField *)codeTF
{
    if (!_codeTF)
    {
        _codeTF = [[UITextField alloc] init];
        _codeTF.font = [UIFont systemFontOfSize:15];
        _codeTF.layer.borderColor = [UIColor mainColor].CGColor;
        _codeTF.layer.borderWidth = 1;
        _codeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 0)];
        _codeTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _codeTF;
}

- (UIButton *)codeButton
{
    if (!_codeButton)
    {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_codeButton setTitle:@"验证码" forState: UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _codeButton.backgroundColor = [UIColor mainColor];
        [_codeButton addTarget:self action:@selector(codeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeButton;
}

- (UIButton *)loginButton
{
    if (!_loginButton)
    {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginButton setTitle:@"确 定" forState: UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor mainColor];
        [_loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}



@end
