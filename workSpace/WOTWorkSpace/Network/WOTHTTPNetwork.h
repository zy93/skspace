//
//  WOTHTTPNetwork.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class WOTWXPayModel;

typedef void(^response)(id bean,NSError *error);

@interface WOTHTTPNetwork : NSObject

#pragma mark - 用户
/**
 * 登录接口
 @param telOrEmail  登录账号手机号或邮箱
 @param pwd         登录密码 md5加密
 @param alias       用户设备alias
 @param response    回调数据到上层
 */
+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd alias:(NSString *)alias response:(response)response;

/**
 * 发送手机验证码
 @param tel  验证码
 @param response    回调数据到上层
 */
+(void)userGetVerifyWitTel:(NSString *)tel response:(response)response;
/**
 * 注册接口 或 找回密码接口
 @param code 验证码
 @param tel  手机号注册
 @param pass 用户密码
 @param alias       用户设备alias
 @param invitationCode 邀请码
 @param response    回调数据到上层
 */
+(void)userRegisterWitVerifyCode:(NSString *)code tel:(NSString *)tel userName:(NSString *)userName password:(NSString *)pass alias:(NSString *)alias invitationCode:(NSString *)invitationCode response:(response)response;


/**
 * 修改密码接口
 @param code 验证码
 @param tel  手机号注册
 @param pass 用户密码
 @param response    回调数据到上层
 */
+(void)updatePassWordWithVerifyCode:(NSString *)code tel:(NSString *)tel password:(NSString *)pass response:(response)response;


/**
 获取我的邀请

 @param response 结果回调  
 */
+(void)getUserInviteResponse:(response)response;

/**
 同意支付协议的接口

 @param userId 用户id
 @param agreementState 协议字段
 @param response 结果回调
 */
+(void)addUserPayDelegateWithUserId:(NSNumber *)userId agreementState:(NSString *)agreementState response:(response)response;


/**
 查询消息列表

 @param response 结果回调
 */
+(void)queryNotifationInfoWithReadState:(NSString *)readState response:(response)response;



/**
 修改通知状态
 @param newsId 通知id
 @param readState 通知状态
 @param response 结果回调
 */
+(void)modifyNotifationTypeWithNewsId:(NSNumber *)newsId readState:(NSString *)readState response:(response)response;

/**
 查询我的需求

 @param response 结果回调
 */
+(void)queryMyDemandResponse:(response)response;

/**
 发送消息

 @param userId 用户id
 @param type 类型
 @param summary 消息描述
 @param response 结果回调
 */
+(void)sendMessageWithUserId:(NSNumber *)userId type:(NSString *)type summary:(NSString*)summary response:(response)response;


/**
 查询是否有未读朋友圈

 @param userId 用户id
 @param response 结果回调
 */
+(void)queryUnreadWithUserId:(NSNumber *)userId response:(response)response;

#pragma mark- 空间

/**
 获取存在空间的城市列表

 @param response 响应回调
 */
+(void)getCityListResponse:(response)response;
/**
 * 根据城市获取所有空间接口
 @param city  城市名称 传入城市名称根据城市筛选，不传查询全部
 @param response    回调数据到上层
 */
+(void)getAllSpaceWithCity:(NSString *)city block:(response)response;

/**
 * 根据城市获取所有已经排序（工位）空间接口
 @param city  城市名称 传入城市名称根据城市筛选，不传查询全部
 @param response    回调数据到上层
 */
+(void)getAllSpaceSortWithCity:(NSString *)city block:(response)response;

/**
 * 根据城市获取所有已经排序（房间）空间接口
 @param city  城市名称 传入城市名称根据城市筛选，不传查询全部
 @param response    回调数据到上层
 */
+(void)getAllSpaceAndRoomWithCity:(NSString *)city block:(response)response;

/**
 * 无参数获取全部空间
 */
+(void)getSpaceSitationBlock:(response)response;

/**
 *获取所有空间
 *
 */
+(void)getSapaceFromGroupBlock:(response)response;
/**
 *获取所有空间
 * @param page 页码
 * @param pageSize 大小
 * @param response 返回响应
 */
