//
//  AnswerOptionCell.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "AnswerOptionCell.h"

@implementation AnswerOptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLB.layer.borderWidth = 1;
    self.titleLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.titleLB.layer.cornerRadius = 15;
    self.titleLB.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if (isSelected)
    {
        self.titleLB.backgroundColor = [UIColor mainColor];
        self.titleLB.textColor = [UIColor whiteColor];
    }
    else
    {
        self.titleLB.backgroundColor = [UIColor whiteColor];
        self.titleLB.textColor = [UIColor blackColor];
    }
}

@end
