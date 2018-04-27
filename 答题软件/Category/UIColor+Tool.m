//
//  UIColor+Tool.m
//  Tool
//
//  Created by mac on 17/3/24.
//  Copyright © 2017年 lykj. All rights reserved.
//

#import "UIColor+Tool.h"

@implementation UIColor (Tool)

+ (instancetype)mainColor
{
    return [UIColor colorWithHexString:@"3C83F7"];
}

+ (instancetype)lineColor
{
    return [self colorWithHexString:@"1f1f1f"];
}

+ (instancetype)backgroudColor
{
    return [UIColor colorWithHexString:@"F4F5F6"];
}

+ (instancetype)mainTextColor;
{
    return [self colorWithHexString:@"1f1f1f"];
}

+ (instancetype)otherTextColor;
{
    return [UIColor colorWithHexString:@"3f3f3f"];
}


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

@end
