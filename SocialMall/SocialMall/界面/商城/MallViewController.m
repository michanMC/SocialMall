//
//  MallViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MallViewController.h"
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
#import "MeViewController.h"
#import "loginViewController.h"
@interface MallViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate,UIScrollViewDelegate>{
    
    WebViewJavascriptBridge * _bridge;
    UIWebView* _webView;
    NSDictionary * _dataDic;
    NSMutableURLRequest *_request;
    
    
    UIImageView * _bgImgView;
    CGFloat _lastPosition;
    
    UIView *_barView;
    
}
@property(nonatomic,retain)NJKWebViewProgress * progressProxy;

@property(nonatomic,retain)UIProgressView * progressView;




@end

@implementation MallViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //跳登录
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:@"didSelectDLNotificationMall" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reqLoadData:) name:@"didDataNotificationMall" object:nil];
    }
    return self;
}
-(void)login:(NSNotification*)Notification{
    
    loginViewController * ctl = [[loginViewController alloc]init];
    ctl.isMeCtl = YES;
    [self pushNewViewController:ctl];
    
    
}
-(void)reqLoadData:(NSNotification*)Notification{
    [self loadGoogle];
    
    
}

-(void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    
    
    NSUInteger direction = swipe.direction;
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:

            break;
        case UISwipeGestureRecognizerDirectionUp:
           // self.tabBarController.tabBar.hidden=YES;
            [self hiddenbarView];

            
            break;
        case UISwipeGestureRecognizerDirectionDown:
            //self.tabBarController.tabBar.hidden=NO;
            [self showBarView];
            
            break;
        case UISwipeGestureRecognizerDirectionRight:
            break;
    }
    NSLog(@"%d",swipe.direction);
    NSLog(@"%@",swipe.view);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 25) {
        _lastPosition = currentPostion;
        NSLog(@"ScrollUp now");
       // self.tabBarController.tabBar.hidden=YES;
        [self hiddenbarView];
    }
    else if (_lastPosition - currentPostion > 25)
    {
        _lastPosition = currentPostion;
        NSLog(@"ScrollDown now");
        [self showBarView];
       // self.tabBarController.tabBar.hidden=NO;

        
    }
}
-(void)prepareTbarView{
    _barView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 49, Main_Screen_Width, 49)];
    _barView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_barView];
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 49)];
    imgview.image = [UIImage imageNamed:@"tbarView"];
    [_barView addSubview:imgview];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = Main_Screen_Width / 5;
    CGFloat hieght = 49;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    for (int i = 0; i < 5; i ++) {
       
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, hieght)];
        btn.tag = 9000+i;
        [_barView addSubview:btn];
        [btn addTarget:self action:@selector(actionBarBtn:) forControlEvents:UIControlEventTouchUpInside];
         x += width;
    }
    
    
    
    
}
-(void)actionBarBtn:(UIButton*)btn{
    
    NSLog( @"%d",btn.tag - 9000);
    
    
    [self hiddenbarView];
    
    
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[MallViewController class]] ||[vc isKindOfClass:[MeViewController class]]
            ) {
            //设置tabBarController的下标 0:首页
            vc.tabBarController.selectedIndex = btn.tag - 9000;
            //跳转到订单列表
            [self.navigationController popToViewController:vc animated:NO];
            
            
            
        }
    }

