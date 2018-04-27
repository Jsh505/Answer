//
//  ZLTabBarViewController.m
//  customNavigatViewController
//
//  Created by 朱占龙 on 16/8/2.
//  Copyright © 2016年 成都信息工程大学. All rights reserved.
//

#import "ZLTabBarViewController.h"
#import "HomeVC.h"
#import "ExaminationVC.h"
#import "RecordVC.h"
#import "MyVC.h"
#import "ZLNaviContrViewController.h"

@interface ZLTabBarViewController ()

@end

@implementation ZLTabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //1.添加tabBar
    HomeVC *homeVc = [[HomeVC alloc] init];
    [self addChildVcWithChildVc:homeVc Title:@"首页" image:@"首页未选" seletedImage:@"首页已选"];
    
    ExaminationVC *examinationVC = [[ExaminationVC alloc] init];
    [self addChildVcWithChildVc:examinationVC Title:@"考试" image:@"考试未选" seletedImage:@"考试已选"];
    
    RecordVC *recordVC = [[RecordVC alloc] init];
    [self addChildVcWithChildVc:recordVC Title:@"记录" image:@"记录未选" seletedImage:@"记录已选"];
    
    MyVC *myVC = [[MyVC alloc] init];
    [self addChildVcWithChildVc:myVC Title:@"我的" image:@"我的未选" seletedImage:@"我的已选"];
    
    
    //2.如有需要，在此更改系统自带的tabBar
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]]];
    
    [UITabBar appearance].translucent = NO;
    
}


- (void) addChildVcWithChildVc: (UIViewController *)childVc Title: (NSString *)title image: (NSString *)image seletedImage: (NSString *)seletedImage{
    
    //设置标题
    childVc.title = title;
    
    //设置图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    /*
     设置图片,默认会渲染图片，自己设置为不渲染
     navigation bars, tab bars, toolbars, and segmented controls automatically treat their foreground images as templates, while image views and web views treat their images as originals.
     */
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字属性
//    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [childVc.tabBarItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
//    NSMutableDictionary *selecteTitleAttr = [NSMutableDictionary dictionary];
//    selecteTitleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [childVc.tabBarItem setTitleTextAttributes:selecteTitleAttr forState:UIControlStateSelected];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont   systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor whiteColor]}   forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    //给每一个tabBar控制器添加导航
    ZLNaviContrViewController *naviVc = [[ZLNaviContrViewController alloc] initWithRootViewController:childVc];
    
    //将当前控制器添加到父控制器
    [self addChildViewController:naviVc];
}

@end
