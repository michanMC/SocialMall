//
//  shangjiaViewController.m
//  iOS_TongFuBao_Mall
//
//  Created by MC on 15/12/9.
//  Copyright © 2015年 MacAir. All rights reserved.
//

#import "shangjiaViewController.h"
#import "WebViewJavascriptBridge.h"
#import "UIViewController+HUD.h"
#import "ACMacros.h"
#import "AppDelegate.h"
//#import "LCActionSheet.h"
#import "HClActionSheet.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "NSURLRequest+ForSSL.h"
#import "BUIView.h"

@interface shangjiaViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>{
    
    WebViewJavascriptBridge * _bridge;
    UIWebView* _webView;
    NSDictionary * _dataDic;
    NSURLRequest *_request;

    
    UIImageView * _bgImgView;
    
    
    

}
@property(nonatomic,retain)NJKWebViewProgress * progressProxy;

@property(nonatomic,retain)UIProgressView * progressView;


@end

@implementation shangjiaViewController
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden=NO;
//  //  self.tabBarController.tabBar.hidden = YES;
//    
//    
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.tabBarController.hidesBottomBarWhenPushed = YES;
//}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    _dataDic = [NSMutableDictionary dictionary];
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //监听微信分享
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinfenxianzhuantai:) name:@"didweixinfenxianzhuantaiObjNotification" object:nil];

    //self.title = @"明盛点购";
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    //将此webview与WebViewJavascriptBridge关联
    if (_bridge) { return; }
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        [self parserJsonCommand:data];
        responseCallback(@"Response for message from ObjC");
    }];
    
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.progressProxy.webViewProxyDelegate = nil;
    self.progressProxy.progressDelegate = self;
    
    CGRect  progress_view_rect = CGRectMake(0,64,Main_Screen_Width,.5);
    self.progressView = [[UIProgressView alloc] initWithFrame:progress_view_rect];
    self.progressView.progressTintColor = RGBCOLOR(36, 149, 221);
    [self.view addSubview:self.progressView];
    
    [self loadGoogle];
    _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height- 64)];
    _bgImgView.image = [UIImage imageNamed:@"noData"];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionTap:)];
    [_bgImgView addGestureRecognizer:tap];
    _bgImgView.hidden = YES;
    _bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImgView];
    // Do any additional setup after loading the view.
}


#pragma mark-开始加载
-(void)loadGoogle{
    
    NSString *urlStr = _menuagenturl;//[NSString stringWithFormat:@"%@&authorid=%@&time=%@&sign=%@",_menuagenturl,userid,times,sign];
    NSLog(@"当前WEB地址为 : %@",_menuagenturl);
    
    if (_isNoAdd) {
        urlStr =_menuagenturl;
    }
    NSURL *url=[NSURL URLWithString:urlStr];

    //利用url对象,来创建一个网络请求
    _request = [[NSURLRequest alloc] initWithURL:url
               
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
               
                                timeoutInterval:20];
    
    
    
    
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"POST"];

    //让 webView去加载请求
    [_webView loadRequest:_request];
    
    
}
#pragma mark -

#pragma mark UIWebViewDelegate 网页加载响应
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if([webView isKindOfClass:[UIWebView class]] == YES){
       // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backpop)];
       // self.navigationItem.leftBarButtonItem.style =
        if (IOS8) {
           // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationLeftBtnBack_Black_nor_"] style:UIBarButtonItemStylePlain target:self action:@selector(backpop)];
            //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backpop)];

 
        }
        
       
        
        
        self.navigationItem.rightBarButtonItem = nil;
        return [_progressProxy webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
        
    }
    
    return YES;
}
#pragma mark-当网页视图已经开始加载一个请求
-(void)webViewDidStartLoad:(id)webView {//当网页视图已经开始加载一个请求后，得到通知。
    
    NSLog(@"webViewDidStartLoad");
    if([webView isKindOfClass:[UIWebView class]] == YES){
        [_progressProxy webViewDidStartLoad:webView];
    }
    // [webView reload];
}
#pragma mark-当网页视图结束
- (void)webViewDidFinishLoad:(id )webView
{//当网页视图结束加载一个请求之后，得到通知。
    //获取当前页面的title
    //self.title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    if (!self.title) {
//        self.title = @"点购商城";
//    }
    [webView evaluateJavaScript:@"typeof TFB == 'object'" completionHandler:^(id value, NSError *error) {
        
        if ([value integerValue] == 0) {
            NSString* js_str = @"window.TFB = {};if(typeof TFB.invoke==\"undefined\"){TFB.invoke=function(){var method = arguments[0];var p1 = \"\";if (arguments.length>1){p1 = typeof arguments[1] == \"function\"?\"\"+arguments[1]:JSON.stringify(arguments[1]);}var p2 = \"\";if(arguments.length>2){p2=\"\"+arguments[2];}send_data = method + \"::TFB$@#IOS::\" + p1 + \"::TFB$@#IOS::\" + p2;window.WebViewJavascriptBridge.send(send_data, null); };if (document.createEvent) {var evt = document.createEvent('HTMLEvents');evt.initEvent('TFBJsReady', false, false);document.dispatchEvent(evt);}else if (document.createEventObject) {document.fireEvent('TFBJsReady');}}" ;
            
            [webView evaluateJavaScript:js_str completionHandler:nil];
        }
    }];
    if([webView isKindOfClass:[UIWebView class]] == YES){
        [_progressProxy webViewDidFinishLoad:webView];
    }
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    if([webView isKindOfClass:[UIWebView class]] == YES){
        [_progressProxy webView:webView didFailLoadWithError:error];
    }
    _bgImgView.hidden = NO;

    
    
}

