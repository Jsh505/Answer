//
//  RecordTableViewCell.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/13.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RecordModel *)model
{
    _model = model;
    self.titleLB.text = model.unit;
    self.userNumLB.text = model.user_score;
    self.fullNumLB.text = [NSString stringWithFormat:@"/%@",model.unit_full];
}
@end
