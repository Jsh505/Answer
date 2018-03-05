//
//  UserModel.h
//  FBG
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 ButtonRoot. All rights reserved.
//

#import "BaseModel.h"
#import "UserInfoModel.h"

@interface UserModel : BaseModel <NSCoding>

//储存字段

#pragma mark -- 用户基本信息
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * nick_name;
@property (nonatomic, copy) NSString * gender;
@property (nonatomic, copy) NSString * birthday;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * user_info;

//消息数组
@property (nonatomic, strong) NSArray * message;

@property (nonatomic, copy) NSString * localGroup;   //当前类别
@end

