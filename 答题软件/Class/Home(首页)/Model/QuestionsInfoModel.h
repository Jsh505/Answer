//
//  questionsModel.h
//  答题软件
//
//  Created by 贾仕海 on 2018/3/1.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "BaseModel.h"

@interface QuestionsInfoModel : BaseModel
/*
 "section": "第3章",
 "group_type": "精选考题",
 "section_year": "2017年",
 questions
 "unit": "2017年注册安全工程师考试-1",
 "section_pass": "60",
 "group": "注册安全工程师",
 "section_info": "单选题(每题的备选项中，只有1个最符合题意)",
 "unit_man": "2000",
 "section_time": "120",
 "section_full": "100",
 "section_man": "200"
 */

@property (nonatomic, copy) NSString * section;
@property (nonatomic, copy) NSString * group_type;
@property (nonatomic, copy) NSString * section_year;
@property (nonatomic, copy) NSString * unit;
@property (nonatomic, copy) NSString * section_pass;
@property (nonatomic, copy) NSString * group;
@property (nonatomic, copy) NSString * section_info;
@property (nonatomic, copy) NSString * unit_man;
@property (nonatomic, copy) NSString * section_time;
@property (nonatomic, copy) NSString * section_full;
@property (nonatomic, copy) NSString * section_man;
@property (nonatomic, strong) NSMutableArray * questions;
@end
