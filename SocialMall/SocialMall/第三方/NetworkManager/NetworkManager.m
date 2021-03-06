//
//  NetworkManager.m
//  FishingJoy
//
//  Created by expro on 14-1-9.
//  Copyright (c) 2014年 expro. All rights reserved.
//

#import "NetworkManager.h"
//#import "MyTools.h"
//#import "AA3DESManager.h"
//#import "CommeHelper.h"
#import "ViewController.h"
#import "AppDelegate.h"
//#import "DEMONavigationController.h"
#import "loginViewController.h"
//http://121.201.16.96:80/app/test
static NSString *const EPHttpApiBaseURL = AppURL;//@"http://121.201.16.96";
//static NSString *const EPHttpApiBaseURL = @"http://120.25.218.167";

@implementation NetworkManager

+ (instancetype)instanceManager
{
    static NetworkManager *_instanceManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instanceManager = [[NetworkManager alloc] init];
        _instanceManager.httpClient = [ExproHttpClient sharedClient];
        
        _instanceManager.reachability = [Reachability reachabilityWithHostName:EPHttpApiBaseURL];
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [_instanceManager.httpClient.requestSerializer setValue:[defaults objectForKey:@"sessionId"] forHTTPHeaderField:@"user_session"];
        _instanceManager.TypeDic = @{
                                     @"400001":@"手机号或密码不能为空",
                                     @"400002":@"用户不存在",
                                     @"400003":@"手机号或密码错误",
                                     @"400004":@"注册失败",
                                     @"400005":@"验证码错误",
                                     @"300001":@"上传图片类型不正确",
                                     @"300002":@"保存图片失败",
                                     @"300003":@"上传图片校验失败",
                                     @"300004":@"上传图片大小超过限制",
                                     @"400006":@"风格不能为空",
                                     @"400007":@"消息内容不能为空",
                                     @"400008":@"上传图片不能为空",
                                     @"400009":@"用户未登录",
                                     @"400010":@"短信接口错误",
                                     @"400011":@"没有好友",
                                     @"400012":@"还没登录",
                                     @"400000":@"常用错误(输出提示用)",
                                     @"400016":@"您的账户余额不足"
                                    
                                     
                                     };
        
        
    });
    
    return _instanceManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
//    Reachability *reachAblitity = [Reachability reachabilityForInternetConnection];
    Reachability *reachAblitity = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    switch ([reachAblitity currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            break;
    }
    
    return isExistenceNetwork;
}

