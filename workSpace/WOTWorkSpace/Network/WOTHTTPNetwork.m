//
//  WOTHTTPNetwork.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTHTTPNetwork.h"
#import "header.h"
#import "WOTLoginModel.h"
#import "WOTSpaceModel.h"
#import "WOTActivityModel.h"
#import "WOTEnterpriseModel.h"
#import "WOTNewsModel.h"
#import "WOTSliderModel.h"
#import "WOTMyFeedBackModel.h"
#import "WOTBaseModel.h"
#import "AFURLRequestSerialization.h"
#import "WOTMeetingListModel.h"
#import "WOTMeetingReservationsModel.h"
#import "WOTMyHistoryDemandsModel.h"
#import "WOTBookStationListModel.h"
#import "WOTAppointmentModel.h"
#import "WOTGetVerifyModel.h"
#import "WOTRegisterModel.h"
#import "WOTBusinessModel.h"
#import "WOTLocationModel.h"
#import "WOTServiceCategoryModel.h"
#import "WOTSendFriendsModel.h"
#import "WOTFriendsMessageListModel.h"
#import "WOTBookStationReservationsModel.h"
#import "SKBookStationNumberModel.h"
#import "QueryCircleofFriendsModel.h"
#import "WXApi.h"
#import "WOTWXPayModel.h"
#import "QuerySingleCircleofFriendModel.h"
#import "QueryCommentModel.h"
#import "SKFocusListModel.h"
#import "WOTApplyJoinEnterpriseModel.h"
#import "SKFacilitatorModel.h"
#import "WOTMeetingHistoryModel.h"
#import "WOTWorkStationHistoryModel.h"
#import "WOTCityModel.h"
#import "SKAliPayModel.h"
#import "SKOrderStringModel.h"
#import "SKSpaceInfoModel.h"
#import "SKBookStationOrderModel.h"
#import "WOTMeetingFacilityModel.h"
#import "WOTStaffModel.h"
#import "SKNewFacilitatorModel.h"
#import "SKNewSpaceModel.h"
#import "SKNewEnterpriseModel.h"
#import "SKMyActivityModel.h"
#import "SKGiftBagModel.h"

#define kMaxRequestCount 3
@interface WOTHTTPNetwork()

@property(nonatomic,assign)NSInteger requestcount;

@end
@implementation WOTHTTPNetwork
-(instancetype)init{
    self = [super init];
    if (self) {
        _requestcount = 0;
    }
    return self;
}
//网络请求
+(void)doRequestWithParameters:(NSDictionary *)parameters
                        useUrl:(NSString *)Url
                      complete:(JSONModel *(^)(id responseobj))complete
                      response:(response)response
{
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                         @"text/html",
                         @"image/jpeg",
                         @"image/png",
                         @"application/octet-stream",
                         @"text/json", nil];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    
    [manager POST:Url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"request URL:%@",task.originalRequest.URL.absoluteString);
        NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"responseStr:%@",responseStr);
        NSError *error = nil;
        NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        NSLog(@"测试：%@",responseDic);
        NSInteger statusCode = [responseDic[@"code"] integerValue];
        if (statusCode == 200) {
            if (response) {
                response(complete(responseDic),nil);
            }
        }
        else {
            if (response) {
                
                response(complete(responseDic), error);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request URL: %@-----error:%@",task.originalRequest.URL.absoluteString,error.userInfo[NSLocalizedDescriptionKey]);
        if (response) {
            response(nil, error);
        }
    }];
}


+(NSDictionary*)paramEncoding:(NSDictionary*)parameters{
    NSMutableDictionary *mutaDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    for (NSString *key in [mutaDic allKeys]) {
        NSString * strEncoding= [mutaDic[key] UrlEncodedString];
        mutaDic[key] = strEncoding;
    }
    return mutaDic;
}

//上传文件网络请求
+(void)doFileRequestWithParameters:(NSDictionary *)parameters
                            useUrl:(NSString *)Url
                             image:(NSArray<UIImage *> *)images
                          complete:(JSONModel *(^)(id responseobj))complete
                          response:(response)response {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    manager.requestSerializer.timeoutInterval = 10;
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    [manager POST:Url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        NSData *data = UIImagePNGRepresentation(images[0]);
//        
//        //上传的参数(上传图片，以文件流的格式)
//        [formData appendPartWithFileData:data
//         
//                                    name:@"file"
//         
//                                fileName:@"gauge.png"
//                                mimeType:@"image/png"];
//        
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData;
           
            imageData = UIImageJPEGRepresentation(image, 1.0f);
           
            imageData = UIImageJPEGRepresentation(image,1.f);
            if (!imageData) {
                imageData = UIImagePNGRepresentation(image);
            }
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"request URL:%@",task.originalRequest.URL.absoluteString);
        NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"responseStr:%@",responseStr);
        NSError *error = nil;
        NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        NSInteger statusCode = [responseDic[@"code"] integerValue];
        if (statusCode == 200) {
            if (response) {
                response(complete(responseDic),nil);
            }
        }
        else {
            if (response) {
                response(nil, error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request URL: %@-----error:%@",task.originalRequest.URL.absoluteString,error.userInfo[NSLocalizedDescriptionKey]);
        if (response) {
            response(nil, error);
        }
    }];
}


