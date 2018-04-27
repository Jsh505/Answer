//
//  StartExaminationVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/3/9.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "StartExaminationVC.h"
#import "AnswerTitleCell.h"
#import "AnswerImageCell.h"
#import "AnswerOptionCell.h"
#import <SDWebImageManager.h>

@interface StartExaminationVC ()
{
    int _index;  //当前题目
    NSString * _answerStr;
}

@property (nonatomic, strong) QuestionsModel *  questionsModel;

@property (nonatomic, strong) NSDictionary * answerDic;
@property (nonatomic, strong) NSMutableArray * myAnswerArray;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property (nonatomic, strong) UILabel * timeLB;
@property (nonatomic, strong) NSTimer * countDownTimer;

@end

@implementation StartExaminationVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"左右滑动切换题目";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(commitAnswer) title:@"提交"];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_SafeBottomMargin);
    self.coustromTableView.bounces = NO;
    
    self.answerDic = @{@"1":@"A",
                       @"2":@"B",
                       @"3":@"C",
                       @"4":@"D",
                       @"5":@"E",
                       @"6":@"F"
                       };
    _index = 0;
    [self loadData];
    [self.view addSubview:self.coustromTableView];
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    [self.view addSubview:self.timeLB];
    
    //倒计时
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
    //设置倒计时显示的时间
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",_secondsCountDown/3600];//时
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_secondsCountDown%3600)/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_secondsCountDown%60];//秒
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    self.timeLB.text = format_time;
    
    [self getAnswer];
}

- (void)loadData
{
    self.questionsModel = self.model.questions[_index];
    if ([self.questionsModel.questions_type isEqualToString:@"单选题"])
    {
        self.myAnswerArray = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0"]];
    }
    else
    {
        self.myAnswerArray = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0"]];
        
    }
    if (_answerStr)
    {
        NSMutableArray * values = [[NSMutableArray alloc] initWithArray:[self.answerDic allValues]];
        [values sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
         {
             return [obj1 compare:obj2];
         }];
        
        NSArray * answerArr = [_answerStr componentsSeparatedByString:@","];
        for (NSString * a in values)
        {
            for (NSString * b in answerArr)
            {
                if ([a isEqualToString:b])
                {
                    NSUInteger index = [values indexOfObject:a];
                    [self.myAnswerArray setObject:@"1" atIndexedSubscript:index];
                }
            }
        }
    }
}

-(void) countDownAction
{
    //倒计时-1
    _secondsCountDown--;
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",_secondsCountDown/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_secondsCountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_secondsCountDown%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    //修改倒计时标签现实内容
    self.timeLB.text = format_time;
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDown==0){
        [self.countDownTimer invalidate];
    }
}

#pragma mark - Custom Accessors (控件响应方法)

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (_index < self.model.questions.count)
        {
            [MBProgressHUD showInfoMessage:@"下一题"];
            _index ++;
        }
        else
        {
            [MBProgressHUD showInfoMessage:@"最后一题了"];
        }
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (_index > 0)
        {
            [MBProgressHUD showInfoMessage:@"上一题"];
            _index --;
        }
        else
        {
            [MBProgressHUD showInfoMessage:@"已经是第一题了"];
        }
    }
    [self getAnswer];
}

- (NSString *)getNowAnwser
{
    //获取当前答案
    NSString * answerArr = @"";
    for (int i = 0; i < self.myAnswerArray.count; i ++)
    {
        if ([self.myAnswerArray[i] isEqualToString:@"1"])
        {
            answerArr = [answerArr stringByAppendingString:[NSString stringWithFormat:@",%@",[self.answerDic objectForKey:[NSString stringWithFormat:@"%d",i + 1]]]];
        }
    }
    if (answerArr.length > 0)
    {
        return [answerArr substringFromIndex:1];
    }
    else
    {
        return @"";
    }
}

- (void)submitAnswer
{
    //提交答案
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    [parametersDic setObject:self.questionsModel.questions_id forKey:@"questions_id"];
    [parametersDic setObject:[self getNowAnwser] forKey:@"user_answer"];
    
    [PPNetworkHelper POST:@"/online/online_questions_submit/" parameters:parametersDic hudString:nil success:^(id responseObject)
     {
     } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
     }];
}

- (void)getAnswer
{
    QuestionsModel * newModel = self.model.questions[_index];
    //获取答题
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    [parametersDic setObject:newModel.questions_id forKey:@"questions_id"];
    
    [PPNetworkHelper POST:@"/online/online_questions_info/" parameters:parametersDic hudString:nil success:^(id responseObject)
     {
         _answerStr = [responseObject objectForKey:@"user_answer"];
         [self loadData];
         [self.coustromTableView reloadData];
         [self.coustromTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } failure:^(NSString *error)
     {
    }];
}

- (void)commitAnswer
{
    //提交完成答题
    
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    
    [PPNetworkHelper POST:@"/online/online_unit_submit_one/" parameters:parametersDic hudString:nil success:^(id responseObject)
     {
         NSString * message = @"";
         
         if (responseObject)
         {
             for (NSString * str in [responseObject objectForKey:@"withoutArr"])
             {
                 message = [message stringByAppendingString:[NSString stringWithFormat:@"%@ ",str]];
             }
             message = [NSString stringWithFormat:@"还有未完成的题目:\n%@\n是否确认提交，提交之后将不能继续答题!",message];
         }
         else
         {
             message = [NSString stringWithFormat:@"是否确认提交，提交之后将不能继续答题!"];
         }
         
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
         
         [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             //点击按钮的响应事件；
             [PPNetworkHelper POST:@"/online/online_unit_submit_two/" parameters:parametersDic hudString:nil success:^(id responseObject) {
                 [MBProgressHUD showInfoMessage:@"考试完成"];
                 [self.navigationController popViewControllerAnimated:YES];
             } failure:^(NSString *error) {
                 [MBProgressHUD showErrorMessage:error];
             }];
         }]];
         [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
         //弹出提示框；
         [self presentViewController:alert animated:true completion:nil];
     } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
     }];
}

