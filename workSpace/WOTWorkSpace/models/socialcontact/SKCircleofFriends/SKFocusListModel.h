//
//  SKFocusListModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKFocusListModel_msg

@end

@interface SKFocusListModel_msg :JSONModel

@property (nonatomic, strong)NSString * companyName;
@property (nonatomic, strong)NSString * heard;
@property (nonatomic, strong)NSString * userName;
@property (nonatomic, strong)NSNumber * focusId;
@property (nonatomic, strong)NSNumber * userId;

@end

@interface SKFocusListModel : JSONModel

@property (nonatomic, strong) NSArray  <SKFocusListModel_msg > *msg;
@property (nonatomic, strong) NSString <Optional>*code;
@property (nonatomic, strong) NSString <Optional>*result;

@end