#pragma mark-当网页视图失败
-(void)webView:(id)webView  DidFailLoadWithError:(NSError*)error{//当在请求加载中发生错误时
    
    
    
    if([webView isKindOfClass:[UIWebView class]] == YES){
        [_progressProxy webView:webView didFailLoadWithError:error];
    }
}
#pragma mark-点击重载
-(void)ActionTap:(UITapGestureRecognizer*)tap{
    
    [_webView reload];
    NSLog(@"%@",_request.URL);
    //利用url对象,来创建一个网络请求
    _request = [[NSURLRequest alloc] initWithURL:_request.URL
                
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                
                                 timeoutInterval:20];
    
    
    
    
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"POST"];
    
    //让 webView去加载请求
    [_webView loadRequest:_request];
    _bgImgView.hidden =  YES;
}
#pragma mark- 解析方法
-(void)parserJsonCommand:(NSString*)data_json{
    if(data_json == nil || data_json.length <= 0)
        return;
    
    NSArray* json_array = [data_json componentsSeparatedByString:@"::TFB$@#IOS::"];
    if(json_array == nil || json_array.count != 3)
        return;
    
    NSString*method = [json_array objectAtIndex:0];
    NSLog(@"method == %@",method);
    NSString*dataStr = [json_array objectAtIndex:1];
    NSLog(@"data == %@",dataStr);
    NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary* resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&err];
    NSString*callback = [json_array objectAtIndex:2];
    
    
    NSLog(@"callback == %@",callback);
    
    if([method isEqualToString:@"finish"]){
        NSLog(@"结束");
        [self backpop];
        
    }else if([method isEqualToString:@"confirmTip"]){
        
        NSLog(@"confirmTip");
    }else if([method isEqualToString:@"alertTip"]){
        NSLog(@"alertTip");//提示
        [self showHint:resultDic[@"msg"]];
        
    }else if([method isEqualToString:@"backButton"]){
        
        [self backButton:resultDic Callback:callback ];
        
    }else if([method isEqualToString:@"goButton"]){
        
        [self goButton:resultDic Callback:callback ];
        
    }else if([method isEqualToString:@"updateTitle"]){
        
        [self updateTitle:resultDic Callback:callback ];
    }
    else if([method isEqualToString:@"selectItem"]){
        
        [self selectItem:resultDic Callback:callback ];
    }
    else if([method isEqualToString:@"activityGo"]){
        NSLog(@"商品详情");
        [self activityGo:resultDic Callback:callback ];
        
        
    }
    else if([method isEqualToString:@"share"]){
        NSLog(@"分享");
        
        
    }


    
    else {
        NSLog(@"\n\n收到不明指令 %@\n\n" ,method);
        
    }
}
#pragma mark -  activityGo
-(void)activityGo:(NSDictionary*) option  Callback :(NSString*)callback {
    
    NSLog(@"%@",option[@"para"][@"id"]);

  //  return;
    
    
    
}

