//
//  FaxianViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "FaxianViewController.h"
#import "loginViewController.h"
#import "HMSegmentedControl.h"
#import "tuijianViewController.h"
#import "remenViewController.h"
#import "zuixinViewController.h"
#import "XQViewController.h"
#import "SearchViewController.h"
#import "oadMessageModel.h"
@interface FaxianViewController ()<UIScrollViewDelegate>
{
    
    HMSegmentedControl *titleSegment;
    tuijianViewController * _tuijianCtl;
    remenViewController * _remenCtl;
    zuixinViewController * _zuixinCtl;
    oadMessageModel *_oermodel;
}

@end

@implementation FaxianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //跳详情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectFXXQObj:) name:@"didSelectFXXQObjNotification" object:nil];
    //刷新提醒
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshTXData:) name:@"didRefreshTXDataObjNotification" object:nil];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 7, Main_Screen_Width - 40, 40)];
    [btn setImage:[UIImage imageNamed:@"shous"] forState:0];
    [btn addTarget:self action:@selector(ActionTime) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;//[self MCtiteView];

    
    [self prepareUI];
    [self appIsLogin];

    // Do any additional setup after loading the view.
}
#pragma mark-刷新提醒

-(void)RefreshTXData:(NSNotification*)Notification{
    
    [self loadnewMessage];
    [self loadnewnewOrder];
}

#pragma mark-检测4.20.	获取最新好友消息
-(void)loadnewMessage{
    
    [ self.requestManager requestWebWithParaWithURL:@"Msg/newMessage" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        if (resultDic[@"data"][@"newMessageId"]) {
            
            /*保存数据－－－－－－－－－－－－－－－－－begin*/
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            
            NSString *newMessageId = [defaults objectForKey:@"newMessageId"];
            if ([newMessageId isEqualToString:resultDic[@"data"][@"newMessageId"]]) {
                
                
            }
            else
            {
                [defaults setObject:resultDic[@"data"][@"newMessageId"]?resultDic[@"data"][@"newMessageId"]:@"" forKey:@"newMessageId"];
                
                [defaults setObject:@"1" forKey:@"isguanzhu"];
                
                

                //强制让数据立刻保存
                [defaults synchronize];
                [self.tabBarController.tabBar showBadgeOnItemIndex:0];

            }
        }
        
        
       
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        //
        NSLog(@"%@",description);
    }];

    
    
    
}