+(void)getSapaceWithPage:(NSNumber*)page pageSize:(NSNumber *)pageSize response:(response)response;


/**
 获取首页空间信息

 @param response 回调
 */
+(void)getNewSpaceDataBlock:(response)response;

/**
 根据空间id获取空间

 @param spaceId 空间id
 @param response spaceModel
 */
+(void)getSpaceFromSpaceID:(NSNumber *)spaceId bolock:(response)response;

/**
 获取定位最近的空间

 @param lat 纬度
 @param lon 经度
 */
+(void)getSpaceWithLocation:(CGFloat)lat lon:(CGFloat)lon response:(response)response;

/**
 通过空间id获取所有工位

 @param spaceId spaceId
 @param response 结果回调
 */
+(void)getBookStationWithSpaceId:(NSNumber *)spaceId response:(response)response;

/**
 通过空间id获取工位数量
 
 @param spaceId spaceId
 @param response 结果回调
 */
+(void)getBookStationNumberWithSpaceId:(NSNumber *)spaceId time:(NSString *)time response:(response)response;


/**
 通过空间id查询空间信息

 @param spaceId 空间id
 @param response 结果回调
 */
+(void)getSpaceInfoWithSpaceId:(NSNumber *)spaceId response:(response)response;

/**
 查询空间运营团队

 @param spaceId 空间id
 @param response 结果回调
 */
+(void)getSpaceTeamWithSpaceId:(NSNumber *)spaceId response:(response)response;

/**
 获取空间设施

 @param spaceId 空间id
 @param response 回调
 */
+(void)getSpaceFacilitiesWithSpaceId:(NSNumber *)spaceId response:(response)response;


/**
 预约入驻

 @param response 回调
 */
//+(void)appointmentSettledWithSpaceId:(NSNumber *)spaceId spaceName:(NSString *)spaceName response:(response)response;
+(void)appointmentSettledWithSpaceId:(NSNumber *)spaceId tel:(NSString *)tel appointmentTime:(NSString *)appointmentTime peopleNum:(NSNumber *)peopleNum remark:(NSString *)remark companyName:(NSString *)companyName contacts:(NSString *)contacts spaceName:(NSString *)spaceName response:(response)response;


/**
 查询房间列表

 @param spaceId 空间id
 @param response 结果回调
 */
+(void)queryRoomListWithSpaceId:(NSNumber *)spaceId response:(response)response;





/**
 查询社区服务信息

 @param spaceId 空间id
 @param response 结果回调
 */
+(void)queryCommunityServiceInfoWithSpaceId:(NSNumber *)spaceId response:(response)response;

#pragma mark - 发票信息提交

+(void)submitReceiptWithOrderDic:(NSDictionary *)orderDic response:(response)response;

#pragma mark - 企业

/**
 获取企业剩余时长

 @param companyId 企业ID
 @param response 回调
 */
+(void)queryCompanyTimeRemainingWithId:(NSString *)companyId response:(response)response;


/**
 * 获取空间下的友邻企业
 *@param spaceid  空间id
 *@param response  对象返回上层，错误返回error
 */
+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response;


/**
 获取首页

 @param response 结果回调
 */
+(void)getNewEnterprisesDataResponse:(response)response;

/**
 搜索企业

 @param name 企业名称
 @param response 数据响应
 */
+(void)searchEnterprisesWithName:(NSString *)name response:(response)response;

/**
 *我的--我的企业
 @param companyId  企业id 登录接口返回用户的companyId+companyIdAdmin,字符串
 @param response 响应回调
 */
+(void)getUserEnterpriseWithCompanyId:(NSString *)companyId  response:(response)response;

/**
 申请加入企业

 @param enterpriseId 企业id
 @param name 企业名称
 @param response 响应回调
 */
+(void)applyJoinEnterpriseWithEnterpriseId:(NSString *)enterpriseId enterpriseName:(NSString *)name response:(response)response;

/**
 处理加入企业的申请
 
 @param applyId 申请id
 @param response 响应回调
 */
