//
//  ErrorCorrectionView.h
//  答题软件
//
//  Created by 贾仕海 on 2018/2/27.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrorCorrectionViewDelegate <NSObject>

- (void)giftButtonCilick;

@end

@interface ErrorCorrectionView : UIView

@property (weak, nonatomic) IBOutlet UIView *masView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;


@property (nonatomic, strong) id <ErrorCorrectionViewDelegate> delegate;

- (void)showWithView:(UIView *)view;
- (void)canel;

@end
