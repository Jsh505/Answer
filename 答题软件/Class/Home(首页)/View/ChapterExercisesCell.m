//
//  ChapterExercisesCell.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "ChapterExercisesCell.h"

@implementation ChapterExercisesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QuestionsInfoModel *)model
{
    _model = model;
    self.titleLB.text = model.section;
    self.personNumLB.text = [NSString stringWithFormat:@"%@人答过",model.section_man];
}

@end
