//
//  UserInfoModel.h
//  笑园之窗
//
//  Created by 贾仕海 on 2018/1/15.
//  Copyright © 2018年 xyzc. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel

//储存字段
/*
 backgroundMap = "";
 birth = 19890412;
 city = "";
 colleges = "";
 email = "";
 evaluate = "";
 gender = "";
 grade = "";
 id = 88;
 name = "";
 nickName = "";
 perSignature = "";
 phone = 13432343233;
 pictureName = "";
 signatureTime = "";
 userId = 0;
 */
#pragma mark -- 用户基本信息
@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString * backgroundMap;
@property (nonatomic, copy) NSString * birth;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * colleges;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * evaluate;   //评价
@property (nonatomic, copy) NSString * gender;
@property (nonatomic, copy) NSString * grade;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * nickName;
@property (nonatomic, copy) NSString * perSignature;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * pictureName;
@property (nonatomic, copy) NSString * signatureTime;
@property (nonatomic, assign) int userId;

@end
