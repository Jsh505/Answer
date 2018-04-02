//
//  AnswerCardCCell.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "AnswerCardCCell.h"

@implementation AnswerCardCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLB.layer.borderWidth = 1;
    self.titleLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.titleLB.layer.cornerRadius = (SCREEN_WIDTH / 6 - 20) / 2;
    self.titleLB.layer.masksToBounds = YES;
}

- (void)setIndexRow:(NSInteger)indexRow
{
    _indexRow = indexRow;
    self.titleLB.text = [NSString stringWithFormat:@"%ld",indexRow];
}

- (void)setModel:(QuestionsModel *)model
{
    _model = model;
    
    if (model.user_answer)
    {
        if ([model.user_answer isEqualToString:model.answer])
        {
            self.titleLB.backgroundColor = [UIColor colorWithHexString:@"31BC60"];
            self.titleLB.textColor = [UIColor whiteColor];
        }
        else
        {
            self.titleLB.backgroundColor = [UIColor colorWithHexString:@"FF2600"];
            self.titleLB.textColor = [UIColor whiteColor];
        }
    }
    else
    {
        self.titleLB.backgroundColor = [UIColor whiteColor];
        self.titleLB.textColor = [UIColor blackColor];
    }
}

@end
