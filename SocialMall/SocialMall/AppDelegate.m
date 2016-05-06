//
//  AppDelegate.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()
{
    
    NSTimer *_gameTimer;
    NSDate   *_gameStartTime;

    
    
    
}

@end
//高德key:ca10d0212114f9e87e5032a64284d9dd
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController * root = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    //127b916247fc9
    [ShareSDK registerApp:@"100179c96a3c3"
          activePlatforms:@[
                            
                            @(SSDKPlatformTypeWechat)//,
//                            @(SSDKPlatformSubTypeWechatTimeline)
                            
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                             
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                                    case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx7c46794efc9f160f"
                                            appSecret:@"087d653f478597fb1975fcdc0ea5cb39"];
                      break;
                  default:
                      break;
              }
          }];


    
    
    
    
    
//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //添加键盘控制
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    manager.enableAutoToolbar = YES;
    [self configureAPIKey];
    _gameTimer= [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    

    return YES;
}
// 时钟触发执行的方法
- (void)updateTimer:(NSTimer *)sender
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didRefreshTXDataObjNotification" object:@""];
}
- (void)configureAPIKey
{
    
    [MAMapServices sharedServices].apiKey = @"ca10d0212114f9e87e5032a64284d9dd";
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"应用程序进入非活跃状态（接听电话）");
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"进入后台(Home)！");
    if (_gameTimer) {
        [_gameTimer invalidate];
        _gameTimer = nil;
    }
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"进入前台！");
    if (!_gameTimer) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didRefreshTXDataObjNotification" object:@""];
            _gameTimer= [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    }
    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"应用程序启动（重启）");
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"应用程序终止时");
    
}


@end
