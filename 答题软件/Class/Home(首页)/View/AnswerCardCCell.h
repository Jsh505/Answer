//
//  AnswerCardCCell.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsModel.h"

@interface AnswerCardCCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (nonatomic, assign) NSInteger indexRow;
@property (nonatomic, strong) QuestionsModel * model;

@end
