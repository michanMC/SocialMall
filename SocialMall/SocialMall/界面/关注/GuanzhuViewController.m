//
//  GuanzhuViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "GuanzhuViewController.h"
#import "loginViewController.h"
#import "MCNoMuiscView.h"
#import "GerenViewController.h"
#import "zuopinDataView.h"
#import "FenGuanViewController.h"
#import "XQViewController.h"
#import "faXianModel.h"
@interface GuanzhuViewController ()<UIScrollViewDelegate>
{
    
    //缺省页
    MCNoMuiscView * _noDataView;
    
    CGFloat _scrollViewSizeW;
    NSInteger indexnum;//假数据
    
    
    NSMutableArray *_arrayView;
    BOOL _isRefresh;
    NSInteger pageNum;
    
    faXianModel * _cunmodel;
}

@end

@implementation GuanzhuViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar hideBadgeOnItemIndex:0];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"isguanzhu"];
    //强制让数据立刻保存
    [defaults synchronize];
    [self appColorNavigation];
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
                loginViewController * ctl = [[loginViewController alloc]init];
                ctl.isMeCtl = YES;
                [self pushNewViewController:ctl];

            }
            else
            {
                [self goin];
            }
        
        }
        else
        {
            
            
            
        }
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];
        [self showAllTextDialog:@"没登录"];

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
    
    [self showLoading:YES AndText:nil];
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
        
[self friendShowMessage:YES];
        
        //13798996333
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self appIsLogin];
    pageNum = 0;
    _dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _arrayView = [NSMutableArray array];
    //跳个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectgerenDataObj:) name:@"didSelectgerenDataObjNotification" object:nil];
    //跳详情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectXQObj:) name:@"didSelectXQObjNotification" object:nil];

    
    //刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshData:) name:@"didRefreshDataObjNotification" object:nil];
    

    indexnum = 3;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"sessionId"]) {
        // [self prepareUI2];
        [self friendShowMessage:YES];
    }else
    {
        [self prepareUI];
    }

    
   // self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"暂时加个登录" style:UIBarButtonItemStylePlain target:self action:@selector(ActionTime)];
    // Do any additional setup after loading the view.
}
#pragma mark-监听跳详情
-(void)didSelectXQObj:(NSNotification*)Notification{
    if (Notification.object) {
        
        faXianModel * model = Notification.object;
    XQViewController * ctl = [[XQViewController alloc]init];
        ctl.faxianModel = model;
    NSLog(@"跳第%ld",(long)_index);
    [self pushNewViewController:ctl];

    }
    
}
#pragma mark-刷新数据
-(void)RefreshData:(NSNotification*)Notification{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"sessionId"]) {
        // [self prepareUI2];
        pageNum = 0;
        [_dataArray removeAllObjects];
        [self friendShowMessage:YES];
    }else
    {
        [self prepareUI];
    }
    

    
    
    
}
#pragma mark-监听跳个人信息
-(void)didSelectgerenDataObj:(NSNotification*)Notification{
    
        if (Notification.object) {

            
            like_list * model = Notification.object;
                NSString *modelStr = [NSString stringWithFormat:@"%@",model];

            if ([modelStr isEqualToString:@"1"]) {
                FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
                ctl.titleStr = @"3";
                 _index = (_scrollView.contentOffset.x  )/(Main_Screen_Width - 40);
                _cunmodel = _dataArray[_index];

                ctl.likearray = _cunmodel.like_list;
                
                
                [self pushNewViewController:ctl];
            }
            else
            {
            

    GerenViewController *ctl = [[GerenViewController alloc]init];
            ctl.user_id = model.user_id;
    [self pushNewViewController:ctl];
            }
            
        }
    
    
}

