//
//  ExaminationInfoVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "ExaminationInfoVC.h"
#import "ExaminationTitleCell.h"
#import "ExaminationInfoCell.h"
#import "ExaminationOtherCell.h"
#import "AnswerVC.h"
#import "QuestionsModel.h"

@interface ExaminationInfoVC ()

@end

@implementation ExaminationInfoVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"模拟考试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.coustromTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_SafeBottomMargin - 55);
    
    [self.view addSubview:self.coustromTableView];
    
    if (!self.model)
    {
        [self loadData];
    }
}

- (void)loadData
{
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.localGroup forKey:@"group"];
    [parametersDic setObject:self.type forKey:@"group_type"];
    [parametersDic setObject:self.unit forKey:@"unit"];
    [parametersDic setObject:self.section forKey:@"section"];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    
    [PPNetworkHelper POST:@"/exam/section/" parameters:parametersDic hudString:@"加载中..." success:^(id responseObject)
    {
        self.model = [[QuestionsInfoModel alloc] initWithDictionary:responseObject];
        self.model.questions = [[NSMutableArray alloc] init];
        for (NSDictionary * dic in [responseObject objectForKey:@"questions"])
        {
            QuestionsModel * questionModel = [[QuestionsModel alloc] initWithDictionary:dic];
            [self.model.questions addObject:questionModel];
        }
        [self.coustromTableView reloadData];
    } failure:^(NSString *error)
    {
        [MBProgressHUD showErrorMessage:error];
    }];
}

#pragma mark - Custom Accessors (控件响应方法)


#pragma mark - IBActions(xib响应方法)

- (IBAction)starTest:(id)sender
{
    //模拟考试
    AnswerVC * vc = [[AnswerVC alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 50;
        return tableView.rowHeight;
    }
    else if (indexPath.row > 3)
    {
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 44;
        return tableView.rowHeight;
    }
    else
    {
        return 60;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ExaminationTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExaminationTitleCellident"];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ExaminationTitleCell" owner:nil options:nil];
            cell = array[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.titleLB.text = self.model.unit;
        return cell;
    }
    else if (indexPath.row > 3)
    {
        ExaminationOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExaminationOtherCellident"];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ExaminationOtherCell" owner:nil options:nil];
            cell = array[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        switch ((indexPath.row)) {
            case 4:
            {
                cell.titleLB.text = @"试卷介绍";
                cell.infoLB.text = self.model.section_info;
                break;
            }
            default:
                break;
        }
        return cell;
    }
    else
    {
        ExaminationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExaminationInfoCellident"];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ExaminationInfoCell" owner:nil options:nil];
            cell = array[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        switch (indexPath.row)
        {
            case 1:
            {
                cell.titleOneLB.text = @"年份";
                cell.titleTwoLB.text = @"试卷分数";
                cell.infoOneLB.text = self.model.section_year;
                cell.infoTwoLB.text = [NSString stringWithFormat:@"%@分",self.model.section_full];
                break;
            }
            case 2:
            {
                cell.titleOneLB.text = @"答题时间";
                cell.titleTwoLB.text = @"合格分数";
                cell.infoOneLB.text = [NSString stringWithFormat:@"%@分钟",self.model.section_time];
                cell.infoTwoLB.text = [NSString stringWithFormat:@"%@分",self.model.section_pass];
                break;
            }
            case 3:
            {
                cell.titleOneLB.text = @"答题人数";
                cell.titleTwoLB.text = @"";
                cell.infoOneLB.text = [NSString stringWithFormat:@"%@人",self.model.section_man];
                cell.infoTwoLB.text = @"";
                break;
            }
            default:
                break;
        }
        return cell;
    }
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - Setter/Getter

@end
