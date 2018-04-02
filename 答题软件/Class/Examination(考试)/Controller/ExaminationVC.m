//
//  ExaminationVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/13.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "ExaminationVC.h"
#import "StartExaminationVC.h"
#import "QuestionsInfoModel.h"
#import "QuestionsModel.h"

@interface ExaminationVC ()
{
    NSInteger _time;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *unit_fullLB;
@property (weak, nonatomic) IBOutlet UILabel *unit_passLB;
@property (weak, nonatomic) IBOutlet UILabel *unit_durationLB;
@property (weak, nonatomic) IBOutlet UILabel *infoLB;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@property (nonatomic, strong) QuestionsInfoModel * model;

@end

@implementation ExaminationVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData
{
    [PPNetworkHelper GET:@"/online/online_Index/" parameters:nil hudString:@"获取中..." success:^(id responseObject)
    {
        self.titleLB.text = [responseObject objectForKey:@"unit"];
        self.startTimeLB.text = [NSString timeExchangeWithType:@"YYYY-MM-dd HH:mm:ss" timeString:[responseObject objectForKey:@"unit_time"]];
        self.unit_fullLB.text = [NSString stringWithFormat:@"%@分",[responseObject objectForKey:@"unit_full"]];
        self.unit_passLB.text = [NSString stringWithFormat:@"%@分",[responseObject objectForKey:@"unit_pass"]];
        self.unit_durationLB.text = [NSString stringWithFormat:@"%@分钟",[responseObject objectForKey:@"unit_duration"]];
        self.infoLB.text = [responseObject objectForKey:@"unit_info"];
        
        _time = [[responseObject objectForKey:@"unit_time"] integerValue] + [[responseObject objectForKey:@"unit_duration"] integerValue] * 60;
        
        
    } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
    }];
}

#pragma mark - Custom Accessors (控件响应方法)


#pragma mark - IBActions(xib响应方法)

- (IBAction)commitPassword:(id)sender
{
    if (self.passWordTF.text.length == 0)
    {
        [MBProgressHUD showInfoMessage:@"请输入考试密码"];
        return;
    }
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    [parametersDic setObject:self.passWordTF.text forKey:@"password"];
    
    [PPNetworkHelper POST:@"/online/online_start/" parameters:parametersDic hudString:nil success:^(id responseObject)
    {
        if (responseObject)
        {
            self.passWordTF.text = @"";
            self.model = [[QuestionsInfoModel alloc] initWithDictionary:responseObject];
            self.model.questions = [[NSMutableArray alloc] init];
            for (NSDictionary * dic in [responseObject objectForKey:@"questions"])
            {
                QuestionsModel * questionModel = [[QuestionsModel alloc] initWithDictionary:dic];
                [self.model.questions addObject:questionModel];
            }
            
            NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now =[date timeIntervalSince1970];
            
            StartExaminationVC * vc = [[StartExaminationVC alloc] init];
            vc.secondsCountDown = _time - now;
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [MBProgressHUD showErrorMessage:@"暂时无法参加考试"];
        }
    } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
    }];
}

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)


#pragma mark - Setter/Getter

@end