- (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

- (BOOL) IsEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
/**
 *  请求网络接口,返回请求的响应接口,并作初期数据处理
 *
 *  @param webApi        网络请求的接口
 *  @param para          请求所带的参数
 *  @param completeBlock 成功请求后得到的响应,此响应包括服务器业务逻辑异常结果,只接收服务器业务逻辑状态码为200的结果
 *  @param errorBlock    服务器响应不正常,网络连接失败返回的响应结果
 */
- (void)requestWebWithParaWithURL:(NSString*)webApi Parameter:(NSDictionary *)para IsLogin:(BOOL)islogin Finish:(HttpResponseSucBlock)completeBlock Error:(HttpResponseErrBlock)errorBlock
{
    NSMutableDictionary * paraDic =[NSMutableDictionary dictionaryWithDictionary:para];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (islogin) {

        NSLog(@"sessionId = %@",[defaults objectForKey:@"sessionId"]);
        
        [self.httpClient.requestSerializer setValue:[defaults objectForKey:@"sessionId"] forHTTPHeaderField:@"sessionId"];
        
        if ([[defaults objectForKey:@"sessionId"] length]) {
            
            [paraDic setObject:[defaults objectForKey:@"sessionId"] forKey:@"sessionId"];
            
            //强制让数据立刻保存
            [defaults synchronize];

        }
        
        
    }
    else
    {
        //[self.httpClient.requestSerializer setValue:@"" forHTTPHeaderField:@"user_session"];
        if ([defaults objectForKey:@"sessionId"]) {
        [paraDic setObject:[defaults objectForKey:@"sessionId"] forKey:@"sessionId"];
            
        }

    }
   
   // NSString * paraStr = [self dictionaryToJson:paraDic];
   
    
    [self.httpClient POST:webApi parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
  //  DLog(@"URL:%@, 请求参数:%@, 返回值:%@",operation.request.URL,para,responseObject);
        
        NSError *parserError = nil;
        NSDictionary *resultDic = nil;
        @try {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
          //  NSLog(@"<<<<<<%@",responseString);

            
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            
            
            resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            
        }
        @catch (NSException *exception) {
            [NSException raise:@"网络接口返回数据异常" format:@"Error domain %@\n,code=%ld\n,userinfo=%@",parserError.domain,(long)parserError.code,parserError.userInfo];
            //发出消息错误的通知
        }
        @finally {
            //业务产生的状态码
            NSString *logicCode = [NSString stringWithFormat:@"%ld",[resultDic[@"status"] integerValue]];
            
            //成功获得数据
            if ([logicCode isEqualToString:@"200000"]) {
                
                completeBlock(resultDic);
                
            }
            else{
                //业务逻辑错误
                NSString *message = [resultDic objectForKey:@"message"];
                NSError *error = [NSError errorWithDomain:@"服务器业务逻辑错误" code:logicCode.intValue userInfo:nil];
                if ([message isEqualToString:@"session无效"]&&islogin) {

                                        
                                        return ;
                }
                  NSString *  key = [NSString stringWithFormat:@"%ld",[resultDic[@"status"] integerValue]];
                    message = _TypeDic[key];
                    
                    
                    if (!message ||[message length]<1) {
                        message = [resultDic objectForKey:@"message"];
                    }
                    

                
                errorBlock(nil,error,message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败
        if (![self isExistenceNetwork]) {
            NSLog(@">>>>>>%@",webApi);
            errorBlock(operation,error,@"网络有问题，请稍后再试");
        }
        else{
            errorBlock(operation,error,@"数据请求失败");
        }

    }];
}

- (void)requestWebWithParaWithURL_NotResponseJson:(NSString*)webApi Parameter:(NSDictionary *)para Finish:(HttpResponseSucBlock)completeBlock Error:(HttpResponseErrBlock)errorBlock
{
    

    [self.httpClient POST:webApi parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        NSError *parserError = nil;
        NSDictionary *resultDic = nil;
        @try {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSRange rang=[responseString rangeOfString:@"</body>"];
            NSString *html=[responseString substringWithRange:NSMakeRange(0, rang.location+rang.length)];
            NSString *data=[responseString substringFromIndex:NSMaxRange(rang)];
       
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithCapacity:2];
            
            [dict setValue:html forKey:@"html"];

            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *tempDict=[NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&err];
            
            [dict setObject:tempDict forKey:@"data"];
            
            resultDic=dict;
            
            
            
        }
        @catch (NSException *exception) {
            [NSException raise:@"网络接口返回数据异常" format:@"Error domain %@\n,code=%ld\n,userinfo=%@",parserError.domain,(long)parserError.code,parserError.userInfo];
            //发出消息错误的通知
        }
        @finally {
            //业务产生的状态码
            NSString *logicCode = [resultDic objectForKey:@"data"][@"resultCode"];
            
            //成功获得数据
            if ([logicCode isEqualToString:@"SUCCESS"]) {
                
                completeBlock(resultDic);
            }
            else{
                //业务逻辑错误
                NSString *message = [resultDic objectForKey:@"message"];
                NSError *error = [NSError errorWithDomain:@"服务器业务逻辑错误" code:logicCode.intValue userInfo:nil];
                errorBlock(nil,error,message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败
        if (![self isExistenceNetwork]) {
            
            errorBlock(operation,error,@"网络有问题，请稍后再试");
        }
        else{
            errorBlock(operation,error,@"数据请求失败");
        }
        
        
    }];
}

- (void)requestWebWithGETParaWith:(NSString*)webApi Parameter:(NSDictionary *)para IsLogin:(BOOL)islogin Finish:(HttpResponseSucBlock)completeBlock Error:(HttpResponseErrBlock)errorBlock{
    NSMutableDictionary * paraDic =[NSMutableDictionary dictionaryWithDictionary:para];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (islogin) {
        
        NSLog(@"sessionId = %@",[defaults objectForKey:@"sessionId"]);
        
        [self.httpClient.requestSerializer setValue:[defaults objectForKey:@"sessionId"] forHTTPHeaderField:@"sessionId"];
        
        if ([[defaults objectForKey:@"sessionId"] length]) {
            
            [paraDic setObject:[defaults objectForKey:@"sessionId"] forKey:@"sessionId"];
            
            //强制让数据立刻保存
            [defaults synchronize];
            
        }
        
        
    }
    else
    {
        //[self.httpClient.requestSerializer setValue:@"" forHTTPHeaderField:@"user_session"];
        if ([defaults objectForKey:@"sessionId"]) {
            [paraDic setObject:[defaults objectForKey:@"sessionId"] forKey:@"sessionId"];
            
        }
        
    }

    [self.httpClient GET:webApi parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // DLog(@"URL:%@, 请求参数:%@, 返回值:%@",operation.request.URL,para,responseObject);
        
        NSError *parserError = nil;
        NSDictionary *resultDic = nil;
        @try {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *err;
            
            
            resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
            
            
            
        }
        @catch (NSException *exception) {
            [NSException raise:@"网络接口返回数据异常" format:@"Error domain %@\n,code=%ld\n,userinfo=%@",parserError.domain,(long)parserError.code,parserError.userInfo];
            //发出消息错误的通知
        }
        @finally {
            //业务产生的状态码
            NSString *logicCode = [NSString stringWithFormat:@"%ld",[resultDic[@"status"] integerValue]];
            
            //成功获得数据
            if ([logicCode isEqualToString:@"200000"]) {
                
                completeBlock(resultDic);
                
            }
            else{
                //业务逻辑错误
                NSString *message = [resultDic objectForKey:@"message"];
                
                NSError *error = [NSError errorWithDomain:@"服务器业务逻辑错误" code:logicCode.intValue userInfo:nil];
                if ([message isEqualToString:@"session无效"]) {
                    
                    
                    return ;
                }
                
               
                    NSString *  key = [NSString stringWithFormat:@"%ld",[resultDic[@"status"] integerValue]];
                
                    message = _TypeDic[key];
                  if (!message ||[message length]<1) {
                    message = [resultDic objectForKey:@"message"];
                  }
                
                

                errorBlock(nil,error,message);
            }
        }

        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败
        if (![self isExistenceNetwork]) {
            NSLog(@">>>>>>%@",webApi);
            errorBlock(operation,error,@"网络有问题，请稍后再试");
        }
        else{
            errorBlock(operation,error,@"数据请求失败");
        }
        

        
    }];
    

    
    
    
}
//获取所有的需要的参数,暂时没用到
//- (void)getAllParamList
//{
//    [self requestWebWithParaWithURL:@"area!getFishConfig.action" Parameter:nil Finish:^(NSDictionary *resultDic) {
//        self.paramdic = resultDic;
//    } Error:^(AFHTTPRequestOperation *operation, NSError *error,NSString *description) {
//        if (error.code == 404) {
//            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"网络不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//            [alert show];
//        }
//    }];
//}



@end

@implementation ExproHttpClient

+ (instancetype)sharedClient
{
    static ExproHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ExproHttpClient alloc] initWithBaseURL:[NSURL URLWithString:EPHttpApiBaseURL]];
        
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
        //[_sharedClient.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
        //[_sharedClient.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"sign_appkey"];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
       // _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript", nil];
        
        
        
       

        
        
        
        
    });
    
    return _sharedClient;
}



@end

