//
//  MyTableHeaderView.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/13.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;

@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *zhangjielianxiBUtton;
@property (weak, nonatomic) IBOutlet UIButton *myshoucangButton;
@property (weak, nonatomic) IBOutlet UIButton *zhanghuguanliButton;

@end