//登录
+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd alias:(NSString *)alias response:(response)response
{
    NSDictionary *dic = @{@"tel" :telOrEmail,
                          @"password":[WOTUitls md5HexDigestByString:pwd],
                          @"alias":alias
                          };
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/User/Login"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTLoginModel_msg *model = [[WOTLoginModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)userGetVerifyWitTel:(NSString *)tel response:(response)response
{
    NSDictionary *dic = @{@"tel" :tel};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/User/sendVerify"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTGetVerifyModel *model = [[WOTGetVerifyModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)userRegisterWitVerifyCode:(NSString *)code tel:(NSString *)tel userName:(NSString *)userName password:(NSString *)pass alias:(NSString *)alias invitationCode:(NSString *)invitationCode response:(response)response
{
    NSMutableDictionary *dic = [@{@"tel":tel,
                          @"verifyNum": code,
                          @"password":[WOTUitls md5HexDigestByString:pass],
                          @"userName":userName,
                          @"alias":alias
                          } mutableCopy];
    if (!strIsEmpty(invitationCode)) {
        [dic setValue:@"byInvitationCode " forKey:invitationCode];
    }
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/User/register"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTRegisterModel *model = [[WOTRegisterModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)updatePassWordWithVerifyCode:(NSString *)code tel:(NSString *)tel password:(NSString *)pass response:(response)response
{
    NSDictionary *dic = @{@"tel":tel,
                          @"verifyNum": code,
                          @"password":[WOTUitls md5HexDigestByString:pass]};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/User/changePassword_sendVerify"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTRegisterModel *model = [[WOTRegisterModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getUserInviteResponse:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/User/findByByInvitationCode"];
    NSDictionary * parameters =@{@"userId":[WOTUserSingleton shareUser].userInfo.userId
                                 };
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTMyInviteModel_model * stationNumberModel = [[WOTMyInviteModel_model alloc]initWithDictionary:responseobj error:nil];
        return  stationNumberModel;
    } response:response];
}

#pragma mark - 空间
+(void)getCityListResponse:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Space/findCityList"];

    [self doRequestWithParameters:nil useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTCityModel_msg * spacemodel = [[WOTCityModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  spacemodel;
    } response:response];
}

+(void)getAllSpaceWithCity:(NSString *)city block:(response)response{
    
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Space/find"];
    //在原来的基础上添加集团id
   NSMutableDictionary * parameters = [@{@"pageNo":@1,
                                         @"pageSize":@1000} mutableCopy];
    if (city) {
        [parameters setValue:city forKey:@"city"];
    }

    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTSpaceModel_msg * spacemodel = [[WOTSpaceModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  spacemodel;
        
    } response:response];
}

/**
 * 无参数获取全部空间
 */
+(void)getSpaceSitationBlock:(response)response{
    
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Space/findAllSpaceToAPP"];
    NSDictionary * parameters =nil;
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTBookStationListModel_msg * spacemodel = [[WOTBookStationListModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  spacemodel;
        
        
    } response:response];
}

+(void)getBookStationWithSpaceId:(NSNumber *)spaceId response:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Space/findStationBySpaceId"];
    NSDictionary * parameters =@{@"":spaceId};
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTBookStationListModel_msg * spacemodel = [[WOTBookStationListModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  spacemodel;
    } response:response];
}

#pragma mark - 获取指定空间id下的工位数量
+(void)getBookStationNumberWithSpaceId:(NSNumber *)spaceId time:(NSString *)time response:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/StationInfo/residueStation"];
    NSDictionary * parameters =@{@"spaceId":spaceId,
                                 @"time":time
                                 };
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        SKBookStationNumberModel * stationNumberModel = [[SKBookStationNumberModel alloc]initWithDictionary:responseobj error:nil];
        return  stationNumberModel;
    } response:response];
}

+(void)getSpaceInfoWithSpaceId:(NSNumber *)spaceId response:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Space/findNum"];
    NSDictionary * parameters =@{@"spaceId":spaceId};
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        SKSpaceInfoModel_msg * stationNumberModel = [[SKSpaceInfoModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  stationNumberModel;
    } response:response];
}

+(void)getSpaceTeamWithSpaceId:(NSNumber *)spaceId response:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Staff/find"];
    NSDictionary * parameters =@{@"spaceList":spaceId,
                                 @"staffName":@"运营经理",
                                 @"pageNo":@(1),
                                 @"pageSize":@(10),
                                 };
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTStaffModel_msg * model = [[WOTStaffModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

+(void)getSpaceFacilitiesWithSpaceId:(NSNumber *)spaceId response:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Space/findfac"];
    NSDictionary * parameters =@{@"spaceId":spaceId,
                                 };
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTMeetingFacilityModel_msg * stationNumberModel = [[WOTMeetingFacilityModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  stationNumberModel;
    } response:response];
}

+(void)appointmentSettledWithSpaceId:(NSNumber *)spaceId spaceName:(NSString *)spaceName response:(response)response
{
    NSMutableDictionary *params = [@{@"clientName":[WOTUserSingleton shareUser].userInfo.realName,
                                     @"contacts":[WOTUserSingleton shareUser].userInfo.realName,
                                     @"tel":[WOTUserSingleton shareUser].userInfo.tel,
                                     @"source":@"客户端",
                                     @"specificSource":@"APP客户端",
                                     @"will":@"一般意愿",
                                     @"stage":@"客户订单",
                                     @"spaceId":spaceId,
                                     @"spaceName":spaceName,
                                     @"leaderId":@(0),
                                     @"state":@"进行中"
                                     } mutableCopy];

    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/clientAddSell"];
    [self doRequestWithParameters:params useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTBaseModel * model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];

}

#pragma mark - 获取所有的空间列表
+(void)getSapaceFromGroupBlock:(response)response
{
    [WOTHTTPNetwork getSapaceWithPage:@1 pageSize:@1000 response:response];
}


+(void)getSapaceWithPage:(NSNumber *)page pageSize:(NSNumber *)pageSize response:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Space/find"];
    NSDictionary *parameters = @{@"pageNo":page,
                                 @"pageSize":pageSize
                                 };
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTSpaceModel_msg * spacemodel = [[WOTSpaceModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  spacemodel;
    } response:response];
}