+(void)disposeApplyJoinEnterprise:(NSNumber *)applyId  opinionStr:(NSString *)opinionStr response:(response)response;

/**
 创建企业

 @param enterpriseName 企业名称
 @param enterpriseType 企业类型
 @param enterpriseLogo 企业logo
 @param contactsName 联系人
 @param tel 联系电话
 @param email 邮箱
 @param response 响应回调
 */
+(void)createEnterpriseWithEnterpriseName:(NSString *)enterpriseName enterpriseType:(NSString *)enterpriseType enterpriseLogo:(UIImage *)enterpriseLogo contactsName:(NSString *)contactsName contactsTel:(NSString *)tel contactsEmail:(NSString *)email response:(response)response;


/**
 获取申请加入企业的请求

 @param enterpriseIds 企业id，用『,』分割
 @param response 响应回调
 */
+(void)getApplyJoinEnterpriseListWithEnterpriseIds:(NSString *)enterpriseIds response:(response)response;

/**
 *  获取活动列表  根据页码
 *  @param page 页码/每页查询10个数据
 *  @param response 回调数据返回上层
 */
+(void)getActivitiesWithPage:(NSNumber *)page response:(response)response;


/**
 获取我的活动列表

 @param tel 用户手机号
 @param response 响应回调
 */
+(void)queryMyActivityWithUserTel:(NSString *)tel response:(response)response;

/**
 * 获取全部资讯列表
 */
+(void)getNewsWithPage:(NSNumber *)page response:(response)response;

/**
 查询企业成员
 
 @param companyId 公司id
 @param response 返回响应
 */
+(void)queryEnterpriseMemberWithCompanyId:(NSString *)companyId response:(response)response;


/**
 删除企业成员

 @param companyId 公司id
 @param userId 用户id
 @param response 返回响应
 */
+(void)deleteEnterpriseMemberWithCompanyId:(NSString *)companyId userId:(NSNumber *)userId response:(response)response;


/**
 查询我的申请入驻消息

 @param response 返回响应
 */
+(void)queryMyEnterInfoResponse:(response)response;

#pragma mark - 轮播图
/**
 *获取首页页面轮播图资源数据
 */
+(void)getHomeSliderSouceInfo:(response)response;

/**
 获取服务界面banner 数据
 
 @param response 结果回调
 */
+(void)getServiceBannerData:(response)response;

/**
 *获取我的历史--反馈列表数据
 @param userId  登录者用户id
 @param response 回调数据返回到上层
 */

+(void)getMyHistoryFeedBackData:(NSNumber *)userId response:(response)response;


/**
 查询某空间内会员

 @param name 会员名称
 @param spaceId 空间id
 @param response 返回响应
 */
+(void)searchMemberWithName:(NSString *)name spaceId:(NSNumber *)spaceId response:(response)response;




#pragma mark - 服务商
/**
 *注册成为平台服务商
 @param userId  用户id
 
 */
+(void)registerServiceBusiness:(NSNumber *)userId firmName:(NSString *)firmName businessScope:(NSString *)businessScope contatcts:(NSString *)contatcts tel:(NSString *)tel facilitatorType:(NSString *)facilitatorType facilitatorState:(NSNumber *)facilitatorState firmLogo:(NSArray<UIImage *> *)firmLogo     response:(response)response;

/**
 *服务--获取服务商类别
 */
+(void)getAllServiceTypes:(response)response;

/**
 获取服务商列表

 @param response 返回
 */
+(void)getServiceProviders:(response)response;


/**
 首页获取服务商

 @param response 结果回调
 */
+(void)getNewServiceProviders:(response)response;

/**
 获取服务商产品

 @param facilitatorId 服务商id
 @param response 结果回调
 */
+(void)getServiceProductWithFacilitatorId:(NSNumber *)facilitatorId response:(response)response;

/**
 服务页获取服务商
 
 @param response 结果回调
 */
+(void)getServiceVCServiceProviders:(response)response;


/**
 *服务--发布需求页面
 */

+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSString *)spaceId userId:(NSString *)userId facilitatorType:(NSString *)facilitatorType facilitatorLabel:(NSString *)facilitatorLabel  response:(response)response;