#pragma mark-检测4.20.	获取订单消息
-(void)loadnewnewOrder{
    
    [ self.requestManager requestWebWithParaWithURL:@"User/loadMessageType" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        if (resultDic[@"data"]) {
            
            _oermodel = [oadMessageModel mj_objectWithKeyValues:resultDic[@"data"] ];
            
            
            /*保存数据－－－－－－－－－－－－－－－－－begin*/
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            
            NSString *newOrder = [defaults objectForKey:@"newOrder"];//订单
            NSString *newNotice = [defaults objectForKey:@"newNotice"];//公告
            NSString *newComment = [defaults objectForKey:@"newComment"];//回复
            
            BOOL isdingdan = NO;
            
            
//订单
            if ([newOrder isEqualToString:_oermodel.Order]) {
                
                
            }
            else
            {
                
                isdingdan = YES;
                [defaults setObject:_oermodel.Order?_oermodel.Order:@"" forKey:@"newOrder"];
                [defaults setObject:@"1" forKey:@"Order"];

                //强制让数据立刻保存
                [defaults synchronize];
//                [self.tabBarController.tabBar showBadgeOnItem4Index:4];
                
            }
            
            
            if ([newNotice isEqualToString:_oermodel.Notice]) {
                
                
            }
            else
            {
                isdingdan = YES;

                [defaults setObject:_oermodel.Notice?_oermodel.Notice:@"" forKey:@"newNotice"];
                [defaults setObject:@"1" forKey:@"Notice"];

                //强制让数据立刻保存
                [defaults synchronize];
                //[self.tabBarController.tabBar showBadgeOnItem4Index:4];
                
            }
            

            
            
            if ([newComment isEqualToString:_oermodel.Comment]) {
                
                
            }
            else
            {
                isdingdan = YES;

                [defaults setObject:_oermodel.Comment ?_oermodel.Comment:@"" forKey:@"newComment"];
                [defaults setObject:@"1" forKey:@"Comment"];

                //强制让数据立刻保存
                [defaults synchronize];
               // [self.tabBarController.tabBar showBadgeOnItem4Index:4];
                
            }
            
            
            if (isdingdan) {
                [defaults setObject:@"1" forKey:@"isdingdan"];
                [defaults synchronize];

                [self.tabBarController.tabBar showBadgeOnItem4Index:4];
            }

            
        }

        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        //
        NSLog(@"%@",description);
        
    }];
    
    
    
    
}
-(void)appIsLogin{
    
    // [self showLoading:YES AndText:nil];
    [ self.requestManager requestWebWithParaWithURL:@"Login/appIsLogin" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        if (![resultDic[@"data"][@"isLogin"] boolValue]) {
            
            
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            
            if (![defaults objectForKey:@"sessionId"]|| ![[defaults objectForKey:@"sessionId"] length]) {
//                loginViewController * ctl = [[loginViewController alloc]init];
//                ctl.isMeCtl = YES;
//                [self pushNewViewController:ctl];
                
            }
            else
            {
                [self goin];
            }
            
        }
        else
        {
            
            [self loadnewMessage];
            [self loadnewnewOrder];

            
        }
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
//        [self showHint:description];
//        [self showAllTextDialog:@"没登录"];
//        
        NSLog(@"%@",description);
    }];
    
    
}
#pragma mark-登录
-(void)goin{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString*  _phoneStr = [defaults objectForKey:@"UserPhone"];
    NSString*  _pwdStr = [defaults objectForKey:@"Pwd"];
    NSDictionary * Parameterdic = @{
                                    @"phone":_phoneStr,
                                    @"pwd":_pwdStr
                                    };
    
    //[self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"Login/login" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"登录成功"];
        [MCUser sharedInstance].sessionId = resultDic[@"data"][@"sessionId"];
        [MCUser sharedInstance].userId = resultDic[@"data"][@"userId"];
        
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:resultDic[@"data"][@"sessionId"] forKey:@"sessionId"];
        [defaults setObject :resultDic[@"data"][@"userId"] forKey:@"userId"];
        
        [defaults setObject:_phoneStr forKey:@"UserPhone"];
        [defaults setObject:_pwdStr forKey:@"Pwd"];
        
        //强制让数据立刻保存
        [defaults synchronize];
        [self loadnewMessage];
        [self loadnewnewOrder];

        
        //13798996333
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
}

#pragma mark-监听跳详情
-(void)didSelectFXXQObj:(NSNotification*)Notification{
    
    if ([Notification.object isKindOfClass:[faXianModel class]]) {
        XQViewController * ctl = [[XQViewController alloc]init];
        ctl.faxianModel = Notification.object;
        [self pushNewViewController:ctl];

    }
    
    
    
}

