//
//  QuestionsModel.h
//  答题软件
//
//  Created by 贾仕海 on 2018/3/1.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "BaseModel.h"

@interface QuestionsModel : BaseModel

/*
 "answer_B": "答案B的内容",
 "answer": "C",
 "questions": "2017年注册安全工程师考试1-第3章-问题-1",
 "answer_info": "答案解析内容......",
 "answer_C": "答案C的内容",
 "questions_img": "http://p4k36yzp3.bkt.clouddn.com/KingI-icon.jpg",
 "questions_type": "单选题",
 "answer_A": "答案A的内容",
 "questions_num": "21",
 "answer_D": "答案D的内容"
 */

@property (nonatomic, copy) NSString * answer_B;
@property (nonatomic, copy) NSString * answer;
@property (nonatomic, copy) NSString * questions;
@property (nonatomic, copy) NSString * answer_info;
@property (nonatomic, copy) NSString * answer_C;
@property (nonatomic, copy) NSString * questions_img;
@property (nonatomic, copy) NSString * questions_type;
@property (nonatomic, copy) NSString * answer_A;
@property (nonatomic, copy) NSString * questions_id;
@property (nonatomic, copy) NSString * answer_D;
@property (nonatomic, copy) NSString * answer_E;
@property (nonatomic, copy) NSString * answer_F;


@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * user_answer;






@end
