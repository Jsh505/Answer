//
//  ChapterExercisesCell.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChapterExercisesCellModel.h"

@interface ChapterExercisesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *personNumLB;

@property (nonatomic, strong) ChapterExercisesCellModel * model;

@end
