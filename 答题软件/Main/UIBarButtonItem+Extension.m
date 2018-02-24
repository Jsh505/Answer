//
//  UIBarButtonItem+Extension.m
//  微博
//
//  Created by 朱占龙 on 16/7/9.
//  Copyright © 2016年 cuit. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  创建一个item
 *
 *  @param target    点击者所属的对象
 *  @param action    点击者所属对象的方法
 *  @param image     图像
 *  @param highImage 高亮图像
 *
 *  @return 返回item
 */
+ (UIBarButtonItem *)itemWithTarget: (id)target action: (SEL)action image: (NSString *)image highImage: (NSString *) highImage{
    
    //设置导航栏按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed: image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置大小
    CGFloat btnW = btn.currentBackgroundImage.size.width;
    CGFloat btnH = btn.currentBackgroundImage.size.height;
    btn.bounds = CGRectMake(0, 0, btnW, btnH);
    [btn addTarget: target action: action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView: btn];
}

+ (UIBarButtonItem *)itemWithTarget: (id)target action: (SEL)action title:(NSString *)title
{
    //设置导航栏按钮
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [releaseButton setTitle:title forState:normal];
    releaseButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [releaseButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [releaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView: releaseButton];
}
@end
