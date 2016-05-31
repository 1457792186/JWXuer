//
//  ChangeProtorol.h
//  登陆界面
//
//  Created by scjy on 16/1/16.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#ifndef ChangeProtorol_h
#define ChangeProtorol_h
@protocol ChangeInfo <NSObject>

- (void)getInfoWithInfo:(NSString *)info withTag:(NSInteger)viewControllerTag;

@end

#endif /* ChangeProtorol_h */