+(void)getNewSpaceDataBlock:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/ShowList/find"];
    NSDictionary *parameters = @{@"state":@"显示",
                                 @"showClassify":@"空间"
                                 };
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        SKNewSpaceModel * spacemodel = [[SKNewSpaceModel alloc]initWithDictionary:responseobj error:nil];
        return  spacemodel;
    } response:response];
}

+(void)getSpaceWithLocation:(CGFloat)lat lon:(CGFloat)lon response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Space/findNearSpace"];
    NSDictionary * parameters = @{@"lng":@(lon),
                                  @"lat":@(lat)
                                  };
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        WOTLocationModel_Msg * activitymodel = [[WOTLocationModel_Msg alloc]initWithDictionary:responseobj error:nil];
        return  activitymodel;
    }response:response];
}

+(void)getSpaceFromSpaceID:(NSNumber *)spaceId bolock:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Space/findById"];
    NSDictionary * parameters = @{@"spaceId":spaceId};
    
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        WOTSpaceModel * model = [[WOTSpaceModel alloc]initWithDictionary:responseobj[@"msg"] error:nil];
        return  model;
    }response:response];
    
}


#pragma mark - 企业
+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/CompanyInfo/find"];
    NSDictionary * parameters = @{@"pageNo":@(1),
                                  @"pageSize":@(100)
                                  };
    
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        WOTEnterpriseModel_msg * enterprisemodel = [[WOTEnterpriseModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  enterprisemodel;
        
        
    }response:response];
}

+(void)getNewEnterprisesDataResponse:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/ShowList/find"];
    NSDictionary * parameters = @{@"state":@"显示",
                                  @"showClassify":@"企业"
                                  };
    
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        SKNewEnterpriseModel * enterprisemodel = [[SKNewEnterpriseModel alloc]initWithDictionary:responseobj error:nil];
        
        return  enterprisemodel;
        
        
    }response:response];
}

+(void)searchEnterprisesWithName:(NSString *)name response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/CompanyInfo/find"];
    NSDictionary * parameters = @{@"pageNo":@(1),
                                  @"pageSize":@(1000),
                                  @"companyName":name
                                  };
    
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        WOTEnterpriseModel_msg * enterprisemodel = [[WOTEnterpriseModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  enterprisemodel;
        
        
    }response:response];
}

