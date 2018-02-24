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
@property (nonatomic, assign) int userId;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, assign) int resumeId;  //简历id
@property (nonatomic, strong) UserInfoModel * userInfo;  //详细资料


@property (nonatomic, assign) CGFloat balance; //余额

@end

