//
//  RegisterVC.m
//  笑园之窗
//
//  Created by 贾仕海 on 2017/12/29.
//  Copyright © 2017年 xyzc. All rights reserved.
//

#import "RegisterVC.h"
#import "EBTAttributeLinkClickLabel.h"

@interface RegisterVC ()

@property (nonatomic, strong) UITextField * phoneTF;
@property (nonatomic, strong) UITextField * passWordTF;
@property (nonatomic, strong) UITextField * codeTF;
@property (nonatomic, strong) UIButton * codeButton;
@property (nonatomic, strong) UITextField * invitationCodeTF;
@property (nonatomic, strong) UIButton * registerButton;
@property (nonatomic, strong) EBTAttributeLinkClickLabel *lbl_Content;

@end

@implementation RegisterVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatRegisterView];
}

#pragma mark - Custom Accessors (控件响应方法)

- (void)rightBarButtonClicked
{
    //登录
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)codeButtonClicked:(UIButton *)button
{
    //发送验证码
    if (![NSString isMobile:self.phoneTF.text])
    {
        [MBProgressHUD showInfoMessage:@"请输入正确的手机号码"];
        return;
    }
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:self.phoneTF.text forKey:@"phone"];
    
    [PPNetworkHelper POST:@"sendSms.app" parameters:parametersDic hudString:@"获取中..." success:^(id responseObject)
     {
         [MBProgressHUD showInfoMessage:[responseObject objectForKey:@"msg"]];
         button.countDownFormat = @"%ds重试";
         [button countDownWithTimeInterval:60];
         
    } failure:^(NSString *error)
    {
        [MBProgressHUD showErrorMessage:error];
    }];
    
}

- (void)registerButtonClicked
{
    //注册     username，password 不能为空
    if (![NSString isMobile:self.phoneTF.text])
    {
        [MBProgressHUD showInfoMessage:@"请输入正确的手机号码"];
        return;
    }
//    if (self.codeTF.text.length != 6)
//    {
//        [MBProgressHUD showInfoMessage:@"请输入6位数的验证码"];
//        return;
//    }
    if (![NSString isPassword:self.passWordTF.text])
    {
        [MBProgressHUD showInfoMessage:@"请输入格式正确的密码"];;
        return;
    }
    
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:self.phoneTF.text forKey:@"phone"];
    [parametersDic setObject:self.passWordTF.text forKey:@"password"];
//    [parametersDic setObject:self.codeTF.text forKey:@"code"];
    
    [PPNetworkHelper POST:@"/user/register/" parameters:parametersDic hudString:@"注册中..." success:^(id responseObject)
     {
         [MBProgressHUD showInfoMessage:@"注册成功"];
         [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
    }];
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

- (void)creatRegisterView
{
    self.title = @"注册";
//    self.navigationController.lef
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightBarButtonClicked) title:@"登录"];
    
    UIView * makView = [[UIView alloc] init];
    makView.backgroundColor = [UIColor mainColor];
    
    [self.view sd_addSubviews:@[self.passWordTF, self.phoneTF, self.invitationCodeTF, self.lbl_Content, self.registerButton]];
    
    self.passWordTF.sd_layout
    .centerYEqualToView(self.view)
    .centerXEqualToView(self.view)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.passWordTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
//    self.codeTF.sd_layout
//    .centerXEqualToView(self.view)
//    .bottomSpaceToView(self.passWordTF, 15)
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
    
    self.phoneTF.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.passWordTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.phoneTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.invitationCodeTF.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.passWordTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.invitationCodeTF.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.lbl_Content.sd_layout
    .centerXEqualToView(self.invitationCodeTF)
    .topSpaceToView(self.invitationCodeTF, 15)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(20);
    
    self.registerButton.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.lbl_Content, 5)
    .widthIs(SCREEN_WIDTH * 2/3)
    .heightIs(SCREEN_WIDTH * 2/3 * 65/400);
    self.registerButton.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    
}


#pragma mark - Deletate/DataSource (相关代理)


#pragma mark - Setter/Getter

- (UITextField *)phoneTF
{
    if (!_phoneTF)
    {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.placeholder = @"输入手机号码";
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
        _passWordTF.placeholder = @"设置登录密码";
        _passWordTF.font = [UIFont systemFontOfSize:15];
        _passWordTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _passWordTF.layer.borderWidth = 1;
        _passWordTF.textAlignment = NSTextAlignmentCenter;
        [_passWordTF setSecureTextEntry:YES];
    }
    return _passWordTF;
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

- (UITextField *)invitationCodeTF
{
    if (!_invitationCodeTF)
    {
        _invitationCodeTF = [[UITextField alloc] init];
        _invitationCodeTF.placeholder = @"（可不填写）";
        _invitationCodeTF.font = [UIFont systemFontOfSize:15];
        _invitationCodeTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _invitationCodeTF.layer.borderWidth = 1;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        label.text = @"邀请码";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15];
        
        _invitationCodeTF.leftView = label;
        _invitationCodeTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _invitationCodeTF;
}

- (EBTAttributeLinkClickLabel *)lbl_Content
{
    if (!_lbl_Content)
    {
        _lbl_Content = [[EBTAttributeLinkClickLabel alloc] initWithFrame:CGRectZero];
        _lbl_Content.font = [UIFont systemFontOfSize:13];
        NSString *text = @"     注册即已阅读并同意得分王用户协议";
        __weak typeof(self)weakSelf = self;
        [_lbl_Content attributeLinkLabelText:text withLinksAttribute:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                                                                       NSForegroundColorAttributeName:[UIColor mainColor]}
                    withActiveLinkAttributes:nil withLinkClickCompleteHandler:^(NSInteger linkedURLTag)
         {
             __strong typeof(weakSelf)strongSelf = weakSelf;
             
         } withUnderLineTextString:@"",nil];
    }
    return _lbl_Content;
}

- (UIButton *)registerButton
{
    if (!_registerButton)
    {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_registerButton setTitle:@"立即注册" forState: UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerButton.backgroundColor = [UIColor mainColor];
        [_registerButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}


@end
