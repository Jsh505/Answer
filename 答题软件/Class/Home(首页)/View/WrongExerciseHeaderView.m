//
//  WrongExerciseHeaderView.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "WrongExerciseHeaderView.h"

@implementation WrongExerciseHeaderView

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
}

@end
