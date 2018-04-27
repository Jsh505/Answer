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
 *  背景色
 */
+ (instancetype)backgroudColor;
/**
 *  线条颜色
 */
+ (instancetype)lineColor;
/**
 *  字体主颜色
 */
+ (instancetype)mainTextColor;
/**
 *  副字体颜色
 */
+ (instancetype)otherTextColor;


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
