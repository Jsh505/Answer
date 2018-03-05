//
//  ChapterExercisesModel.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "BaseModel.h"

@interface ChapterExercisesCellModel : BaseModel

@property (nonatomic, copy) NSString * section;
@property (nonatomic, copy) NSString * section_man;
@property (nonatomic, copy) NSString * typeKey;

@end
