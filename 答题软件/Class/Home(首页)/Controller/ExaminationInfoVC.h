//
//  ExaminationInfoVC.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/25.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "CoustromViewController.h"
#import "QuestionsInfoModel.h"

@interface ExaminationInfoVC : CoustromViewController

@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * unit;
@property (nonatomic, copy) NSString * section;

@property (nonatomic, strong) QuestionsInfoModel * model;

@end
