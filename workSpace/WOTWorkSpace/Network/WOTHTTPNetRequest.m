//
//  WOTHTTPNetRequest.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTHTTPNetRequest.h"
#import "WOTHTTPRequestProtocol.h"

#define kMaxRequestCount 3
@interface WOTHTTPNetRequest()

@property(strong,nonatomic)AFHTTPSessionManager *manager;
@property(strong,nonatomic)NSURLSessionDataTask *task;
@property(weak,nonatomic)id<WOTHTTPRequestProtocol>child;
@property(nonatomic,assign)NSInteger requestcount;
@property (assign,nonatomic)BOOL isCancel;
@end


@implementation WOTHTTPNetRequest


-(instancetype)init{
    self = [super init];
    if (self) {
        //定义了协议，要实例化协议，否则url为nil；
        if ([self conformsToProtocol:@protocol(WOTHTTPRequestProtocol)]) {
            self.child = (id<WOTHTTPRequestProtocol>)self;
        }
        
        [self configManager];
        self.requestcount = 0;
    }
    return self;
}
-(void)doRequestWithParameters:(NSDictionary *)parameters andBlock:(void (^)(id, NSError *))block{
    
    __block NSError *err = nil;
    
    if (self.isCancel) {
        err =[NSError errorWithDomain:@"WOTWorkSpace" code:-1002 userInfo:@{NSLocalizedDescriptionKey:@"请求被取消"}];
        block(nil,err);
        return;
    }
    
    self.requestcount++;
    NSDictionary *encodingparam = [self paramEncoding:parameters];
    self.task = [self.manager POST:self.child.url parameters:encodingparam progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"request URL:%@",task.originalRequest.URL.absoluteString);
      
        NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
       
        NSInteger statusCode = [[responseDic objectForKey:@"code"]integerValue];
        
        
        if(statusCode == 200)  //statusCode==200 成功
        {
            id respObj = [self.child responseObjectWithDictionary:responseDic];
            
            if (respObj == nil){
                //json转model出错
                NSError *error = [NSError errorWithDomain:@"JSONModel" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"json convert to response failed!"}];
                block(nil,error);
            }
            else{
                block(respObj,nil);
            }
        }
        else if(statusCode > 200)//20000+  失败
        {
            err =[NSError errorWithDomain:@"WOTWorkSpace" code:statusCode userInfo:@{NSLocalizedDescriptionKey:[responseDic objectForKey:@"message"]}];
            block(nil,err);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request URL: %@",task.originalRequest.URL.absoluteString);
        if(![err.localizedDescription isEqualToString:@"cancelled"])
        {
            //判断是否达到最大访问次数
            if(self.requestcount < kMaxRequestCount)
            {
                //没达到最大次数，继续请求
                [self doRequestWithParameters:parameters andBlock:block];
            }
            else
            {
                NSError *error = [NSError errorWithDomain:@"WOTWorkSpace" code:err.code userInfo:@{NSLocalizedDescriptionKey:@"网络异常，请重试"}];
                block(nil,error);
            }
        }
        else
        {
            err =[NSError errorWithDomain:@"WOTWorkSpace" code:-1002 userInfo:@{NSLocalizedDescriptionKey:@"请求被取消"}];
            block(nil,err);
        }
    }];
}


#pragma mark - private method
-(void)configManager
{
    self.manager.requestSerializer.timeoutInterval = 10.0;
    self.manager = [AFHTTPSessionManager manager];
    //设置接收文件的格式
    /**
     * instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
     */
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];

    self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    
    
}

-(void)cancel
{
    self.isCancel = YES;
    if(self.task)
    {
        [self.task cancel];
    }
    
}


-(NSDictionary*)paramEncoding:(NSDictionary*)parameters{
    NSMutableDictionary *mutaDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    for (NSString *key in [mutaDic allKeys]) {
        NSString * strEncoding= [mutaDic[key] UrlEncodedString];
        mutaDic[key] = strEncoding;
    }
    return mutaDic;
}
@end