/**
 *提交意见反馈
 */

+(void)feedBackWithSapceName:(NSString *)spaceName spaceId:(NSNumber *)spaceId contentText:(NSString *)contentText tel:(NSString *)tel response:(response)response;


+(void)getFlexSliderSouceInfo:(response)response;

/**
 查询单个服务商

 @param facilitatorId 服务商id
 @param response 结果回调
 */
+(void)querySingleFacilitator:(NSNumber *)facilitatorId response:(response)response;

#pragma mark - 访客
/**
 访客申请

 @param name 访客姓名
 @param sex 访客性别
 @param tel 访客电话
 @param spaceId 访问空间id
 @param accessType 访问类型
 @param targetName 受访者姓名
 @param targetId 受访者userId
 @param targetAlias 受访者alias
 @param visitorInfo 访问事由
 @param peopleNum 访问人数
 @param time 到访时间
 @param response 响应回调
 */
+(void)visitorAppointmentWithVisitorName:(NSString *)name
                                     sex:(NSString *)sex
                                     tel:(NSString *)tel
                                 spaceId:(NSNumber *)spaceId
                               spaceName:(NSString *)spaceName
                              accessType:(NSNumber *)accessType
                              targetName:(NSString *)targetName
                                targetId:(NSNumber *)targetId
                             targetAlias:(NSString *)targetAlias
                             visitorInfo:(NSString *)visitorInfo
                               peopleNum:(NSNumber *)peopleNum
                               visitTime:(NSString *)time
                                response:(response)response;


/**
 *获取我的预约 （我发出的+我收到的）
 @param response 响应回调
 */
+(void)getMyAppointmentResponse:(response)response;


/**
 处理访客预约

 @param visitorId 预约id
 @param result 处理结果
 @param response 响应回调
 */
+(void)disposeAppointmentWithVisitorId:(NSNumber *)visitorId result:(NSString *)result response:(response)response;


/**
 *  添加服务商
 */
+(void)addBusinessWithLogo:(UIImage*)logo name:(NSString*)name type:(NSString *)type contactName:(NSString*)contactName contactTel:(NSString *)contactTel contactEmail:(NSString*)email response:(response)response;

/****************           Service        ****************************/

//TODO: 会议室

/**
 获取会议室列表

 @param spaceid 空间id
 @param response 响应回调
 */
+(void)getMeetingRoomListWithSpaceId:(NSNumber *)spaceid type:(NSNumber *)type response:(response)response;

/**
 获取某个会议室预定情况

 @param spaceid 空间id
 @param confid 会议室id
 @param strTime 查询时间
 @param response 回调
 */
+(void)getMeetingReservationsTimeWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)strTime response:(response)response;

/**
 预定会议室

 @param spaceid 空间id
 @param params 参数列表
 @param response 回调
 */
//+(void)meetingReservationsWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)startTime endTime:(NSString *)endTime response:(response)response;
+(void)meetingReservationsWithParams:(NSDictionary *)params response:(response)response;


/**
 预定场地

 @param params 参数列表
 @param response 回调
 */
+(void)siteReservationsWithParams:(NSDictionary *)params response:(response)response;


/**
 获取会议室、场地设施

 @param meetingId 会议室场地id
 @param response 结果回调
 */
+(void)getMeetingFacilitiesWithMeetingId:(NSNumber *)meetingId response:(response)response;


//TODO: 工位

/**
 获取空间工位信息

 @param spaceId 空间id
 @param response 回调
 */
+(void)bookStationReservationsWithSpaceId:(NSNumber *)spaceId
                                    count:(NSNumber *)count
                                startTime:(NSString *)startTime
                                  endTime:(NSString *)endTime
                                 response:(response)response;
//+(void)getBookStationInfoWithSpaceId:(NSNumber *)spaceid response:(response)response;//2017 废弃
//+(void)getBook
/**
 *我的--我的活动
 */
+(void)getUserActivitiseWithUserId:(NSNumber *)userId state:(NSString *)state response:(response)response;



/**
 *我的--我的历史获取提交的历史服务需求
 */


