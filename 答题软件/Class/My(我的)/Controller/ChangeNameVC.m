//
//  ChangeNameVC.m
//  答题软件
//
//  Created by 贾仕海 on 2018/2/23.
//  Copyright © 2018年 jsh. All rights reserved.
//

#import "ChangeNameVC.h"

@interface ChangeNameVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@end

@implementation ChangeNameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"更改昵称";
}
- (IBAction)commitButtonCilick:(id)sender
{
    
}



@end
