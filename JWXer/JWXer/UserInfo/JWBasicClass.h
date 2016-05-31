//
//  JWBasicClass.h
//  JWXuerIB
//
//  Created by scjy on 16/3/12.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum _fileType{
    PLIST,
    JPG,
    FILED
}FileType;

typedef enum _netConnection{
    userins,//注册
    useredit,//修改用户信息
    userlogin,//登录
    typelist,//全部课程
    courselist,//课程列表
    courseinfo,//课程信息
    is_reg,//是否注册
    joincourse,//参加课程
    coursecommentadd,//发评论
    coursecomment,//评论列表
    checkupdate,//检查更新
    bannerlist,//banner列表
    joincourse_z,//学过课程章节
    searchlist,//搜索课程
    indexlist,//首页列表
    yijian,//意见反馈
}NetConnection;

@interface JWBasicClass : NSObject

@end
