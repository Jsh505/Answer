//
//  UIButton+TouchOne.h
//  TouchOneBtn
//
//  Created by WooY on 2017/8/10.
//  Copyright © 2017年 WooY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TouchOne)

/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;

/**
 *  bool YES 忽略点击事件   NO 允许点击事件
 */
@property (nonatomic, assign) BOOL isIgnoreEvent;


@end
