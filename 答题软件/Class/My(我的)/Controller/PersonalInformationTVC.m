//
//  PersonalInformationTVC.m
//  笑园之窗
//
//  Created by 贾仕海 on 2018/1/2.
//  Copyright © 2018年 xyzc. All rights reserved.
//

#import "PersonalInformationTVC.h"
#import "LDImagePicker.h"
#import "LZCityPickerController.h"
#import "ChangeNameVC.h"

@interface PersonalInformationTVC () <LDImagePickerDelegate>
{
    NSString * _headeImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *grdenLB;
@property (weak, nonatomic) IBOutlet UILabel *cityLB;
@property (weak, nonatomic) IBOutlet UILabel *birthLB;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) UIView * grdenChoseView;

@property (nonatomic, strong) UIView * masView;
@property (nonatomic, strong) UIDatePicker * datePicker;
@end

@implementation PersonalInformationTVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
    [self upView];
}


#pragma mark - Custom Accessors (控件响应方法)

- (void)dateChanged:(UIDatePicker *)datePicker
{
    NSDate* date = datePicker.date;
    //添加你自己响应代码
    NSLog(@"dateChanged响应事件：%@",date);
    
    //NSDate格式转换为NSString格式
    NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    //打印显示日期时间
    self.birthLB.text = dateString;
}

- (void)closegrdenChoseView
{
    [self.grdenChoseView removeFromSuperview];
}

- (void)girlbuttonClicked
{
    [self closegrdenChoseView];
}

- (void)boybuttonClicked
{
    [self closegrdenChoseView];
}

#pragma mark - IBActions(xib响应方法)


#pragma mark - Public (.h 公共调用方法)



#pragma mark - Private (.m 私有方法)

- (void)upView
{
    
}

- (void)showView
{
    [self.masView addToWindow];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.masView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)closeView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.masView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        [self.masView removeFromSuperview];
        
    }];
}

#pragma mark - Deletate/DataSource (相关代理)

- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}

- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage
{
    //上传图片
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    [PPNetworkHelper uploadWithURL:@"uploadPicture.app" parameters:nil images:@[editedImage] name:@"pictureName" fileName:timeString mimeType:@"png" hudString:@"上传中..." progress:^(NSProgress *progress) {
        
    } success:^(id responseObject)
     {
         self.headerImage.image = editedImage;
         _headeImage = [responseObject objectForKey:@"pictureName"][0];
         
     } failure:^(NSString *error)
     {
         [MBProgressHUD showInfoMessage:error];
     }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

#pragma mark --UItableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    if (sec == 0 && row == 0)
    {
        //头像
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
    else if (sec == 0 && row == 1)
    {
        //昵称
        ChangeNameVC * vc = [[ChangeNameVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (sec == 0 && row == 2)
    {
        //性别
        [self.grdenChoseView addToWindow];
    }
    else if (sec == 1 && row == 0)
    {
        //生日
        [self showView];
    }
    else if (sec == 1 && row == 1)
    {
        //城市
        [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
            
            // 选择结果回调
            self.cityLB.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
            NSLog(@"%@--%@--%@--%@",address,province,city,area);
            
        }];
    }
    
}


#pragma mark - Setter/Getter

- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216 - JSH_SafeBottomMargin, SCREEN_WIDTH, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];//重点：UIControlEventValueChanged
        
        //设置显示格式
        //默认根据手机本地设置显示为中文还是其他语言
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        _datePicker.locale = locale;
        
    }
    return _datePicker;
}

- (UIView *)masView
{
    if (!_masView)
    {
        _masView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _masView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [_masView addGestureRecognizer:singleRecognizer];
        [_masView addSubview:self.datePicker];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216 - JSH_SafeBottomMargin - 40, SCREEN_WIDTH, 40)];
        titleLabel.text = @"选择时间";
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor mainColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        [_masView addSubview:titleLabel];
        
        UILabel * sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, SCREEN_HEIGHT - 216 - JSH_SafeBottomMargin - 40, 40, 40)];
        sureLabel.text = @"确定";
        sureLabel.textAlignment = NSTextAlignmentCenter;
        sureLabel.textColor = [UIColor colorWithHexString:@"333333"];
        sureLabel.font = [UIFont systemFontOfSize:15];
        [_masView addSubview:sureLabel];
    }
    return _masView;
}

- (UIView *)grdenChoseView
{
    if (!_grdenChoseView)
    {
        _grdenChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _grdenChoseView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.3f];
        
        UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closegrdenChoseView)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [_grdenChoseView addGestureRecognizer:singleRecognizer];
        
        UIView * choseView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 170) / 2, (SCREEN_HEIGHT - 200) / 2, 170, 200)];
        choseView.backgroundColor = [UIColor whiteColor];
        choseView.layer.cornerRadius = 5;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 170, 40)];
        label.text = @"选择性别";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:17];
        [choseView addSubview:label];
        
        UIButton * girlbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        girlbutton.frame = CGRectMake(0, 40, 170, 80);
        girlbutton.titleLabel.font = [UIFont systemFontOfSize:17];
        [girlbutton setImage:[UIImage imageNamed:@"个人中心女"] forState:UIControlStateNormal];
        [girlbutton setTitle:@" 女" forState: UIControlStateNormal];
        [girlbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        girlbutton.backgroundColor = [UIColor clearColor];
        [girlbutton addTarget:self action:@selector(girlbuttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [choseView addSubview:girlbutton];
        
        UIButton * boybutton = [UIButton buttonWithType:UIButtonTypeCustom];
        boybutton.frame = CGRectMake(0, 120, 170, 80);
        boybutton.titleLabel.font = [UIFont systemFontOfSize:17];
        [boybutton setImage:[UIImage imageNamed:@"个人中心男"] forState:UIControlStateNormal];
        [boybutton setTitle:@" 男" forState: UIControlStateNormal];
        [boybutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        boybutton.backgroundColor = [UIColor clearColor];
        [boybutton addTarget:self action:@selector(boybuttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [choseView addSubview:boybutton];
        
        [_grdenChoseView addSubview:choseView];
        
        
    }
    return _grdenChoseView;
}

@end

