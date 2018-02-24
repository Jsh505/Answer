//
//  FeedbackVC.m
//  笑园之窗
//
//  Created by 贾仕海 on 2018/1/2.
//  Copyright © 2018年 xyzc. All rights reserved.
//

#import "FeedbackVC.h"
#import "LDImagePicker.h"

@interface FeedbackVC () <LDImagePickerDelegate>

@property (nonatomic, strong) UIButton * rightBarButton;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;


@end

@implementation FeedbackVC
#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的反馈";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightBarButtonClicked) title:@"提交"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.infoTextView.placeholder = @"请输入";
    self.infoTextView.limitLength = @(200);
}

#pragma mark - Custom Accessors (控件响应方法)


#pragma mark - IBActions(xib响应方法)

- (IBAction)photoButtonClicked:(id)sender
{
    //上传图片
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *openCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showImagePickerWithType:0 InViewController:self Scale:1];
    }];
    
    UIAlertAction *openAlbumAction = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showImagePickerWithType:1 InViewController:self Scale:1];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:openCameraAction];
    [alertController addAction:openAlbumAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)rightBarButtonClicked
{
    if (self.infoTextView.text.length == 0)
    {
        [MBProgressHUD showErrorMessage:@"内容不能为空"];
        return;
    }

    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:self.infoTextView.text forKey:@"qContent"];
    [parametersDic setObject:@([UserSignData share].user.userId) forKey:@"userId"];
    [parametersDic setObject:[UserSignData share].user.username forKey:@"userName"];
    
    [PPNetworkHelper POST:@"addQa.app" parameters:parametersDic hudString:@"反馈中..." success:^(id responseObject)
     {
        [MBProgressHUD showInfoMessage:@"反馈成功"];
         self.infoTextView.text = @"";
         [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error)
     {
        [MBProgressHUD showErrorMessage:error];
    }];
}
#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}

- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    
    //上传图片
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    
}

#pragma mark - Deletate/DataSource (相关代理)


#pragma mark - Setter/Getter



@end