+(void)getDemandsWithUserId:(NSNumber *)userId response:(response)response;

/**
 *服务--提交保修申请
 @param userId  用户id
 @param type 维修类型
 @param info 维修描述
 @param appointmentTime 时间
 @param address 报修的位置
 @param file 上传报修的图片
 @param alias  *接口返回，未知*
 @param response 回调数据到上层
 */
+(void)postRepairApplyWithUserId:(NSNumber *)userId type:(NSString *)type info:(NSString *)info appointmentTime:(NSString *)appointmentTime address:(NSString *)address file:(NSArray<UIImage *> *)file alias:(NSString *)alias  response:(response)response;


/**
 获取用户报修记录

 @param response 返回回调
 */
+(void)getUserRepairHistoryResponse:(response)response;


#pragma mark - 订单

/**
 预定会议室、场地
 @param response 结果回调
 */
+(void)generateOrderWithParam:(NSDictionary *)param response:(response)response;


/**
 工位微信订单

 @param param 参数
 @param response 结果回调
 */
+(void)generateBookStationOrderWithParam:(NSDictionary *)param response:(response)response;

+(void)getUserOrderWithType:(NSString *)type response:(response)response;

/**
 查询会议室订单
 @param response 响应回调
 */
+(void)getUserMeetingOrderResponse:(response)response;
/**
 查询工位订单
 @param response 响应回调
 */
+(void)getUserWorkStationOrderResponse:(response)response;
/**
 查询场地订单
 @param response 响应回调
 */
+(void)getUserSiteOrderResponse:(response)response;
#pragma mark - 支付接口

/**
 微信支付
 @param payModel 响应回调
 */
+(void)wxPayWithParameter:(WOTWXPayModel *)payModel;


/**
 支付宝订单

 @param parm 参数
 @param response 结果回调
 */
+(void)submitAlipayOrderWith:(NSDictionary *)parm response:(response)response;


/**
 请求支付宝OrderString

 @param parm 请求参数
 @param response 结果回调
 */
+(void)getOrderString:(NSDictionary *)parm response:(response)response;

/**
 工位和会议室取消订单

 @param parm 请求参数
 @param response 结果回调
 */
+(void)cancelOrder:(NSDictionary *)parm response:(response)response;

#pragma mark - 社交

+(void)sendMessageToSapceWithSpaceId:(NSNumber *)spaceId text:(NSString *)text images:(NSArray *)images response:(response)response;
+(void)getMessageBySapceIdWithSpaceId:(NSNumber *)spaceId response:(response)response;

///****************尚科新接口**************

/**
 查询全部朋友圈

 @param focusPeopleid  登录用户的userid
 @param pageNo 页数
 @param pageSize 条数
 @param response 结果回调
 */
+(void)queryAllCircleofFriendsWithFocusPeopleid:(NSNumber *)focusPeopleid pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize response:(response)response;

/**
 删除朋友圈

 @param friendId 朋友圈id
 @param response 结果回调
 */
+(void)deleteCircleofFriendsWithFriendId:(NSNumber *)friendId response:(response)response;

/**
 添加评论，回复评论接口

 @param friendId 朋友圈id
 @param byReplyid 被回复人id
 @param byReplyname 被回复人名字
 @param replyId 评论人id
 @param replyName 评论人名字
 @param replyInfo 评论内容
  @param replyState 评论状态
 @param response 结果回调
 */

+(void)addReplyWithFriendId:(NSNumber *)friendId byReplyid:(NSNumber *)byReplyid byReplyname:(NSString *)byReplyname replyId:(NSNumber *)replyId replyName:(NSString *)replyName replyInfo:(NSString *)replyInfo replyState:(NSString *)replyState response:(response)response;


/**
 添加关注

 @param focusPeopleid 关注人id
 @param befocusPeopleid  被关注人id
 @param response 结果回调
 */
+(void)addFocusWithfocusPeopleid:(NSNumber *)focusPeopleid befocusPeopleid:(NSNumber *)befocusPeopleid response:(response)response;


/**
 取消关注

 @param friendId 关注信息id
 @param response 结果回调
 */
