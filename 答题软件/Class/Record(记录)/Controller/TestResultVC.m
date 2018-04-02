//
//  TestResultVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/27.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "TestResultVC.h"
#import "AnswerCardCCell.h"
#import "RankingListVC.h"
#import "QuestionsModel.h"
#import "TestResultInfoVC.h"

@interface TestResultVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (weak, nonatomic) IBOutlet UIView *noAnswerdock;

@property (weak, nonatomic) IBOutlet UILabel *user_num;
@property (weak, nonatomic) IBOutlet UILabel *full_num;

@end

@implementation TestResultVC

#pragma mark - Lifecycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"考试结果";
    self.noAnswerdock.layer.borderWidth = 1;
    self.noAnswerdock.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.user_num.text = self.recordModel.user_score;
    self.full_num.text = [NSString stringWithFormat:@"总分:%@分",self.recordModel.unit_full];
    
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.collectionView];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    [parametersDic setObject:self.recordModel.unit forKey:@"unit"];
    
    [PPNetworkHelper POST:@"/online/record_content/" parameters:parametersDic hudString:@"获取中..." success:^(id responseObject)
     {
         [self.dataSource removeAllObjects];
         for (NSDictionary * dic in responseObject)
         {
             QuestionsModel * model = [[QuestionsModel alloc] initWithDictionary:dic];
             model.questions_id = model.id;
             [self.dataSource addObject:model];
         }
         [self.collectionView reloadData];
     } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
     }];
}

#pragma mark - Custom Accessors (控件响应方法)

#pragma mark - IBActions(xib响应方法)


#pragma mark - Public (.h 公共调用方法)


#pragma mark - Private (.m 私有方法)


#pragma mark - Deletate/DataSource (相关代理)

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1 ;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerCardCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnswerCardCCellident" forIndexPath:indexPath];
    cell.indexRow = indexPath.row + 1;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-( void )collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestResultInfoVC * vc = [[TestResultInfoVC alloc] init];
    vc.index = (int)indexPath.row;
    vc.dataSource = self.dataSource;
    [self.navigationController pushViewController:vc animated:YES];
}

//返回这个UICollectionViewCell是否可以被选择
-( BOOL )collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES ;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath {
    
    return CGSizeMake (SCREEN_WIDTH / 6 , SCREEN_WIDTH / 6);
}

//定义每个UICollectionView 的边距
-(UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger )section {
    
    return UIEdgeInsetsMake (0, 0, 0, 0);
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - Setter/Getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - JSH_NavbarAndStatusBarHeight - JSH_SafeBottomMargin - 150 - 31) collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:@"AnswerCardCCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AnswerCardCCellident"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self ;
        _collectionView.dataSource = self ;
    }
    return _collectionView;
}

@end