-(void)prepareUI{
    [_scrollView removeFromSuperview];

    _noDataView = [[MCNoMuiscView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 49)];
    [_noDataView.btn addTarget:self action:@selector(actionBtnFX) forControlEvents:UIControlEventTouchUpInside];

   // _noDataView.hidden = YES;
    //_noDataView.delegate = self;
    _noDataView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_noDataView];

    
    
    
    
}
- (JT3DScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[JT3DScrollView alloc]initWithFrame:CGRectMake(20, 64, Main_Screen_Width - 40, Main_Screen_Height - 64 - 49)];
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _scrollView.effect = JT3DScrollViewEffectNone;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];

    }
    return _scrollView;
}
- (MCBannerFooter *)McFooter
{
    if (!_McFooter) {
        _McFooter = [[MCBannerFooter alloc]initWithFrame:CGRectMake(0,0 , 100,0 )];
        _McFooter.backgroundColor = [UIColor whiteColor];
        _McFooter.state = ZYBannerFooterStateIdle;
        //想显示这个视图，那得让这个视图跟着tableView的滚动来进出
        //所以需要把这个视图加到tableView上
        
        //a.将label加到view上
//        [self.scrollView addSubview:_McFooter];
        
    }


    return _McFooter;
}
#pragma mark- 4.3.	好友消息接口
-(void)friendShowMessage:(BOOL)Refresh{
    
    NSDictionary * Parameterdic = @{
                                    @"page":@(pageNum)
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/friendShowMessage" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        NSArray *  messageList = resultDic[@"data"][@"messageList"];
        if (messageList.count) {
            
            _index =_dataArray.count;
            pageNum++;
            //indexnum += 2;
            
            // [self showLoading:YES AndText:nil];
            for (zuopinDataView * view in _arrayView) {
                [view removeFromSuperview];
            }
            [_arrayView removeAllObjects];
            // [self prepareUI2];
            for (NSDictionary* dic in messageList) {
                
                faXianModel * model = [faXianModel mj_objectWithKeyValues:dic];
                
                for (NSDictionary * dic1 in dic[@"like_list"]) {
                    [model addlike_listDic:dic1];
                    
                }
                [_dataArray addObject:model];
            }

            [self prepareUI2];

        }
        else if(!messageList.count && pageNum == 0){
             [self prepareUI];
        }
        _isRefresh = NO;

    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
       // [self showAllTextDialog:description];
        [self prepareUI];
        _isRefresh = NO;

        NSLog(@"失败");
        
    }];
    

    
}
-(void)prepareUI2{

    [_noDataView removeFromSuperview];
    
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < _dataArray.count; i ++) {
        [self createCardWithColor:i];
    }
    _scrollView.contentOffset = CGPointMake(_index * (Main_Screen_Width - 40), 0);
    _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (_index==0) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        
    }
   
    
    
//    if (!_McFooter) {
//        [_scrollView addSubview:self.McFooter];
//
//    }
    CGFloat width = Main_Screen_Width - 40;//CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    NSLog(@"wwww ===== %f",_dataArray.count * width+ 20);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _McFooter.frame = CGRectMake(_dataArray.count * width+ 20,0 , 100,height) ;
        
    });

    
   
}

- (void)createCardWithColor:(NSInteger)index
{
    CGFloat width = Main_Screen_Width - 40;//CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    
    CGFloat x = _arrayView.count * width;
    
    // contr = [[zuopinDataViewController alloc] initFrame:CGRectMake(x, 0, width, height)];
    zuopinDataView * zuoView = [[zuopinDataView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
    ViewRadius(zuoView, 5);
       // contr.view.backgroundColor = [UIColor yellowColor];//
    
    
    faXianModel * model = _dataArray[index];
    zuoView.delegate = self;
    [zuoView prepareUI:model];
    [_scrollView addSubview:zuoView];
    [_arrayView addObject:zuoView];
   
    _scrollView.contentSize = CGSizeMake(x + width, height);
    _scrollViewSizeW =x + width;
    
    
    
    
}
//实现滚动视图的didScroll这个协议方法，来判断是否在刷新数据
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //在这里实现下拉刷新，就是利用了tableView在上下滚动时，
    //y轴的坐标变化来控制是否刷新的
    NSLog(@"---- %f ----",scrollView.contentOffset.x);
    NSLog(@"++++ %f ++++",_scrollViewSizeW);
    NSLog(@">>>> %f ++++",scrollView.contentOffset.x + Main_Screen_Width - _scrollViewSizeW);
    if (_isRefresh) {
        //如果当控制变量显示，正在刷新的话，那么直接返回
        //防止重复刷新，
        return;
    }

    if ((scrollView.contentOffset.x + Main_Screen_Width - _scrollViewSizeW) > 70) {
        
        _McFooter.state = ZYBannerFooterStateTrigger;
        
        if (scrollView.isDragging) {
            
            NSLog(@"1");
        } else {
            _isRefresh = YES;

            [self friendShowMessage:YES ];

//            _isRefresh = YES;
//            _index =_dataArray.count;
//            pageNum++;
//            //indexnum += 2;
//            
//           // [self showLoading:YES AndText:nil];
//            for (zuopinDataView * view in _arrayView) {
//                [view removeFromSuperview];
//            }
//            [_arrayView removeAllObjects];
//           // [self prepareUI2];
//            _isRefresh = NO;
           // [self stopshowLoading];

            
            
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                NSLog(@"刷新");
//
//            });

            
        }
        
    }
    else
    {
        _McFooter.state = ZYBannerFooterStateIdle;

    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _index = (scrollView.contentOffset.x  )/(Main_Screen_Width - 40);
    if (_arrayView.count >_index ) {
        zuopinDataView * view = _arrayView[_index];
        _cunmodel = _dataArray[_index];
    }

    
//    if ( !view.isLoda) {
//        
//        view.pagrStr = 1;
//        [view loadData:YES];
//        //[view.tableView reloadData];
//    }

    
}
#pragma mark-搜索
-(void)ActionTime{
    loginViewController * ctl = [[loginViewController alloc]init];
    [self pushNewViewController:ctl];
    
    
}
#pragma mark-跳发现
-(void)actionBtnFX{
    self.navigationController.tabBarController.selectedIndex = 1;
    
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
