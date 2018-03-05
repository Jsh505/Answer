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
    self.nameTF.text = [UserSignData share].user.nick_name;
}
- (IBAction)commitButtonCilick:(id)sender
{
    NSMutableDictionary * parametersDic = [[NSMutableDictionary alloc] init];
    [parametersDic setObject:[UserSignData share].user.phone forKey:@"phone"];
    [parametersDic setObject:[UserSignData share].user.token forKey:@"token"];
    [parametersDic setObject:self.nameTF.text forKey:@"nick_name"];
    
    [PPNetworkHelper POST:@"/user/information/" parameters:parametersDic hudString:nil success:^(id responseObject)
     {
         [UserSignData share].user.nick_name = self.nameTF.text;
         [[UserSignData share] storageData:[UserSignData share].user];
         [self.navigationController popViewControllerAnimated:YES];
     } failure:^(NSString *error)
     {
         [MBProgressHUD showErrorMessage:error];
     }];
}



@end