-(void)prepareUI{
//      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_search_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionTime)];
//    
   // self.navigationItem.titleView = [self MCtiteView];
   
    //    添加滚动
    [self addScrollView];
    [self addtuijian];
    [self addremen];
    [self addzuixin];
     [self addSegmentView];
}
-(void)addSegmentView{
    //选择框
    titleSegment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    titleSegment.sectionTitles = @[@"推荐", @"热门",@"最新"];
    titleSegment.selectedSegmentIndex = 0;
    titleSegment.backgroundColor = [UIColor whiteColor];
    titleSegment.textColor = [UIColor darkGrayColor];
    titleSegment.selectedTextColor = AppCOLOR;
    titleSegment.font = [UIFont systemFontOfSize:16];
    titleSegment.selectionIndicatorHeight = 3;
    titleSegment.selectionIndicatorColor = AppCOLOR;
    titleSegment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    titleSegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
   
    __weak typeof(self) weakSelf = self;
//    __block typeof(NSInteger) weakisBianji = _isBianji;
    __weak typeof(tuijianViewController*) weaktui = _tuijianCtl;
    __weak typeof(remenViewController*) weakremen = _remenCtl;
    __weak typeof(zuixinViewController*) weakzuixin = _zuixinCtl;

    [titleSegment setIndexChangeBlock:^(NSInteger index) {
        weakSelf.mainScroll.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        
        if (index == 0) {
            if(!weaktui.dataArray.count){
                [weaktui load_Data:YES];
                
                
            }
        }
        if (index == 1) {
            if(!weakremen.dataArray.count){
                [weakremen load_Data:YES];
            }
            
            
        } if (index == 2) {
            if(!weakzuixin.dataArray.count){
                [weakzuixin load_Data:YES];
                
            }
            
            
        }

    }];
  
    [self.view addSubview:titleSegment];
    
    
}

- (void)addScrollView
{
    //中间View
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 44, Main_Screen_Width, Main_Screen_Height - 44 - 64 - 49)];
    self.mainScroll.contentSize = CGSizeMake(Main_Screen_Width * 3, 0);
    //self.mainScroll.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    _mainScroll.contentOffset = CGPointMake(Main_Screen_Width * 0, 0);
    self.mainScroll.delegate = self;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScroll];
    
    
}
/*
-(UIView*)MCtiteView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width , 44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    //选择框
    titleSegment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(60, 0, Main_Screen_Width-60* 2, 44)];
    titleSegment.sectionTitles = @[@"推荐", @"热门",@"最新"];
    titleSegment.selectedSegmentIndex = 0;
    titleSegment.backgroundColor = [UIColor clearColor];
    titleSegment.textColor = [UIColor whiteColor];
    titleSegment.selectedTextColor = [UIColor whiteColor];
    titleSegment.font = [UIFont systemFontOfSize:16];
    titleSegment.selectionIndicatorHeight = 3;
    titleSegment.selectionIndicatorColor = [UIColor whiteColor];
    titleSegment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    titleSegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    titleSegment.center = view.center;
    [view addSubview:titleSegment];
    __weak typeof(self) weakSelf = self;
  //  __block typeof(NSInteger) weakisBianji = _isBianji;
    
    [titleSegment setIndexChangeBlock:^(NSInteger index) {
        weakSelf.mainScroll.contentOffset =CGPointMake(index * Main_Screen_Width, 0);

    }];

    
    return view;
    
    
}
 */
#pragma mark-addRemen

-(void)addremen{
    _remenCtl = [[remenViewController alloc]init];
    [self.mainScroll addSubview:_remenCtl.view];
    
}
-(void)addtuijian{
   _tuijianCtl = [[tuijianViewController alloc]init];
    [self.mainScroll addSubview:_tuijianCtl.view];

}
-(void)addzuixin{
    
    _zuixinCtl = [[zuixinViewController alloc]init];
    [self.mainScroll addSubview:_zuixinCtl.view];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger indepage = scrollView.contentOffset.x / Main_Screen_Width;
    
    titleSegment.selectedSegmentIndex =indepage;
    if (indepage == 0) {
        if(!_tuijianCtl.dataArray.count){
            [_tuijianCtl load_Data:YES];
        }
    }
    if (indepage == 1) {
        if(!_remenCtl.dataArray.count){
            [_remenCtl load_Data:YES];
        }

        
    } if (indepage == 2) {
        if(!_zuixinCtl.dataArray.count){
            [_zuixinCtl load_Data:YES];
        }
        
 
    }
    
    
    
}
#pragma mark-搜索
-(void)ActionTime{
    SearchViewController * ctl = [[SearchViewController alloc]init];
    [self pushNewViewController:ctl];
    
    
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
