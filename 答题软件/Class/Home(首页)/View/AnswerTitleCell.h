//
//  AnswerTitleCell.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsModel.h"

@interface AnswerTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *questionNum;
@property (weak, nonatomic) IBOutlet UILabel *numLB;
@property (weak, nonatomic) IBOutlet UILabel *infoLB;

@property (nonatomic, strong) QuestionsModel * model;

@end