#pragma mark-goButton
-(void)goButton:(NSDictionary*) option  Callback :(NSString*)callback {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:option[@"text"] style:UIBarButtonItemStylePlain target:self action:@selector(goButton)];
    [_dataDic setValue:callback forKey:@"goButton_Callback"];
    
}
#pragma mark-updateTitle
-(void)updateTitle:(NSDictionary*) option  Callback :(NSString*)callback {
    
    self.title = option[@"title"];
}
#pragma mark-backButton
-(void)backButton:(NSDictionary*) option  Callback :(NSString*)callback {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationLeftBtnBack_Black_nor_"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton)];
    
    [_dataDic setValue:callback forKey:@"BackBtn_Callback"];
    
}
#pragma mark-selectItem
-(void)selectItem:(NSMutableDictionary*) option  Callback :(NSString*)callback {
    
    NSMutableArray *_textArray = [NSMutableArray array];
    NSArray *itemsArray = option[@"items"];
    for (NSDictionary * dic in itemsArray) {
        [_textArray addObject:dic[@"text"]];
        
    }
    if (_textArray.count) {
        
        HClActionSheet * actionSheet = [[HClActionSheet alloc] initWithTitle:nil style:HClSheetStyleDefault itemTitles:_textArray];
        actionSheet.delegate = self;
        actionSheet.tag = 100;
        // actionSheet.titleTextColor = [UIColor redColor];
        actionSheet.itemTextColor = [UIColor blackColor];
        actionSheet.cancleTextColor = RGBCOLOR(36, 149, 221);
        actionSheet.cancleTitle = @"取消选择";
        __weak typeof(self) weakSelf = self;
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
            
            NSLog(@"block----%ld----%@", (long)index, title);
            if (itemsArray.count > index) {
                
                NSError *parseError = nil;
                
                [option setValue:itemsArray[index] forKey:@"item"];
                [option removeObjectForKey:@"items"];
                // NSLog(@"option === %@",option);
                NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:option options:NSJSONWritingPrettyPrinted error:&parseError];
                
                NSString * data2 =  [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
                //  NSLog(@"data2 === %@",data2);
                
                
                NSString * str = [NSString stringWithFormat:@"_tfbjson_=%@;_tfbjson_.call(this,%@);",callback,data2];
                
                NSLog(@"str >>>>%@",str);
                
                [weakSelf ExecuteJavascript:str];
            }
            
        }];
    }
    
}
#pragma mark-触发leftBarButtonItem
-(void)backButton{
    //[self showHint:@"返回"];
    if ([_dataDic[@"BackBtn_Callback"] length]) {
        NSString* js_str = [NSString stringWithFormat:@"_tfbjson_= %@;_tfbjson_.call(this);",_dataDic[@"BackBtn_Callback"]];
        [self ExecuteJavascript:js_str];
    }
    
}
#pragma mark-触发rightBarButtonItem
-(void)goButton{
    
    if ([_dataDic[@"goButton_Callback"] length]) {
        NSString* js_str = [NSString stringWithFormat:@"_tfbjson_= %@;_tfbjson_.call(this);",_dataDic[@"goButton_Callback"]];
        [self ExecuteJavascript:js_str];
    }
    
    
}
#pragma mark-oc传值->js

-(void)ExecuteJavascript:(NSString*) js_str{
    
    if(js_str!=nil && js_str.length >0){
        
        [_webView evaluateJavaScript:js_str completionHandler:nil];
    }
}

-(void)backpop{
    if([_webView canGoBack]){
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
       // [self backpop];
        
    }

    //[self.navigationController popViewControllerAnimated:YES];
    
}
-(void)add{
    
    
}
#pragma mark - NJKWebViewProgressDelegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress <= 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
        ;
        self.progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            self.progressView.alpha = 1.0;
        }];
    }
    
    if (progress >= 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
            self.progressView.alpha = 0.0;
        } completion:nil];
    }
    
    [self.progressView setProgress:progress animated:NO];
}
-(void)wxShare:(int)WXScene  WXtitle:(NSString*)wxtitle WXdescription:(NSString*)wxdescription WXwebpageUrl:(NSString*)wxwebpageUrl imgUrlStr:(NSString*)imgStr{
    //[message setThumbImage:[]//图片
    
}
-(void)weixinfenxianzhuantai:(NSNotification*)Notification{
    if ([Notification.object isEqualToString:@"0"]) {
        [self showAllTextDialog:@"分享成功"];
    }
    if ([Notification.object isEqualToString:@"1"]) {
        [self showAllTextDialog:@"分享失败"];
    }
    if ([Notification.object isEqualToString:@"2"]) {
        [self showAllTextDialog:@"已取消分享"];
    }

    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
