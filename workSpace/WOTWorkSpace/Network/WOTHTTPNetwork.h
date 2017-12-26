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
/**
 * 登录接口
 @param telOrEmail  登录账号手机号或邮箱
 @param pwd         登录密码 md5加密
 @param response    回调数据到上层
 */
+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd response:(response)response;

/**
 * 发送手机验证码
 @param tel  验证码
 @param response    回调数据到上层
 */
+(void)userGetVerifyWitTel:(NSString *)tel response:(response)response;
/**
 * 注册接口
 @param code 验证码
 @param tel  手机号注册
 @param pass 用户密码
 @param response    回调数据到上层
 */
+(void)userRegisterWitVerifyCode:(NSString *)code tel:(NSString *)tel password:(NSString *)pass response:(response)response;

/**
 * 修改密码接口
 @param code 验证码
 @param tel  手机号注册
 @param pass 用户密码
 @param response    回调数据到上层
 */
+(void)updatePassWordWithVerifyCode:(NSString *)code tel:(NSString *)tel password:(NSString *)pass response:(response)response;


/**
 * 根据城市获取所有空间接口
 @param city  城市名称 传入城市名称根据城市筛选，不传查询全部
 @param response    回调数据到上层
 */
+(void)getAllSpaceWithCity:(NSString *)city block:(response)response;
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

 @param spaceID spaceId
 @param response
 */
+(void)getBookStationWithSpaceId:(NSNumber *)spaceId response:(response)response;

/**
 通过空间id获取工位数量
 
 @param spaceId spaceId
 @param response
 */
+(void)getBookStationNumberWithSpaceId:(NSNumber *)spaceId response:(response)response;

//+(void)getSpaceWith


/**
 * 获取空间下的友邻企业
 *@param spaceid  空间id
 *@param response  对象返回上层，错误返回error
 */
+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response;

/**
 *  获取活动列表  根据页码
 *  @param page 页码/每页查询10个数据
 *  @param response 回调数据返回上层
 */
+(void)getActivitiesWithPage:(NSNumber *)page response:(response)response;


/**
 * 获取全部资讯列表
 */
+(void)getNewsWithPage:(NSNumber *)page response:(response)response;

/**
 *获取首页页面轮播图资源数据
 */

+(void)getHomeSliderSouceInfo:(response)response;

/**
 *获取服务页面轮播图资源数据
 */
+(void)getServeSliderSouceInfo:(response)response;
/**
 *获取我的历史--反馈列表数据
 @param userId  登录者用户id
 @param response 回调数据返回到上层
 */

+(void)getMyHistoryFeedBackData:(NSNumber *)userId response:(response)response;


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
 *服务--发布需求页面
 */

+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSString *)spaceId userId:(NSString *)userId facilitatorType:(NSString *)facilitatorType facilitatorLabel:(NSString *)facilitatorLabel  response:(response)response;



/**
 *提交意见反馈
 */

+(void)feedBackWithSapceName:(NSString *)spaceName spaceId:(NSNumber *)spaceId contentText:(NSString *)contentText tel:(NSString *)tel response:(response)response;


+(void)getFlexSliderSouceInfo:(response)response;


/**
 *  访客预约
 */
+(void)visitorAppointmentWithVisitorName:(NSString *)name
                            headPortrait:(UIImage *)head
                                     sex:(NSString *)sex papersType:(NSNumber *)papersType papersNumber:(NSString *)papersNumber tel:(NSString *)tel spaceId:(NSNumber *)spaceId accessType:(NSNumber*)accessType userName:(NSString *)userName visitorInfo:(NSString*)visitorInfo peopleNum:(NSNumber*)peopleNum visitTime:(NSString*)time response:(response)response;
/**
 *  添加企业
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
 @param confid 会议室id
 @param startTime 预约开始时间
 @param endTime 结束时间
 @param response 回调
 */
//+(void)meetingReservationsWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)startTime endTime:(NSString *)endTime response:(response)response;
+(void)meetingReservationsWithSpaceId:(NSNumber *)spaceid
                         conferenceId:(NSNumber *)confid
                            startTime:(NSString *)startTime
                              endTime:(NSString *)endTime
                            spaceName:(NSString *)spaceName
                          meetingName:(NSString *) meetingName
                             response:(response)response;
//TODO: 工位

/**
 获取空间工位信息

 @param spaceid 空间id
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
*我的--我的企业
 @param companyId  企业id 登录接口返回用户的companyId,字符串
*/
+(void)getUserEnterpriseWithCompanyId:(NSString *)companyId  response:(response)response;


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
 *我的历史--我的预约
 */


+(void)getMyAppointmentWithUserId:(NSNumber *)userId   response:(response)response;


#pragma mark - 订单

/**
 预定会议室、场地、工位订单
 @param response 结果回调
 */
+(void)generateOrderWithParam:(NSDictionary *)param response:(response)response;

+(void)wxPayWithParameter:(WOTWXPayModel *)payModel;


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

 @param focusId 关注信息id
 @param response 结果回调
 */
+(void)deleteFocusWithFocusId:(NSNumber *)focusId response:(response)response;


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


@end