//    if (btn.tag - 9000 == 4 && _menuagenturl) {
//        
//        
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    else
    // self.tabBarController.selectedIndex =btn.tag - 9000 ;
    
}
-(void)showBarView{
    
    [UIView animateWithDuration:.5 animations:^{
        
        _barView.frame = CGRectMake(0, Main_Screen_Height - 49, Main_Screen_Width, 49);
        
        
    }];
    
    
}
-(void)hiddenbarView{
    [UIView animateWithDuration:.5 animations:^{
        
        _barView.frame = CGRectMake(0, Main_Screen_Height , Main_Screen_Width, 49);
        
        
    }];

    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden = YES;
    [self prepareTbarView];

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBarHidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AppCOLOR;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 20)];
    view.backgroundColor = AppCOLOR;
    [self.view addSubview:view];
    _dataDic = [NSMutableDictionary dictionary];
    self.view.backgroundColor =[UIColor whiteColor];
  //  self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.title = @"商城";
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, Main_Screen_Width, Main_Screen_Height - 20)];
    _webView.scrollView.bounces = NO;
    _webView.scrollView.delegate = self;
    _webView.backgroundColor = AppCOLOR;//[UIColor whiteColor];
    [self.view addSubview:_webView];
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
    
    
    //将此webview与WebViewJavascriptBridge关联
    if (_bridge) { return; }
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        [self parserJsonCommand:data];
        
        
        responseCallback(@"Response for message from ObjC");
    }];
    [_bridge registerHandler:@"getSessionId" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.progressProxy.webViewProxyDelegate = nil;
    self.progressProxy.progressDelegate = self;
    
    CGRect  progress_view_rect = CGRectMake(0,20,Main_Screen_Width,.5);
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
-(NSString*)getSessionId{
    
    
    
    return nil;
    
    
}
#pragma mark-开始加载
-(void)loadGoogle{
    
    
    if (!_menuagenturl) {
        _menuagenturl = @"http://snsshop.111.xcrozz.com/Shop";


    }
    NSLog(@"当前WEB地址为 : %@",_menuagenturl);

    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *body = [NSString stringWithFormat: @"sessionId=%@", [defaults objectForKey:@"sessionId"]];
    NSString * maurl = [NSString stringWithFormat:@"%@?%@",_menuagenturl,body];
    NSURL *url=[NSURL URLWithString:maurl];

    _request = [[NSMutableURLRequest alloc]initWithURL: url];

    [_webView loadRequest:_request];

    //让 webView去加载请求
   // [_webView loadRequest:_request];
    
    
}
#pragma mark -

#pragma mark UIWebViewDelegate 网页加载响应
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString*urlstr = request.URL.absoluteString;
    
    NSURL *url = [_request URL];
    if([[url scheme] isEqualToString:@"devzeng"]) {
        
        [self showAllTextDialog:@"devzeng"];
        //处理JavaScript和Objective-C交互
        if([[url host] isEqualToString:@"login"]){
            NSLog(@"登录");
            NSLog(@"url ==== %@",url);
            
        }
            }
    NSDictionary* dic = [request allHTTPHeaderFields];
    //判断请求中有没有自己定义的字段，没有就把现有请求停止，构造个新的请求，把自定义的字段加进去，然后加载
    
    
    if([webView isKindOfClass:[UIWebView class]] == YES){
        return [_progressProxy webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
        
    }
    
    return YES;
}
#pragma mark-当网页视图已经开始加载一个请求
-(void)webViewDidStartLoad:(id)webView {//当网页视图已经开始加载一个请求后，得到通知。
    //self.tabBarController.tabBar.hidden=NO;
    [self showBarView];
    NSLog(@"webViewDidStartLoad");
    
    if([webView isKindOfClass:[UIWebView class]] == YES){
        [_progressProxy webViewDidStartLoad:webView];
    }
    // [webView reload];
}
#pragma mark-当网页视图结束
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //self.tabBarController.tabBar.hidden=YES;
    [self hiddenbarView];
    NSCachedURLResponse *resp = [[NSURLCache sharedURLCache] cachedResponseForRequest:webView.request];
    NSLog(@"%@",[(NSHTTPURLResponse*)resp.response allHeaderFields]);
    
    
    
    if([webView isKindOfClass:[UIWebView class]] == YES){
        [_progressProxy webViewDidFinishLoad:webView];
    }
//    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [myCookie cookies]) {
//        NSLog(@"cookie == %@", cookie);//t7okttoqhae8fdhi0kk3sv8f12
//            //09a0p2l6ik1u9r33abjgfhcsn4
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie]; // 保存
//    }
    
    
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
    
    
    self.tabBarController.tabBar.hidden=NO;

    if([webView isKindOfClass:[UIWebView class]] == YES){
        [_progressProxy webView:webView didFailLoadWithError:error];
    }
}
#pragma mark-点击重载
-(void)ActionTap:(UITapGestureRecognizer*)tap{
    
    [_webView reload];
    NSLog(@"%@",_request.URL);
    //利用url对象,来创建一个网络请求
    _request =[[NSMutableURLRequest alloc]initWithURL:_request.URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    
    
    
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
