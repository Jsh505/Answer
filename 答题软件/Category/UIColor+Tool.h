//
//  UIColor+Tool.h
//  Tool
//
//  Created by mac on 17/3/24.
//  Copyright © 2017年 lykj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Tool)

/**
 *  主题色
 */
+ (instancetype)mainColor;
/**
 *  背景浅灰色
 */
+ (instancetype)backgroudColor;

/// 分割线颜色
+ (instancetype)lineColor;

+ (instancetype)titleColor;

+ (instancetype)otherTitleColor;

//
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