+(void)deleteFocusWithFocusId:(NSNumber *)friendId response:(response)response;


/**
 发布朋友圈接口

 @param userId 发布人id
 @param userName 发布人姓名
 @param circleMessage 发布的信息
 @param photosArray 发布的图片数组
 @param response 结果回调
 */
+(void)sendMessageWithUserId:(NSNumber *)userId userName:(NSString *)userName circleMessage:(NSString *)circleMessage photosArray:(NSArray *)photosArray response:(response)response;
/**
 查询我关注人的朋友圈
 
 @param focusPeopleid  登录用户的userid
 @param pageNo 页数
 @param pageSize 条数
 @param response 结果回调
 */
+(void)queryFocusCircleofFriendsWithFocusPeopleid:(NSNumber *)focusPeopleid pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize response:(response)response;


/**
 查询单条朋友圈信息

 @param friendid 朋友圈id
 @param userid 用户id
 @param response 结果回调
 */
+(void)querySingleCircleofFriendsWithFriendId:(NSNumber *)friendid userid:(NSNumber *)userid response:(response)response;


/**
 查询我的朋友圈评论

 @param byReplyid 被评论人id
 @param pageNo 页数
 @param pageSize 条数
 @param response 结果回调
 */
+(void)queryMyCircleofFriendsCommentWithbyReplyid:(NSNumber *)byReplyid pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize response:(response)response;



/**
 查询关注人的信息

 @param byUserId 查看人的userid
 @param response 结果回调
 */
+(void)queryFocusOnPeopleWithFocusPeopleid:(NSNumber *)byUserId response:(response)response;


/**
 查询某个人所发朋友圈

 @param focusPeopleid 查询人id
 @param pageNo 页数
 @param pageSize 条数
 @param userId 被查看人的id
 @param response 结果回调
 */
+(void)querysingleCircleofFriendsWithFocusPeopleid:(NSNumber *)focusPeopleid pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize userId:(NSNumber *)userId response:(response)response;


/**
 删除评论

 @param recordId 评论id
 @param response 结果回调
 */
+(void)deleteReplyRecorWithRecordId:(NSNumber *)recordId response:(response)response;


/**
 查询单个用户信息

 @param userId 用户id
 @param response 结果回调
 */
+(void)querySingularManInfoWithUserId:(NSNumber *)userId response:(response)response;


/**
 修改用户资料

 @param parameters 需要修改的参数
 @param photosArray 头像图片
 @param response 结果回调
 */
+(void)updateUserInfoWithParameters:(NSDictionary *)parameters photosArray:(NSArray *)photosArray response:(response)response;


/**
 问题报修

 @param userId 用户id
 @param type 报修类型
 @param info 报修信息
 @param address 报修地址
 @param alias 别名
 @param photosArray 图片数组
 @param response 结果回调
 */
+(void)submitRepairsWithUserId:(NSNumber *)userId userTel:(NSString *)phone  userName:(NSString *)userName  spaceId:(NSNumber *)spaceId repairsType:(NSString *)type repairsInfo:(NSString *)info repairsAddress:(NSString *)address alias:(NSString *)alias photosArray:(NSArray *)photosArray response:(response)response;


/**
 发布需求（获取服务商支持）

 @param params 参数列表
 @param response 结果回调
 */
+(void)obtainSupportWithParams:(NSDictionary *)params response:(response)response;

/**
 获取二维码信息

 @param userId 用户id
 @param response 结果回调
 */
+(void)getQRcodeInfoWithUserId:(NSNumber *)userId companyId:(NSString *)companyId response:(response)response;



#pragma mark - 礼包

/**
 获取礼包信息
 @param type 礼包类型
 @param response 返回
 */
+(void)queryGiftBagListWithType:(NSString *)type response:(response)response;

/**
 通过类型查询礼包列表

 @param type 礼包类型
 @param response  返回
 */
+(void)queryGiftBagWithType:(NSString *)type response:(response)response;
 
/**
 获取支付协议

 @param response 返回结果
 */
+(void)getPayDelegateResponse:(response)response;

@end
