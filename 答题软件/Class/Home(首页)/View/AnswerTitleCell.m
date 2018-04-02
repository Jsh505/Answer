//
//  AnswerTitleCell.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "AnswerTitleCell.h"

@implementation AnswerTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QuestionsModel *)model
{
    _model = model;
    
    self.typeTitleLB.text = model.questions_type;
//    self.questionNum.text = model.questions_id;
    self.infoLB.text = [NSString stringWithFormat:@"%@号题目:\n%@",model.questions_id,model.questions];
}

@end
