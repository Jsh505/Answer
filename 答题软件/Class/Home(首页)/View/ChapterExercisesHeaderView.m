//
//  ChapterExercisesHeaderView.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "ChapterExercisesHeaderView.h"

@implementation ChapterExercisesHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setModel:(ChapterExercisesSectionModel *)model
{
    _model = model;
    if (model.section.count)
    {
        self.typeImageView.hidden = NO;
        if (model.isFold)
        {
            self.typeImageView.image = [UIImage imageNamed:@"列表加号"];
        }
        else
        {
            self.typeImageView.image = [UIImage imageNamed:@"列表减号"];
        }
    }
    else
    {
        self.typeImageView.hidden = YES;
    }
    
    self.titleLB.text = model.unit;
    if (model.unit_man)
    {
        self.personNumLB.text = [NSString stringWithFormat:@"%@人答过",model.unit_man];
    }
    else
    {
        self.personNumLB.text = model.group_type;
    }
}

@end
