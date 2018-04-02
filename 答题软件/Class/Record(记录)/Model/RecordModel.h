//
//  RecordModel.h
//  答题软件
//
//  Created by 贾仕海 on 2018/3/15.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "BaseModel.h"

@interface RecordModel : BaseModel

@property (nonatomic, copy) NSString * unit_full;
@property (nonatomic, copy) NSString * unit;
@property (nonatomic, copy) NSString * user_score;

@end
