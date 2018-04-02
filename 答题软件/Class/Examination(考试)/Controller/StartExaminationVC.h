//
//  StartExaminationVC.h
//  答题软件
//
//  Created by 贾仕海 on 2018/3/9.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "CoustromViewController.h"
#import "QuestionsInfoModel.h"

@interface StartExaminationVC : CoustromViewController

@property (nonatomic, strong) QuestionsInfoModel * model;
@property (nonatomic, assign) NSInteger secondsCountDown;

@end
