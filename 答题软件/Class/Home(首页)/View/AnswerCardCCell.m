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
}

@end
