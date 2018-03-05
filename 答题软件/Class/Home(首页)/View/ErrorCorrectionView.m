//
//  ErrorCorrectionView.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/27.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "ErrorCorrectionView.h"

@implementation ErrorCorrectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [ErrorCorrectionView loadViewFromXIB];
        self.frame = frame;
        UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewSingleTap)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [self.masView addGestureRecognizer:singleRecognizer];
        
        self.infoTextView.placeholder = @"请输入内容...";
    }
    return self;
}

- (void)showWithView:(UIView *)view
{
    if (view)
    {
        [view addSubview:self];
    }
    else
    {
        [self addToWindow];
    }
    
    [self.contentView springingAnimation];
}

- (void)maskViewSingleTap
{
    [self canel];
}

- (void)canel
{
    [UIView animateWithDuration:0.3 animations:^{
        self.masView.alpha = 0;
        self.contentView.alpha = 0;
    } completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         self.masView.alpha = 0.2;
         self.contentView.alpha = 1;
     }];
}

- (IBAction)canelButtonCilick:(id)sender
{
    [self canel];
}

- (IBAction)sendLabelButtonCilick:(id)sender
{
    //提交
    [self canel];
   
}

@end
