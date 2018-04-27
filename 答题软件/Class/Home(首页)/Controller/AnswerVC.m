//
//  AnswerVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "AnswerVC.h"
#import "AnswerTitleCell.h"
#import "AnswerImageCell.h"
#import "AnswerOptionCell.h"
#import "AnswerCardVC.h"
#import "TestResultVC.h"
#import "ErrorCorrectionView.h"
#import <SDWebImageManager.h>
#import "AnswerFooterView.h"

@interface AnswerVC ()
{
    int _index;  //当前题目
    BOOL _isShowAnswer;  //是否显示答案
    BOOL _isCllocet;  //是否收藏
    CGFloat _footerHight;
}

@property (nonatomic, strong) ErrorCorrectionView * errorCorrectionView;
@property (nonatomic, strong) QuestionsModel *  questionsModel;

@property (nonatomic, strong) NSDictionary * answerDic;
@property (nonatomic, strong) NSMutableArray * myAnswerArray;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end

@implementation AnswerVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"左右滑动切换题目";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(Collection) image:@"收藏" highImage:@"收藏"];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_SafeBottomMargin - 55);

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
    
    [self searchCollectStatus];
    
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
    
    //获取解析高度
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.text = self.questionsModel.answer_info;
    textLabel.numberOfLines = 0;//根据最大行数需求来设置
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(SCREEN_WIDTH - 20, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    _footerHight = 70 + expectSize.height;
}

- (void)searchCollectStatus
{
    //查询收藏状态
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    [parametersDic setObject:self.questionsModel.questions_id forKey:@"question_id"];
    
    [PPNetworkHelper POST:@"/exam/collect_info/" parameters:parametersDic hudString:nil success:^(id responseObject)
     {
         if (responseObject)
         {
             self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(Collection) image:@"已收藏" highImage:@"已收藏"];
             _isCllocet = YES;
         }
         else
         {
             _isCllocet = NO;
             self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(Collection) image:@"收藏" highImage:@"收藏"];
         }
     } failure:^(NSString *error)
     {
         _isCllocet = NO;
         self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(Collection) image:@"收藏" highImage:@"收藏"];
     }];
}

#pragma mark - Custom Accessors (控件响应方法)

- (void)Collection
{
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    [parametersDic setObject:self.questionsModel.questions_id forKey:@"question_id"];
    if (_isCllocet)
    {
        //取消收藏
        [PPNetworkHelper POST:@"/exam/collect_off/" parameters:parametersDic hudString:nil success:^(id responseObject)
         {
             self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(Collection) image:@"收藏" highImage:@"收藏"];
             _isCllocet = NO;
         } failure:^(NSString *error)
         {
             [MBProgressHUD showErrorMessage:error];
         }];
    }
    else
    {
        //收藏
        [PPNetworkHelper POST:@"/exam/collect_submit/" parameters:parametersDic hudString:nil success:^(id responseObject)
         {
             self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(Collection) image:@"已收藏" highImage:@"已收藏"];
             _isCllocet = YES;
         } failure:^(NSString *error)
         {
             [MBProgressHUD showErrorMessage:error];
         }];
    }
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (_index < self.model.questions.count - 1)
        {
            _index ++;
            _isShowAnswer = NO;
            [self loadData];
            [self.coustromTableView reloadData];
            [MBProgressHUD showInfoMessage:@"下一题"];
            [self.coustromTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [self searchCollectStatus];
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
            _index --;
            [self loadData];
            _isShowAnswer = NO;
            [self.coustromTableView reloadData];
            [MBProgressHUD showInfoMessage:@"上一题"];
            [self.coustromTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [self searchCollectStatus];
        }
        else
        {
            [MBProgressHUD showInfoMessage:@"已经是第一题了"];
        }
        
    }
    
}

#pragma mark - IBActions(xib响应方法)

- (IBAction)answerCade:(id)sender
{
    //答题卡
    AnswerCardVC * vc = [[AnswerCardVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)LookAtParsing:(id)sender
{
    //看解析
    _isShowAnswer = !_isShowAnswer;
    [self.coustromTableView reloadData];
    [self.coustromTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (IBAction)Submit:(id)sender
{
    //提交
    TestResultVC * vc = [[TestResultVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)errorCorrection:(id)sender
{
    //纠错
    [self.errorCorrectionView showWithView:self.view];
}

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    AnswerFooterView * view = [AnswerFooterView loadViewFromXIB];
    view.answerLB.text = self.questionsModel.answer;
    view.infoLB.text = self.questionsModel.answer_info;
    
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
        answerArr = [answerArr substringFromIndex:1];
    }
    view.yourAnswerLB.text = answerArr;
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, _footerHight);
    
    if (![answerArr isEqualToString:self.questionsModel.answer])
    {
        //提交错题
        NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
        [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
        [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
        [parametersDic setObject:self.questionsModel.questions_id forKey:@"question_id"];
        
        [PPNetworkHelper POST:@"/exam/wrong_submit/" parameters:parametersDic hudString:nil success:^(id responseObject)
         {
         } failure:^(NSString *error)
         {
         }];
        
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_isShowAnswer)
    {
        return _footerHight;
    }
    else
    {
        return 0;
    }
    
}

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
    QuestionsModel * model = self.model.questions[indexPath.row - 1];
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
    QuestionsModel * model = self.model.questions[indexPath.row];
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
    if (_isShowAnswer)
    {
        return;
    }
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
}


#pragma mark - Setter/Getter

- (ErrorCorrectionView *)errorCorrectionView
{
    if (!_errorCorrectionView)
    {
        _errorCorrectionView = [[ErrorCorrectionView alloc] initWithFrame:self.view.bounds];
        _errorCorrectionView.delegate = self;
    }
    return _errorCorrectionView;
}

@end
