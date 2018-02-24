//
//  NSMutableString+Tool.m
//  Tool
//
//  Created by mac on 17/3/24.
//  Copyright © 2017年 lykj. All rights reserved.
//

#import "NSMutableString+Tool.h"
#import <CoreText/CoreText.h>

@implementation NSMutableString (Tool)

- (CGFloat)heightWithContainWidth:(CGFloat)width{
    int total_height = 0;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)[self mutableCopy]);
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    if(linesArray.count == 0)return 0;
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    int line_y = (int) origins[[linesArray count] -1].y;
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 100000 - line_y + (int) descent +1;
    CFRelease(textFrame);
    return total_height;
}

+ (NSAttributedString *)attributeStringWithPrefixString:(NSString *)prefixString
                                             prefixFont:(CGFloat)prefixFont
                                            prefixColor:(UIColor *)prefixColor
                                           suffixString:(NSString *)suffixString
                                             suffixFont:(CGFloat)suffixFont
                                            suffixColor:(UIColor *)suffixColor{
    NSInteger prefixLength = prefixString.length;
    NSInteger suffixLength = suffixString.length;
    
    NSString *finalString = [NSString stringWithFormat:@"%@%@", prefixString, suffixString];
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:finalString];
    
    if (prefixFont==0 && prefixColor==0) {
        [attributedString addAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                                          NSFontAttributeName: [UIFont systemFontOfSize:10.0f]
                                          }
                                  range:NSMakeRange(0, prefixLength)];
        
        
    }else {
        [attributedString addAttributes:@{NSForegroundColorAttributeName: prefixColor,
                                          NSFontAttributeName: [UIFont systemFontOfSize:prefixFont]
                                          }
                                  range:NSMakeRange(0, prefixLength)];
    }
    
    if (suffixFont==0 && suffixColor==0) {
        [attributedString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f],
                                          NSForegroundColorAttributeName: [UIColor blackColor]}
                                  range:NSMakeRange(prefixLength, suffixLength)];
    }else {
        
        
        [attributedString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:suffixFont],
                                          NSForegroundColorAttributeName: suffixColor}
                                  range:NSMakeRange(prefixLength, suffixLength)];
    }
    
    
    return attributedString;
}

+ (NSMutableAttributedString *)attributeStringWithPrefixString:(NSString *)prefixString
                                              subffixImageName:(NSString *)subffixImageName
{
    
    NSString *string = prefixString;
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    UIImage *image = [UIImage imageNamed:subffixImageName];
    NSTextAttachment *backAttachment = [[NSTextAttachment alloc] init];
    backAttachment.image = image;
    backAttachment.bounds = CGRectMake(0, -2, image.size.width, image.size.height);
    NSAttributedString *backString = [NSAttributedString attributedStringWithAttachment:backAttachment];
    
    [mutableAttributedString appendAttributedString:backString];
    
    return mutableAttributedString;
    
}

+ (NSMutableAttributedString *)attributeStringWithSubffixString:(NSString *)subffixString
                                                prefixImageName:(NSString *)prefixImageName
{
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    
    UIImage *image = [UIImage imageNamed:prefixImageName];
    NSTextAttachment *backAttachment = [[NSTextAttachment alloc] init];
    backAttachment.image = image;
    backAttachment.bounds = CGRectMake(0, -2, image.size.width, image.size.height);
    NSAttributedString *backString = [NSAttributedString attributedStringWithAttachment:backAttachment];
    
    [mutableAttributedString appendAttributedString:backString];
    
    
    [mutableAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:subffixString]];
    
    return mutableAttributedString;
    
}

@end
