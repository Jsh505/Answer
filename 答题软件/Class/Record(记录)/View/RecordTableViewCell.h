//
//  RecordTableViewCell.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/13.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface RecordTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *userNumLB;
@property (weak, nonatomic) IBOutlet UILabel *fullNumLB;
@property (nonatomic, strong) RecordModel * model;

@end
