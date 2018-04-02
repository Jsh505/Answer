//
//  TestResultInfoVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/3/15.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "TestResultInfoVC.h"
#import "AnswerTitleCell.h"
#import "AnswerImageCell.h"
#import "AnswerOptionCell.h"
#import <SDWebImageManager.h>
#import "AnswerFooterView.h"

@interface TestResultInfoVC ()
{
    CGFloat _footerHight;
}

@property (nonatomic, strong) QuestionsModel *  questionsModel;

@property (nonatomic, strong) NSDictionary * answerDic;
@property (nonatomic, strong) NSMutableArray * myAnswerArray;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end

@implementation TestResultInfoVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"答题详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_SafeBottomMargin);
    
    self.answerDic = @{@"1":@"A",
                       @"2":@"B",
                       @"3":@"C",
                       @"4":@"D",
                       @"5":@"E",
                       @"6":@"F"
                       };
    [self loadData];
    [self.view addSubview:self.coustromTableView];
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
}

- (void)loadData
{
    self.questionsModel = self.dataSource[self.index];
    if ([self.questionsModel.questions_type isEqualToString:@"单选题"])
    {
        self.myAnswerArray = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0"]];
    }
    else
    {
        self.myAnswerArray = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0"]];
    }
    
    if (self.questionsModel.answer)
    {
        NSMutableArray * values = [[NSMutableArray alloc] initWithArray:[self.answerDic allValues]];
        [values sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
         {
             return [obj1 compare:obj2];
         }];
        
        NSArray * answerArr = [self.questionsModel.answer componentsSeparatedByString:@","];
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

#pragma mark - Custom Accessors (控件响应方法)

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (self.index < self.dataSource.count - 1)
        {
            self.index ++;
            [self loadData];
            [self.coustromTableView reloadData];
            [MBProgressHUD showInfoMessage:@"下一题"];
            [self.coustromTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        else
        {
            [MBProgressHUD showInfoMessage:@"最后一题了"];
        }
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (self.index > 0)
        {
            self.index --;
            [self loadData];
            [self.coustromTableView reloadData];
            [MBProgressHUD showInfoMessage:@"上一题"];
            [self.coustromTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        else
        {
            [MBProgressHUD showInfoMessage:@"已经是第一题了"];
        }
        
    }
    
}

#pragma mark - IBActions(xib响应方法)

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    AnswerFooterView * view = [AnswerFooterView loadViewFromXIB];
    view.answerLB.text = self.questionsModel.answer;
    view.infoLB.text = self.questionsModel.answer_info;
    
    view.yourAnswerLB.text = self.questionsModel.user_answer;
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, _footerHight);
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _footerHight;
    
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
        cell.questionNum.text = [NSString stringWithFormat:@"%d",self.index + 1];
        cell.numLB.text = [NSString stringWithFormat:@"/%ld",self.dataSource.count];
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
    QuestionsModel * model = self.dataSource[indexPath.row - 1];
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
    QuestionsModel * model = self.dataSource[indexPath.row];
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
    
}


#pragma mark - Setter/Getter

@end
