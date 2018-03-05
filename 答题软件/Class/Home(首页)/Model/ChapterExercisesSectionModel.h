//
//  ChapterExercisesSectionModel.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "BaseModel.h"
#import "ChapterExercisesCellModel.h"

@interface ChapterExercisesSectionModel : BaseModel

@property (nonatomic, assign) BOOL isFold;

@property (nonatomic, copy) NSString * unit;
@property (nonatomic, copy) NSString * unit_man;
@property (nonatomic, strong) NSMutableArray *section;
@property (nonatomic, copy) NSString * group_type;

@end