+(void)getUserEnterpriseWithCompanyId:(NSString *)companyId response:(response)response{
    
    NSString *myenterpriseurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/CompanyInfo/find"];
    NSDictionary *parameters = @{@"companyIdlist":companyId,
                                 @"pageNo":@(1),
                                 @"pageSize":@(100),
                                 };
    [self doRequestWithParameters:parameters useUrl:myenterpriseurl complete:^JSONModel *(id responseobj) {
        WOTEnterpriseModel_msg * activitymodel = [[WOTEnterpriseModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  activitymodel;
    } response:response];
}

+(void)applyJoinEnterpriseWithEnterpriseId:(NSString *)enterpriseId enterpriseName:(NSString *)name response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Applyforcompany/AddApplyforcompany"];
    NSDictionary * parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                  @"userName":[WOTUserSingleton shareUser].userInfo.userName,
                                  @"userTel":[WOTUserSingleton shareUser].userInfo.tel,
                                  @"headPortrait":[WOTUserSingleton shareUser].userInfo.headPortrait,
                                  @"companyName":name,
                                  @"companyId":enterpriseId,
                                  @"applyForState":@"待处理",
                                  };
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
         WOTApplyJoinEnterpriseModel_msg *model = [[WOTApplyJoinEnterpriseModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)disposeApplyJoinEnterprise:(NSNumber *)applyId response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Applyforcompany/AddApplyforcompany"];
    NSDictionary * parameters = @{@"id":applyId,
                                  @"handlerId":[WOTUserSingleton shareUser].userInfo.userId,
                                  @"handlerName":[WOTUserSingleton shareUser].userInfo.userName,
                                  @"applyForState":@"同意",
                                  };
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        WOTApplyJoinEnterpriseModel_msg *model = [[WOTApplyJoinEnterpriseModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}


+(void)createEnterpriseWithEnterpriseName:(NSString *)enterpriseName enterpriseType:(NSString *)enterpriseType enterpriseLogo:(UIImage *)enterpriseLogo contactsName:(NSString *)contactsName contactsTel:(NSString *)tel contactsEmail:(NSString *)email response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/CompanyInfo/addCompanyInfo"];
    NSDictionary * parameters = @{@"companyName":enterpriseName,
                                  @"companyType":enterpriseType,
                                  @"contacts":contactsName,
                                  @"spaceId":@(-1),
                                  @"tel":tel,
                                  @"mailbox":email,
                                  };
    
    
    [self doFileRequestWithParameters:parameters useUrl:urlString image:@[enterpriseLogo] complete:^JSONModel *(id responseobj) {
        WOTBusinessModel *model = [[WOTBusinessModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}


+(void)getApplyJoinEnterpriseListWithEnterpriseIds:(NSString *)enterpriseIds response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Applyforcompany/find"];
    NSDictionary * parameters = @{@"companyIdlist":enterpriseIds,
                                  @"pageNo":@(1),
                                  @"pageSize":@(1000)
                                  };
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        WOTApplyJoinEnterpriseModel_msg *model = [[WOTApplyJoinEnterpriseModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}


+(void)getActivitiesWithPage:(NSNumber *)page response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Activity/findforApp"];
    NSDictionary * parameters = @{@"pageNo":page,
                                  @"pageSize":@(100)
                                  };
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        WOTActivityModel_msg * activitymodel = [[WOTActivityModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  activitymodel;
    } response:response];
}

#pragma mark - 获取我的活动
+(void)queryMyActivityWithUserTel:(NSString *)tel response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/ActivityApply/findByTel"];
    NSDictionary * parameters = @{@"applyTel":tel,
                                  @"state":@"3"
                                  };
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        SKMyActivityModel_msg * activitymodel = [[SKMyActivityModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  activitymodel;
    } response:response];
}

+(void)getNewsWithPage:(NSNumber *)page response:(response)response
{
    NSString *infourl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Message/findforApp"];
    NSDictionary * parameters = @{@"pageNo":page,
                                  @"pageSize":@(10)
                                  };
    [self doRequestWithParameters:parameters useUrl:infourl complete:^JSONModel *(id responseobj) {
        WOTNewsModel_msg *infomodel = [[WOTNewsModel_msg alloc]initWithDictionary:responseobj error:nil];
        return infomodel;
    } response:response];
}

#pragma mark - 轮播图

+(void)getHomeSliderSouceInfo:(response)response{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Proclamation/find"];
    NSDictionary *dic = @{@"pageNo":@1,
                          @"pageSize":@1000,
                          @"proclamationState":@"显示"
                          };
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTSliderModel_msg *model = [[WOTSliderModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}


+(void)getServiceBannerData:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/FacilitatorProclamation/find"];
    NSDictionary *dic = @{@"pageNo":@1,
                          @"pageSize":@1000,
                          @"proclamationState":@"显示"
                          };
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTSliderModel_msg *model = [[WOTSliderModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}




+(void)getMyHistoryFeedBackData:(NSNumber *)userId response:(response)response{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Opinion/findByUserId"];
     NSDictionary * parameters = @{@"userId":userId};
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTMyFeedBackModel_msg *model = [[WOTMyFeedBackModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)searchMemberWithName:(NSString *)name spaceId:(NSNumber *)spaceId response:(response)response
{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/User/find"];
    NSDictionary * parameters = @{@"userName":name,
                                  @"spaceId":spaceId,
                                  @"pageNo":@(1),
                                  @"pageSize":@(100)
                                  };
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTSearchModel_model *model = [[WOTSearchModel_model alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}


#pragma mark - 服务商

+(void)registerServiceBusiness:(NSNumber *)userId firmName:(NSString *)firmName businessScope:(NSString *)businessScope contatcts:(NSString *)contatcts tel:(NSString *)tel facilitatorType:(NSString *)facilitatorType facilitatorState:(NSNumber *)facilitatorState firmLogo:(NSArray<UIImage *> *)firmLogo     response:(response)response{
    
    
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Facilitator/addFacilitator"];

    NSDictionary *parameters = @{@"firmName":firmName,@"businessScope":businessScope,@"contacts":contatcts,@"tel":tel,@"facilitatorType":facilitatorType,@"facilitatorState":facilitatorState};
//    if (facilitatorState) {
//        [parameters setValue:facilitatorState forKey:@"facilitatorState"];
//
//    }
    
    
    [self doFileRequestWithParameters:parameters useUrl:registerurl image:firmLogo complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
  
}

+(void)getAllServiceTypes:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/FacilitatorLabel/findAll"];
    
    [self doRequestWithParameters:nil useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        
        WOTServiceCategoryModel_msg *model = [[WOTServiceCategoryModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getServiceProviders:(response)response
{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Facilitator/find"];
    NSDictionary *parameters = @{@"facilitatorState":@"已通过",
                                 @"pageNo":@(1),
                                 @"pageSize":@(1000),};
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        
        SKFacilitatorModel *model = [[SKFacilitatorModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getNewServiceProviders:(response)response
{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/ShowList/find"];
    NSDictionary *parameters = @{@"state":@"显示",
                                 @"showClassify":@"服务商"
                                 
                                 };
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        
        SKNewFacilitatorModel *model = [[SKNewFacilitatorModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getServiceVCServiceProviders:(response)response
{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/ShowList/find"];
    NSDictionary *parameters = @{@"state":@"显示",
                                 @"showClassify":@"服务页服务商"
                                 };
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        
        SKNewFacilitatorModel *model = [[SKNewFacilitatorModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSString *)spaceId userId:(NSString *)userId facilitatorType:(NSString *)facilitatorType facilitatorLabel:(NSString *)facilitatorLabel  response:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/GetFacilitator/addGetFacilitator"];
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:describe,@"describe",spaceId,@"spaceId",userId,@"userId",facilitatorType,@"facilitatorType",facilitatorLabel,@"facilitatorLabel",nil];
    
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}


#pragma mark - 访客

+(void)visitorAppointmentWithVisitorName:(NSString *)name sex:(NSString *)sex tel:(NSString *)tel spaceId:(NSNumber *)spaceId spaceName:(NSString *)spaceName accessType:(NSNumber *)accessType targetName:(NSString *)targetName targetId:(NSNumber *)targetId targetAlias:(NSString *)targetAlias visitorInfo:(NSString *)visitorInfo peopleNum:(NSNumber *)peopleNum visitTime:(NSString *)time response:(response)response
{
    NSDictionary *dic = @{
                          @"visitorName":name,
                          @"visitorUserId":[WOTUserSingleton shareUser].userInfo.userId,
                          @"sex":sex,
                          @"visitorTel":tel,
                          @"visitorAlias":[WOTUserSingleton shareUser].userInfo.alias,
                          @"visitorInfo":visitorInfo,
                          @"spaceId":spaceId,
                          @"spaceName":spaceName,
                          @"accessType":accessType,
                          @"targetName":targetName,
                          @"targetId":targetId,
                          @"peopleNum":peopleNum,
                          @"appointmentVisitTime":time,
                          @"infoState":@"等待答复",
                          @"targetAlias":targetAlias
                        };
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Visitor/addVisitorOrUpdate"];
    
    [self doRequestWithParameters:dic useUrl:registerurl complete:^JSONModel *(id responseobj) {
        WOTVisitorsModel *model = [[WOTVisitorsModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getMyAppointmentResponse:(response)response
{
    
    NSString *applyurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Visitor/findByUserId"];
    NSDictionary *parameters = @{
                                 @"pageNo":@(1),
                                 @"pageSize":@(1000),
                                 @"userId":[WOTUserSingleton shareUser].userInfo.userId};
    [self doRequestWithParameters:parameters useUrl:applyurl  complete:^JSONModel *(id responseobj) {
        WOTAppointmentModel_msg *model = [[WOTAppointmentModel_msg alloc]initWithDictionary:responseobj error:nil];

        return  model;
    } response:response];
}

+(void)disposeAppointmentWithVisitorId:(NSNumber *)visitorId result:(NSString *)result response:(response)response
{
    NSDictionary *dic = @{
                          @"visitorId":visitorId,
                          @"infoState":result,
                          };
    
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Visitor/addVisitorOrUpdate"];
    
    [self doRequestWithParameters:dic useUrl:registerurl complete:^JSONModel *(id responseobj) {
        WOTVisitorsModel *model = [[WOTVisitorsModel alloc] initWithDictionary:responseobj error:nil];
        if (response) {
            response(model, nil);
        }
        return model;
    } response:response];
}


+(void)addBusinessWithLogo:(UIImage *)logo name:(NSString *)name type:(NSString *)type contactName:(NSString *)contactName contactTel:(NSString *)contactTel contactEmail:(NSString *)email response:(response)response
{
    NSDictionary *dic = @{
                          @"companyName":name,
                          @"companyType":type,
                          @"contacts":contactName,
                          @"tel":contactTel,
                          @"mailbox":email,
                          };
    
    NSArray *companyPictures = nil;
    
    if (logo) {
        companyPictures = @[logo];
    }
    
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/CompanyInfo/addCompanyInfo"];
    
    [self doFileRequestWithParameters:dic useUrl:registerurl image:companyPictures complete:^JSONModel *(id responseobj) {
        WOTBusinessModel *model = [[WOTBusinessModel alloc] initWithDictionary:responseobj error:nil];
        if (response) {
            response(model,nil);
        }
        return model;
    } response:response];
}


/****************           Service        ****************************/
#pragma mark - Service
+(void)getMeetingRoomListWithSpaceId:(NSNumber *)spaceid type:(NSNumber *)type response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Conference/find"];
    NSDictionary *dic = @{@"spaceId":spaceid,
                          @"conferenceType":type,
                          @"pageNo":@(1),
                          @"pageSize":@(100),
                          @"conferenceState":@(1)
                          };
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTMeetingListModel_msg *model = [[WOTMeetingListModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
    

}

+(void)getMeetingReservationsTimeWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)strTime response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Conferencedetails/findByIdAndTime"];
    
    NSDictionary *dic = @{@"spaceId":spaceid,
                          @"conferenceId":confid,
                          @"startTime":strTime
                          };
    
//    NSDictionary *dic = @{@"spaceId":@69,
//                          @"conferenceId":@17,
//                          @"startTime":@"2017/08/04"};
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTMeetingReservationsModel_msg *model = [[WOTMeetingReservationsModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)meetingReservationsWithSpaceId:(NSNumber *)spaceid
                         conferenceId:(NSNumber *)confid
                            startTime:(NSString *)startTime
                              endTime:(NSString *)endTime
                            spaceName:(NSString *)spaceName
                          meetingName:(NSString *)meetingName
                               userId:(NSNumber *)userId
                             response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Conferencedetails/subscribyTime"];
    NSDictionary *dic = @{
                          @"spaceId":spaceid,
                          @"conferenceId":confid,
                          @"startTime":startTime,
                          @"endTime":endTime,
                          @"spaceName":spaceName,
                          @"company":meetingName,
                          @"userId":userId
                          };
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTReservationsResponseModel_msg *model = [[WOTReservationsResponseModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)siteReservationsWithSpaceId:(NSNumber *)spaceid
                      conferenceId:(NSNumber *)confid
                         startTime:(NSString *)startTime
                           endTime:(NSString *)endTime
                         spaceName:(NSString *)spaceName
                       meetingName:(NSString *) meetingName
                            userId:(NSNumber *)userId
                              body:(NSString *)body
                          response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Conferencedetails/subscribyTime1"];
    NSDictionary *dic = @{
                          @"spaceId":spaceid,
                          @"conferenceId":confid,
                          @"startTime":startTime,
                          @"endTime":endTime,
                          @"spaceName":spaceName,
                          @"company":meetingName,
                          @"userId":userId,
                          @"body":body
                          };
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTReservationsResponseModel_msg *model = [[WOTReservationsResponseModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getMeetingFacilitiesWithMeetingId:(NSNumber *)meetingId response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Conference/findfac"];
    NSDictionary *dic = @{
                          @"conferenceId":meetingId,
                          };
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTMeetingFacilityModel_msg *model = [[WOTMeetingFacilityModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}


+(void)feedBackWithSapceName:(NSString *)spaceName
                     spaceId:(NSNumber *)spaceId
                 contentText:(NSString *)contentText
                         tel:(NSString *)tel
                    response:(response)response
{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SKwork/Suggest/AddSuggest"];
    NSMutableDictionary * parameters = [@{
                                         @"spaceId":spaceId,
                                         @"spaceName":spaceName,
                                         @"complainContent":contentText
                                         } mutableCopy];
    
    if (tel) {
        [parameters setObject:tel forKey:@"tel"];
    }
    if ([WOTUserSingleton shareUser].userInfo.userId) {
        [parameters setObject:[WOTUserSingleton shareUser].userInfo.userId forKey:@"userId"];
    }
    if ([WOTUserSingleton shareUser].userInfo.userName) {
        [parameters setObject:[WOTUserSingleton shareUser].userInfo.userName forKey:@"userName"];
    }
    
    
    
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
    
}




#pragma mark - bookstation
+(void)bookStationReservationsWithSpaceId:(NSNumber *)spaceId
                                    count:(NSNumber *)count
                                startTime:(NSString *)startTime
                                  endTime:(NSString *)endTime
                                 response:(response)response
{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Station/updateMoneyStation"];
    //添加的参数字段待修改
    NSDictionary *dic = @{
                          @"spaceId":spaceId,
                          @"count":count,
                          @"rentType":@(2),
                          @"startTime":startTime,
                          @"endTime":endTime
                          };
    
    [self doRequestWithParameters:dic useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        
        WOTBookStationReservationsModel_msg *model = [[WOTBookStationReservationsModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}



//+(void)getBookStationInfoWithSpaceId:(NSNumber *)spaceid response:(response)response
//{
//    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Station/findAllStation"];
//    [self doRequestWithParameters:nil useUrl:sliderurl complete:^JSONModel *(id responseobj) {
//        WOTReservationsResponseModel_msg *model = [[WOTReservationsResponseModel_msg alloc]initWithDictionary:responseobj error:nil];//1
//        return model;
//    }response:response];
//}


+(void)getUserActivitiseWithUserId:(NSNumber *)userId state:(NSString *)state response:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/ActivityApply/findByUserId"];
    NSDictionary *parameters = @{@"userId":userId,@"state":state};
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        if ([state isEqualToString:@"0"]) {
            WOTMyActivityModel_msg *model = [[WOTMyActivityModel_msg alloc]initWithDictionary:responseobj error:nil];
            return model;
        } else {
            
            WOTActivityModel_msg * activitymodel = [[WOTActivityModel_msg alloc]initWithDictionary:responseobj error:nil];
            
            return  activitymodel;
        }
        
    } response:response];
}


+(void)getDemandsWithUserId:(NSNumber *)userId response:(response)response{
    
    NSString *demandsurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/GetFacilitator/findByUserId"];
    NSDictionary *parameters = @{@"userId":userId};
    [self doRequestWithParameters:parameters useUrl:demandsurl complete:^JSONModel *(id responseobj) {
        WOTMyHistoryDemandsModel_msg * activitymodel = [[WOTMyHistoryDemandsModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  activitymodel;
        
        
    } response:response];
}





+(void)postRepairApplyWithUserId:(NSNumber *)userId type:(NSString *)type info:(NSString *)info appointmentTime:(NSString *)appointmentTime address:(NSString *)address file:(NSArray<UIImage *> *)file alias:(NSString *)alias  response:(response)response{
    
    NSString *applyurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/MaintainInfo/addMaintainInfo"];
    NSDictionary *parameters = @{@"userId":userId,@"alias":alias,@"type":type,@"info":info,@"appointmentTime":appointmentTime,@"address":address};
    [self doFileRequestWithParameters:parameters useUrl:applyurl image:file complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

#pragma mark - 微信订单
+(void)generateOrderWithParam:(NSDictionary *)param response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Order/wxAddOrder",HTTPBaseURL];
    
    [self doRequestWithParameters:param useUrl:url  complete:^JSONModel *(id responseobj) {
        WOTWXPayModel_msg *model = [[WOTWXPayModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

#pragma mark - 工位微信订单接口
+(void)generateBookStationOrderWithParam:(NSDictionary *)param response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Order/wxAddOrder",HTTPBaseURL];
    
    [self doRequestWithParameters:param useUrl:url  complete:^JSONModel *(id responseobj) {
        SKBookStationOrderModel_msg *model = [[SKBookStationOrderModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

#pragma mark - 支付宝订单
+(void)submitAlipayOrderWith:(NSDictionary *)parm response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Order/zfbAddOrder",HTTPBaseURL];
    
    [WOTHTTPNetwork doRequestWithParameters:parm useUrl:url  complete:^JSONModel *(id responseobj) {
        SKAliPayModel_msg *model = [[SKAliPayModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

#pragma mark - 得到支付宝的OrderString
+(void)getOrderString:(NSDictionary *)parm response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Ali/produceOrderString",HTTPBaseURL];
    
    [WOTHTTPNetwork doRequestWithParameters:parm useUrl:url  complete:^JSONModel *(id responseobj) {
        SKOrderStringModel *model = [[SKOrderStringModel alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

+(void)getUserMeetingOrderResponse:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Conferencedetails/find",HTTPBaseURL];
    NSDictionary *param = @{@"pageNo":@(1),
                            @"pageSize":@(1000),
                            @"userId":[WOTUserSingleton shareUser].userInfo.userId
                            };
    [self doRequestWithParameters:param useUrl:url  complete:^JSONModel *(id responseobj) {
        WOTMeetingHistoryModel_msg *model = [[WOTMeetingHistoryModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

+(void)getUserWorkStationOrderResponse:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Order/find",HTTPBaseURL];
    NSDictionary *param = @{@"pageNo":@(1),
                            @"pageSize":@(1000),
                            @"commodityKind":@"工位",
                            @"userId":[WOTUserSingleton shareUser].userInfo.userId
                            };
    [self doRequestWithParameters:param useUrl:url  complete:^JSONModel *(id responseobj) {
        WOTWorkStationHistoryModel_msg *model = [[WOTWorkStationHistoryModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

+(void)getUserSiteOrderResponse:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Order/find",HTTPBaseURL];
    NSDictionary *param = @{@"pageNo":@(1),
                            @"pageSize":@(1000),
                            @"commodityKind":@"场地",
                            @"userId":[WOTUserSingleton shareUser].userInfo.userId
                            };
    [self doRequestWithParameters:param useUrl:url  complete:^JSONModel *(id responseobj) {
        WOTWorkStationHistoryModel_msg *model = [[WOTWorkStationHistoryModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}

#pragma mark - 支付接口
+(void)wxPayWithParameter:(WOTWXPayModel *)payModel
{
    //调用支付接口
    PayReq *payRequest = [[PayReq alloc]init];
    payRequest.partnerId = payModel.mch_id;//商户id
    payRequest.prepayId = payModel.prepay_id;//预支付订单编号
    payRequest.package = payModel.package;//商家根据财付通文档填写的数据和签名
    payRequest.nonceStr = payModel.nonce_str;//随机串，防重发
    payRequest.timeStamp = [payModel.timeStamp intValue];//时间戳，防重发
    payRequest.sign = payModel.sign;//商家根据微信开放平台文档对数据做的签名
    [WXApi sendReq:payRequest];
}

#pragma mark - 社交

+(void)sendMessageToSapceWithSpaceId:(NSNumber *)spaceId text:(NSString *)text images:(NSArray *)images response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/Share/addShare",HTTPBaseURL];
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"spaceId":spaceId,
                                 @"textWord":text,
                                 };
    
    [WOTHTTPNetwork doFileRequestWithParameters:parameters useUrl:url image:images complete:^JSONModel *(id responseobj) {
        WOTSendFriendsModel_msg *model = [[WOTSendFriendsModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getMessageBySapceIdWithSpaceId:(NSNumber *)spaceId response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/Share/findBySpaceId",HTTPBaseURL];
    NSDictionary *parameters = @{
                                 @"spaceId":spaceId,
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        WOTFriendsMessageListModel_msg *model12 = [[WOTFriendsMessageListModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model12;
    } response:response];
    
}

+(void)queryAllCircleofFriendsWithFocusPeopleid:(NSNumber *)focusPeopleid pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/CircleFriends/find",HTTPBaseURL];
    NSDictionary *parameters = @{@"pageNo":pageNo,
                                 @"pageSize":pageSize,
                                 @"focusPeopleid":focusPeopleid
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        QueryCircleofFriendsModel *model13 = [[QueryCircleofFriendsModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}

+(void)addReplyWithFriendId:(NSNumber *)friendId byReplyid:(NSNumber *)byReplyid byReplyname:(NSString *)byReplyname replyId:(NSNumber *)replyId replyName:(NSString *)replyName replyInfo:(NSString *)replyInfo replyState:(NSString *)replyState response:(response)response;

{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/ReplyRecor/addReplyRecord",HTTPBaseURL];
    NSDictionary *parameters = @{@"friendId":friendId,
                                 @"byReplyid":byReplyid,
                                 @"byReplyname":byReplyname,
                                 @"replyId":replyId,
                                 @"replyName":replyName,
                                 @"replyInfo":replyInfo,
                                 @"replyState":replyState
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model14 = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model14;
    } response:response];
}

+(void)addFocusWithfocusPeopleid:(NSNumber *)focusPeopleid befocusPeopleid:(NSNumber *)befocusPeopleid response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/FocusTable/addFocus",HTTPBaseURL];
    NSDictionary *parameters = @{@"focusPeopleid":focusPeopleid,
                                 @"BefocusPeopleid":befocusPeopleid
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model15 = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model15;
    } response:response];
}

+(void)deleteFocusWithFocusId:(NSNumber *)focusId response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/FocusTable/del",HTTPBaseURL];
    NSDictionary *parameters = @{@"focusId":focusId
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model15 = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model15;
    } response:response];
}

+(void)sendMessageWithUserId:(NSNumber *)userId userName:(NSString *)userName circleMessage:(NSString *)circleMessage photosArray:(NSArray *)photosArray response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/CircleFriends/addCircleFriends",HTTPBaseURL];
    NSDictionary *parameters = @{@"userId":userId,
                                 @"userName":userName,
                                 @"circleMessage":circleMessage
                                 };
    [self doFileRequestWithParameters:parameters useUrl:url image:photosArray complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)queryFocusCircleofFriendsWithFocusPeopleid:(NSNumber *)focusPeopleid pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/CircleFriends/findFoucsPeople",HTTPBaseURL];
    NSDictionary *parameters = @{@"pageNo":pageNo,
                                 @"pageSize":pageSize,
                                 @"focusPeopleid":focusPeopleid
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        QueryCircleofFriendsModel *model13 = [[QueryCircleofFriendsModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}

+(void)querySingleCircleofFriendsWithFriendId:(NSNumber *)friendid userid:(NSNumber *)userid response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/CircleFriends/findById",HTTPBaseURL];
    NSDictionary *parameters = @{@"friendId":friendid,
                                 @"focusPeopleid":userid
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        QuerySingleCircleofFriendModel *model13 = [[QuerySingleCircleofFriendModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}


+(void)queryMyCircleofFriendsCommentWithbyReplyid:(NSNumber *)byReplyid pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/ReplyRecor/findByBeFoucs",HTTPBaseURL];
    NSDictionary *parameters = @{@"byReplyid":byReplyid,
                                 @"pageNo":pageNo,
                                 @"pageSize":pageSize
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        QueryCommentModel *model13 = [[QueryCommentModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
    
}

+(void)queryFocusOnPeopleWithFocusPeopleid:(NSNumber *)byUserId response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/FocusTable/findfocusPeopleid",HTTPBaseURL];
    NSDictionary *parameters = @{@"focusPeopleid":byUserId
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        SKFocusListModel *model13 = [[SKFocusListModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}

+(void)querysingleCircleofFriendsWithFocusPeopleid:(NSNumber *)focusPeopleid pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize userId:(NSNumber *)userId response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/CircleFriends/find",HTTPBaseURL];
    NSDictionary *parameters = @{@"pageNo":pageNo,
                                 @"pageSize":pageSize,
                                 @"focusPeopleid":focusPeopleid,
                                 @"userId":userId
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        QueryCircleofFriendsModel *model13 = [[QueryCircleofFriendsModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}

+(void)deleteReplyRecorWithRecordId:(NSNumber *)recordId response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/ReplyRecor/del",HTTPBaseURL];
    NSDictionary *parameters = @{@"recordId":recordId
                                 };
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model13 = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}

+(void)querySingularManInfoWithUserId:(NSNumber *)userId response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/User/findById",HTTPBaseURL];
    NSDictionary *parameters = @{@"userId":userId
                                 };
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        WOTLoginModel_msg *model13 = [[WOTLoginModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}

+(void)updateUserInfoWithParameters:(NSDictionary *)parameters photosArray:(NSArray *)photosArray response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/User/addUserInfo",HTTPBaseURL];
    [self doFileRequestWithParameters:parameters useUrl:url image:photosArray complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)submitRepairsWithUserId:(NSNumber *)userId userTel:(NSString *)phone userName:(NSString *)userName  spaceId:(NSNumber *)spaceId repairsType:(NSString *)type repairsInfo:(NSString *)info repairsAddress:(NSString *)address alias:(NSString *)alias photosArray:(NSArray *)photosArray response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/MaintainInfo/addMaintainInfo",HTTPBaseURL];
    NSDictionary *parameters = @{@"userId":userId,
                                 @"type":type,
                                 @"info":info,
                                 @"address":address,
                                 @"alias":alias,
                                 @"spaceId":spaceId,
                                 @"phone":phone,
                                 @"userName":userName
                                 };
    [self doFileRequestWithParameters:parameters useUrl:url image:photosArray complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)obtainSupportWithParams:(NSDictionary *)params response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Demand/addDemand",HTTPBaseURL];
    [WOTHTTPNetwork doRequestWithParameters:params useUrl:url complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model13 = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}

+(void)getQRcodeInfoWithUserId:(NSNumber *)userId  response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/Make/addOwnerQrCode",HTTPBaseURL];
    NSDictionary *parameters = @{@"userId":userId
                                 };
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model13 = [[WOTBaseModel alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}

#pragma mark - 礼包
+(void)queryGiftBagListresponse:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/SKwork/GiftBag/findAll",HTTPBaseURL];
    [WOTHTTPNetwork doRequestWithParameters:nil useUrl:url complete:^JSONModel *(id responseobj) {
        SKGiftBagModel_msg *model13 = [[SKGiftBagModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model13;
    } response:response];
}


@end