#pragma mark - IBActions(xib响应方法)


#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.questionsModel.questions_type isEqualToString:@"单选题"])
    {
        return 6;
        
    }
    else
    {
        return 8;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 80;
        return tableView.rowHeight;
    }
    else if (indexPath.row == 1)
    {
        if ([NSString is_NulllWithObject:self.questionsModel.questions_img])
        {
            return 0;
        }
        else
        {
            UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.questionsModel.questions_img];
            if (!img) {
                img =  [UIImage imageNamed:@"占位图"];
            }
            CGFloat height = img.size.height;
            return (height/img.size.width)*SCREEN_WIDTH;
        }
    }
    else
    {
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 60;
        return tableView.rowHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        AnswerTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerTitleCellident"];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"AnswerTitleCell" owner:nil options:nil];
            cell = array[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.questionsModel;
        cell.questionNum.text = [NSString stringWithFormat:@"%d",_index + 1];
        cell.numLB.text = [NSString stringWithFormat:@"/%ld",self.model.questions.count];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        AnswerImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerImageCellident"];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"AnswerImageCell" owner:nil options:nil];
            cell = array[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self confirmCell:cell atIndexPath:indexPath];
        return cell;
    }
    else
    {
        AnswerOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerOptionCellident"];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"AnswerOptionCell" owner:nil options:nil];
            cell = array[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.titleLB.text = [self.answerDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row - 1]];
        switch (indexPath.row - 1)
        {
            case 1:
                cell.infoLB.text = self.questionsModel.answer_A;
                break;
            case 2:
                cell.infoLB.text = self.questionsModel.answer_B;
                break;
            case 3:
                cell.infoLB.text = self.questionsModel.answer_C;
                break;
            case 4:
                cell.infoLB.text = self.questionsModel.answer_D;
                break;
            case 5:
                cell.infoLB.text = self.questionsModel.answer_E;
                break;
            case 6:
                cell.infoLB.text = self.questionsModel.answer_F;
                break;
            default:
                break;
        }
        cell.isSelected = [[self.myAnswerArray objectAtIndex:indexPath.row - 2] isEqualToString:@"1"];
        return cell;
    }
}

- (void)confirmCell:(AnswerImageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    QuestionsModel * model = self.model.questions[_index];
    NSString *imgUrl = model.questions_img;
    UIImage *cachedImg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgUrl];
    if (!cachedImg)
    {
        [self downloadImage:imgUrl forIndexPath:indexPath];
    }
    else
    {
        cell.questionImageView.image  = cachedImg;
    }
}
- (void)downloadImage:(NSString *)imageURL forIndexPath:(NSIndexPath *)indexPath
{
    QuestionsModel * model = self.model.questions[_index];
    __weak typeof(self) weakSelf = self;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.questions_img] options:2 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished)
     {
         [[SDImageCache sharedImageCache] storeImage:image forKey:model.questions_img completion:nil];
         [weakSelf.coustromTableView reloadData];
     }];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.questionsModel.questions_type isEqualToString:@"单选题"])
    {
        if (indexPath.row >= 2 && indexPath.row < 6)
        {
            self.myAnswerArray = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0"]];
            if ([[self.myAnswerArray objectAtIndex:indexPath.row - 2] intValue] == 0)
            {
                [self.myAnswerArray setObject:@"1" atIndexedSubscript:indexPath.row - 2];
            }
            else
            {
                [self.myAnswerArray setObject:@"0" atIndexedSubscript:indexPath.row - 2];
            }
        }
        [self.coustromTableView reloadData];
    }
    else
    {
        if (indexPath.row >= 2 && indexPath.row < 9)
        {
            if ([[self.myAnswerArray objectAtIndex:indexPath.row - 2] intValue] == 0)
            {
                [self.myAnswerArray setObject:@"1" atIndexedSubscript:indexPath.row - 2];
            }
            else
            {
                [self.myAnswerArray setObject:@"0" atIndexedSubscript:indexPath.row - 2];
            }
        }
        [self.coustromTableView reloadData];
    }
    
    //提交答案
    [self submitAnswer];
}


#pragma mark - Setter/Getter

- (UILabel *)timeLB
{
    if (!_timeLB)
    {
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80) / 2, 7, 80, 25)];
        _timeLB.text = @"01:48:00";
        _timeLB.textAlignment = NSTextAlignmentCenter;
        _timeLB.textColor = [UIColor whiteColor];
        _timeLB.font = [UIFont systemFontOfSize:13];
        _timeLB.backgroundColor = [UIColor mainColor];
    }
    return _timeLB;
}

@end
