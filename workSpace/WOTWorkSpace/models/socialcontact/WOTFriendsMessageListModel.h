//
//  WOTFriendsMessageListModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/9/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTFriendsMessageModel <NSObject>

@end

@interface WOTFriendsMessageModel : JSONModel
@property (nonatomic, strong) NSString *sharePicture;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSNumber *shareId;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *textWord;
@property (nonatomic, strong) NSString *creationTime;
@end


@interface WOTFriendsMessageListModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTFriendsMessageModel> *msg;


@end
