//
//  MCXQViewController.m
//  SocialMall
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCXQViewController.h"
#import "CLAnimationView.h"
#import "UIView+TYAlertView.h"

#import "MatchListModel.h"
#import "CommentModel.h"
#import "QX1TableViewCell.h"
#import "QX2TableViewCell.h"
#import "QX3TableViewCell.h"
#import "QX4TableViewCell.h"
#import "QX5TableViewCell.h"
#import "zuopinDataView1.h"
#import "zuopinDataView3Cell.h"
#import "liebiaoTableViewCell.h"
#import "GerenViewController.h"
#import "FenGuanViewController.h"
#import "SearchViewController.h"
#import "MallViewController.h"
#import "XMFDropBoxView.h"
#import "jubao_View.h"

@interface MCXQViewController ()<UITableViewDelegate,UITableViewDataSource,zuopinDataView3CellDelegate,XMFDropBoxViewDataSource,UITextViewDelegate>
{
    UITableView * _tableView;
    faXianModel * _XQModel;
    NSMutableArray * _MatchListArray;
    NSMutableArray * _CommentArray;

    NSInteger pagenum;
    jubao_View *shareView;

    
    UIImageView *_pinglunHeadImg;
    UIView * _pinlunBgview;
    UITextView *_pinLunTextView;
    NSString *_textViewStr;
    XMFDropBoxView *inputBox;
    UIButton * sateBtn;
    BOOL _isdanchu;
    UIButton *_zhidingBtn;


}

@end

@implementation MCXQViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _isdanchu = NO;
    
    [inputBox dismissDropBox];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    pagenum = 0;
    _CommentArray = [NSMutableArray array];
    _MatchListArray = [NSMutableArray array];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBtn)];
    sateBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 20 , 20, 40, 40)];
    [self.view addSubview:sateBtn];

    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(actioncomFooer)];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(actioncomHeader)];

    [self pinlunView];
    [self load_Data:YES];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTap:)];
    [self.view addGestureRecognizer:tap];

    // Do any additional setup after loading the view.
}
-(void)actionTap:(UITapGestureRecognizer*)tap{
    _isdanchu = NO;
    
    [inputBox dismissDropBox];
    
}
-(void)actioncomHeader{
    
    pagenum = 0;
    [self load_Data:YES];
    
    
    
}
-(void)actioncomFooer{
    
    pagenum++;
    [self showMessageComment:YES];
    
    
    
}
#pragma mark-弹框
-(void)actionBtn{
    inputBox = [XMFDropBoxView dropBoxWithLocationView:sateBtn dataSource:self];
    inputBox.backgroundColor = [UIColor blackColor];
    __weak MCXQViewController *weakSelf = self;
    [inputBox selectItemWithBlock:^(NSUInteger index) {
        //  NSLog(@"%ld", index);
        _isdanchu = NO;
        if (index == 0) {
            [weakSelf fenxiang];
        }
        else
        {
            [weakSelf actionjubao];
        }
        
    }];
    NSLog(@">>>>%ld",_isdanchu);
    
    if (_isdanchu) {
        _isdanchu = NO;
        [inputBox dismissDropBox];
    }
    else
    {
        _isdanchu = YES;
        [inputBox displayDropBox];
    }
    
    
    
    
}
- (NSUInteger)numberOfItemInDropBoxView:(XMFDropBoxView *)dropBoxView {
    return 2;
}

- (CGFloat)dropBoxView:(XMFDropBoxView *)dropBoxView heightForItemAtIndex:(NSUInteger)index {
    return 35.f;
}

- (UIView *)dropBoxView:(XMFDropBoxView *)dropBoxView itemAtIndex:(NSUInteger)index {
    
    //    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    //    btn.enabled = NO;
    //    if (index == 0) {
    //
    //
    //    [btn setImage:[UIImage imageNamed:@"share_icon"] forState:0];
    //    [btn setTitle:@"分享" forState:0];
    //    }
    //    else
    //    {
    //        [btn setImage:[UIImage imageNamed:@"report_icon1"] forState:0];
    //        [btn setTitle:@"举报" forState:0];
    //
    //    }
    //    btn.backgroundColor = [UIColor blackColor];
    //    [btn setTitleColor:[UIColor whiteColor] forState:0];
    //    btn.titleLabel.font =AppFont;
    //    return btn;
    //
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    bgview.backgroundColor = [UIColor blackColor];
    UIImageView * imgview= [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 20, 20)];
    
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    titleLB.backgroundColor = [UIColor blackColor];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.font = [UIFont systemFontOfSize:14];
    titleLB.text = @"测试";
    if (index == 0) {
        titleLB.text = @"分享";
        imgview.image = [UIImage imageNamed:@"share_icon"];
        
        //        [btn setImage:[UIImage imageNamed:@"share_icon"] forState:0];
        //        [btn setTitle:@"分享" forState:0];
    }
    else
    {
        imgview.image = [UIImage imageNamed:@"report_icon1"];
        
        titleLB.text = @"举报";
        
        //            [btn setImage:[UIImage imageNamed:@"report_icon1"] forState:0];
        //            [btn setTitle:@"举报" forState:0];
        
    }
    
    titleLB.textColor = [UIColor whiteColor];
    [bgview addSubview:titleLB];
    [bgview addSubview:imgview];
    
    
    return bgview;
}

- (CGFloat)widthInDropBoxView:(XMFDropBoxView *)dropBoxView {
    return 100.f;
}

#pragma mark-分享
-(void)fenxiang{
    
    CLAnimationView *animationView = [[CLAnimationView alloc]initWithTitleArray:@[@"朋友圈",@"微信好友"] picarray:@[@"share_friends",@"share_wechat"]];
    __weak MCXQViewController *weakSelf = self;
    
    [animationView selectedWithIndex:^(NSInteger index) {
        NSLog(@"你选择的index ＝＝ %ld",(long)index);
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        NSString * url = [NSString stringWithFormat:@"%@Msg/html5?id=%@",AppURL,_faxianModel.id ? _faxianModel.id : _faxianModel.msg_id];
        
        [dic setObject:url forKey:@"url"];
        [dic setObject:_XQModel.content forKey:@"title"];
        [dic setObject:_XQModel.style_name forKey:@"titlesub"];
        
        
        if (index == 1) {
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatTimeline PopToRoot:NO SsDic:dic];
            
        }
        else
        {
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatSession PopToRoot:NO SsDic:dic];
            
            
        }
        
        
        
        
        
        
        
    }];
    [animationView CLBtnBlock:^(UIButton *btn) {
        NSLog(@"你点了选择/取消按钮");
    }];
    [animationView show];
    
    
    
    
}
#pragma mark-举报
-(void)actionjubao{
    UIView * view = (UIView *)[self.view viewWithTag:600];
    view.hidden = YES;
    
    
    shareView= [jubao_View createViewFromNib];
    shareView.tag = 1200;
    ViewRadius(shareView.bgView2, 40);
    
    [shareView.btn addTarget:self action:@selector(actionjubaoBtn) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_XQModel.id
                                    };
    
    
    [self showLoading:YES AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/reportMessage" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        [shareView showInWindow];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
        
    }];
    
    
    
}
-(void)actionjubaoBtn{
    
    [shareView hideView];
    
    
}

-(void)pinlunView{
    
    _zhidingBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 50, Main_Screen_Height  - 49-20 - 50, 50, 50)];
    [_zhidingBtn setImage:[UIImage imageNamed:@"返回顶部"] forState:0];
    _zhidingBtn.hidden = YES;
    [_zhidingBtn addTarget:self action:@selector(releaseBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_zhidingBtn];

    
    
    
    _pinlunBgview = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height- 49, Main_Screen_Width, 49)];
    [self.view addSubview:_pinlunBgview];
    UIView * lineview= [[ UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_pinlunBgview addSubview:lineview];
    _pinlunBgview.backgroundColor = [UIColor whiteColor];
    _pinglunHeadImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 28, 28)];
    //_pinglunHeadImg.image = [UIImage imageNamed:@"Avatar_46"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *headimgurl = [defaults objectForKey:@"headimgurl"];
    
    
    [_pinglunHeadImg sd_setImageWithURL:[NSURL URLWithString:headimgurl] placeholderImage:[UIImage imageNamed:@"Avatar_46"]];
    ViewRadius(_pinglunHeadImg, 28/2);
    [_pinlunBgview addSubview:_pinglunHeadImg];
    
    
    _pinLunTextView = [[UITextView alloc]initWithFrame:CGRectMake(10 + 28 + 10, 5, Main_Screen_Width - 20 - 28 - 50, 38)];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 28 + 5, 5, Main_Screen_Width - 15 - 28 - 50, 38)];
    img.image = [UIImage imageNamed:@"Input_comment_bg"];
    [_pinlunBgview addSubview:img];
    _pinLunTextView.backgroundColor = [UIColor clearColor];
    _pinLunTextView.font = AppFont;
    _pinLunTextView.delegate =self;
    [_pinlunBgview addSubview:_pinLunTextView];
    
    
    UIButton * sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 50, 0, 50, 48)];
    [sendBtn setTitle:@"发送" forState:0];
    [sendBtn setTitleColor:UIColorFromRGB(0x29477d) forState:0];
    [sendBtn addTarget:self action:@selector(actionSend) forControlEvents:UIControlEventTouchUpInside];
    [_pinlunBgview addSubview:sendBtn];
    
}
#pragma mark-实现滚动视图的didScroll这个协议方法，来判断是否在刷新数据
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [XMFDropBoxView removeAllDropBox];

    if (scrollView.contentOffset.y < Main_Screen_Height - 64 - 48)
        _zhidingBtn.hidden = YES;
    else
    {
        _zhidingBtn.hidden = NO;
    }

    
}
-(void)releaseBtn{
    [UIView animateWithDuration:0.3 animations:^{
        _tableView.contentOffset = CGPointMake(0, 0);
        
    }];
    
    
}

#pragma mark-获取数据
-(void)load_Data:(BOOL)Refresh{
    if (!_faxianModel.id && !_faxianModel.msg_id) {
        [self showAllTextDialog:@"无效ID"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ?  _faxianModel.id :_faxianModel.msg_id
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    [self.requestManager requestWebWithGETParaWith:@"Msg/showMessageDetail" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        // [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSDictionary * messageList = resultDic[@"data"][@"messageList"];
        _XQModel =  [faXianModel mj_objectWithKeyValues:messageList];
        for (NSDictionary * dic in messageList[@"like_list"]) {
            [_XQModel addlike_listDic:dic];
            
        }
        
        if (_DataView) {
            _DataView.homeModel.like_listArray = _XQModel.like_listArray;
            [_DataView.tableView reloadData];
        }
        [self showMessageComment:NO];
        
        
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

        
    }];
    
}
#pragma mark-检查是否关注
-(void)checkFans:(BOOL)Refresh{
    if (!_faxianModel.user_id &&!_faxianModel.msg_id) {
        if (!_XQModel.user_id){
            [self isLiked:NO];
            return;
            
        }
        else
        {
            _faxianModel.user_id = _XQModel.user_id;
        }
    }
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * userid = [defaults objectForKey:@"userId"];
    NSDictionary * Parameterdic = @{
                                    @"toId":_faxianModel.user_id ?_faxianModel.user_id: _faxianModel.msg_id,
                                    @"fromId":userid?userid:@""
                                    
                                    };
    //    toId = "45",
    //    fromId = "4",
    //    toId = "36",
    //    fromId = "4",
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/checkFans" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        //[self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSDictionary * messageList = resultDic[@"data"];
        _XQModel.isFans = [messageList[@"isFans"] boolValue];
        [self isLiked:NO];
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
         [self showAllTextDialog:description];
//        [_firstViewTableView reloadData];
//        [_secondViewTableView reloadData];
//
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        NSLog(@"失败");
        
    }];
    
}

#pragma mark-获取赞
-(void)isLiked:(BOOL)Refresh{
    
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ?  _faxianModel.id :_faxianModel.msg_id
                                    };
    
    
   [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/isLiked" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
         [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        if ([resultDic[@"data"][@"isLiked"]boolValue]) {
            
            _XQModel.islike = YES;
        }
        else
        {
            _XQModel.islike = NO;
            
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [_tableView reloadData];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        //[self showAllTextDialog:description];
//        [_firstViewTableView reloadData];
//        [_secondViewTableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        NSLog(@"失败");
        
    }];
    
}
#pragma mark- 获取搭配列表
-(void)matchList:(BOOL)Refresh{
    
    if (!_faxianModel.id &&!_faxianModel.msg_id) {
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ? _faxianModel.id :_faxianModel.msg_id,
                                    };
    
    
   // [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/matchList" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        //[self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray * array = resultDic[@"data"][@"matchList"];
        if (array.count&&_MatchListArray.count==0) {
            
            for (NSDictionary * dic in array) {
                MatchListModel * model = [MatchListModel mj_objectWithKeyValues:dic];
                [_MatchListArray addObject:model];
            }
        }
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        if ([defaults objectForKey:@"sessionId"]) {
            [self checkFans:NO];//判断是否关注
        }
        else
        {
           // [self hideHud];
            //            [_firstViewTableView reloadData];
            //            [_secondViewTableView reloadData];
            
            [_tableView reloadData];
             [self isLiked:NO];
        }

        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
        
    }];
    
    
}
#pragma mark-获取评论
-(void)showMessageComment:(BOOL)Refresh{
    
    if (!_faxianModel.id &&!_faxianModel.msg_id) {
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ? _faxianModel.id :_faxianModel.msg_id,
                                    @"page":@(pagenum)
                                    };
    
    
   [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/showMessageComment" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        //[self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray * array = resultDic[@"data"][@"commentData"];
        if (array.count) {
            [_CommentArray removeAllObjects];
            for (NSDictionary * dic in array) {
                CommentModel * model = [CommentModel mj_objectWithKeyValues:dic];
                [_CommentArray addObject:model];
            }
            
        }
        [self matchList:NO];
//        [_secondViewTableView reloadData];
//        [_secondViewTableView.mj_footer endRefreshing];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
//        [_secondViewTableView.mj_footer endRefreshing];
        
        
    }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    if (indexPath.row == 0) {
        
        return 64;
    }
        if (indexPath.row == 1) {
            
            CGFloat hh;
            __block typeof (CGFloat)hhh = hh;
            
            if (!CGSizeEqualToSize(_XQModel.imageSize, CGSizeZero)) {
                hhh = Main_Screen_Width * _XQModel.imageSize.height / _XQModel.imageSize.width;
                
                
                return hhh;
            }
            
            return Main_Screen_Width;

        }
        if (indexPath.row == 2) {
            //   NSString *titleStr = @"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
            NSString *titleStr = _XQModel.content;
            
            CGFloat h = [MCIucencyView heightForString:titleStr fontSize:14 andWidth:Main_Screen_Width - 20] + 20;
            
            return h;
        }
        if (indexPath.row == 3) {
            return 50;
        }
        if (indexPath.row == 4) {
            return 44;

        }
         return 50;
   
}
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 50;
        }
        return 60;

    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            if (!_CommentArray.count)
                return 50;
        }
        else
        {
            CGFloat h = 0;
            if (_CommentArray.count > indexPath.row -1) {
                
                
                CommentModel * model = _CommentArray[indexPath.row-1];
                NSString *titleStr =model.comment;
                
                //titleStr = @"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
                h = [MCIucencyView heightForString:titleStr fontSize:14 andWidth:Main_Screen_Width - 10 - 48] ;
                
            }
            return 40 + h + 10 + .5;
        }
    }

    
    
    
    
    
    
    
    
    
     return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if ([_XQModel.like integerValue]>0) {
            return 6;

        }
        else
            return 4;
 
    }
    if (section == 1) {
        return _MatchListArray.count + 1;
    }
    if (section == 2) {
        return _CommentArray.count + 1;//评论
        
    }

    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid1 = @"zuopinDataView1";
    static NSString *cellid2 = @"QX1TableViewCell";
    static NSString *cellid3 = @"QX2TableViewCell";
    static NSString *cellid4 = @"QX3TableViewCell";
    
    static NSString *cellid5 = @"mc5";
    static NSString *cellid6 = @"zuopinDataView3Cell";
    static NSString *cellid7 = @"liebiaoTableViewCell";
    static NSString *cellid8 = @"QX4TableViewCell";
    static NSString *cellid9 = @"QX5TableViewCell";

    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            zuopinDataView1 * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid1 owner:self options:nil]lastObject];
            }
            cell.headImgBtn.tag = 90000;
            [cell.headImgBtn addTarget:self action:@selector(actionHeadbtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.headImgBtn sd_setImageWithURL:[NSURL URLWithString:_XQModel.headimgurl] forState:0 placeholderImage:[UIImage imageNamed:@"Avatar_76"]];
            ViewRadius(cell.headImgBtn, 40/2);
            
            //[cell.headImgBtn sd_setImageWithURL:<#(NSURL *)#> forState:<#(UIControlState)#> placeholderImage:<#(UIImage *)#>]
            cell.nameLbl.text = _XQModel.nickname;
            cell.timeLbl.text =  [CommonUtil daysAgoAgainst:[_XQModel.add_time longLongValue]];//[CommonUtil getStringWithLong:model.createDate Format:@"MM-dd"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.guanzhuBtn addTarget:self action:@selector(ACtionGuanzhu) forControlEvents:UIControlEventTouchUpInside];
            
            if (_XQModel.isFans) {
                [cell.guanzhuBtn setTitle:@"已关注" forState:0];
                cell.guanzhuBtn.backgroundColor = [UIColor whiteColor];
                [cell.guanzhuBtn setTitleColor:UIColorFromRGB(0x29477d) forState:0 ];
                
                
            }
            
            else
            {
                [cell.guanzhuBtn setTitle:@"关注" forState:0];
                cell.guanzhuBtn.backgroundColor = AppCOLOR;
                [cell.guanzhuBtn setTitleColor:[UIColor whiteColor] forState:0 ];
            }
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            NSString * userid = [defaults objectForKey:@"userId"];
            if ([_XQModel.user_id isEqualToString:userid]) {
                cell.guanzhuBtn.hidden = YES;
            }
            else
            {
                cell.guanzhuBtn.hidden = NO;
                
            }
            
            return cell;
            
        }
        if (indexPath.row == 1) {
            QX1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid2 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *imgUrlString = _XQModel.image;

            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:[UIImage imageNamed:@"home_default-photo"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    if (!CGSizeEqualToSize(_XQModel.imageSize, image.size)) {
                        
                        _XQModel.imageSize = image.size;
                      //  NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                        
                        //[_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }];
            
            
           // cell.contentView.backgroundColor = [UIColor yellowColor];

            return cell;
        }
        
        if (indexPath.row == 2) {
            QX2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
            if (!cell) {
                cell = [[QX2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleStr = _XQModel.content;//@"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
            return cell;
        }
        if (indexPath.row == 3) {
            QX3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid4];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid4 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString * str = [NSString stringWithFormat:@"喜欢%@",_XQModel.like?_XQModel.like:@""];
            cell.xihuanBTn.layer.borderWidth = 1;
            cell.xihuanBTn.layer.borderColor = UIColorFromRGB(0x29477d).CGColor;
            [cell.xihuanBTn setTitleColor:UIColorFromRGB(0x29477d) forState:0];
            [cell.xihuanBTn setTitle:str forState:0];
            ViewRadius(cell.xihuanBTn, 5);
            if (_XQModel.islike) {
                cell.xihuanBTn.tintColor = AppCOLOR;
                
                [cell.xihuanBTn setImage:[UIImage imageNamed:@"favorite_icon_pressed"] forState:0];
            }
            else
            {
                cell.xihuanBTn.tintColor = [UIColor lightGrayColor];
                
                [cell.xihuanBTn setImage:[UIImage imageNamed:@"favorite_icon_normal"] forState:0];
                
            }
            
            cell.bgView.tag = 600;
            
            
            
            [cell.xihuanBTn addTarget:self action:@selector(ActionDianzan) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }

            if (indexPath.row == 4) {
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid5];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid5];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.textLabel.text = [NSString stringWithFormat:@"%@人喜欢",_XQModel.like];
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = AppFont;
                return cell;
                
                
            }
            if (indexPath.row == 5) {
                zuopinDataView3Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellid6];
                if (!cell) {
                    cell = [[zuopinDataView3Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid6];
                    
                }
                cell.isQX = YES;
                [cell prepareUI:_XQModel];
                cell.deleGate =self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
                
            }
            
        
    }
    
    
    
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            QX4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid8];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid8 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;                cell.titleLbl.text = @"搭配详情";
            cell.imgView2.hidden = YES;
            cell.imgView1.hidden = NO;
            cell.sykeLbl.text = _XQModel.style_name?_XQModel.style_name:@"";
            ViewRadius(cell.sykeLbl, 5);
            cell.sykeLbl.textColor = AppCOLOR;
            cell.sykeLbl.layer.borderColor= UIColorFromRGB(0x29477d).CGColor;
            cell.sykeLbl.layer.borderWidth = 1;
            CGFloat w = [MCIucencyView  heightforString:_XQModel.style_name andHeight:25 fontSize:14];
            cell.sykeLbl.frame  = CGRectMake(Main_Screen_Width - w - 15, 7.5, w + 10, 25);
            
            cell.sykeLbl.hidden  =NO;
            [cell.seyBtn addTarget:self action:@selector(Actionsyek) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
            
        }
        
        
        liebiaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid7];
        if (!cell) {
            cell = [[liebiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid7];
        }
        //            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        if (_MatchListArray.count > indexPath.row-1) {
            MatchListModel * model = _MatchListArray[indexPath.row-1];
            
            cell.nameStr = model.goods_name;
            cell.deleBtn.hidden = YES;
            
            cell.mashuStr =[NSString stringWithFormat:@"%@ %@",model.brand_name,model.model];//model.model;// @"GAP M码";
        }
        // cell.deleBtn.tag = 800 + indexPath.row;
        // [cell.deleBtn addTarget:self action:@selector(ACtionDeleBtn:) forControlEvents:UIControlEventTouchUpInside];
        //            if (indexPath.row == _xuanzheIndedx) {
        //                cell.bgView.backgroundColor = [UIColor lightGrayColor];
        //            }
        //            else
        //            {
        cell.bgView.backgroundColor = [UIColor whiteColor];
        
        // }
        return cell;
        
        
        
        
        
    }
    
    
    
    
    
    if(indexPath.section == 2){
        if (indexPath.row == 0) {
            QX4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid8];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid8 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;                cell.titleLbl.text = [NSString stringWithFormat:@"评论(%ld)",(unsigned long)[_CommentArray count]];//@"评论(22)";
            cell.sykeLbl.hidden  =YES;
            
            if (_CommentArray.count) {
                cell.imgView1.hidden = YES;
                cell.imgView2.hidden = NO;
                
            }
            else {
                cell.imgView1.hidden = YES;
                cell.imgView2.hidden = YES;
                
            }
            cell.textLabel.font = AppFont;
            return cell;
            
        }
        else
        {
            QX5TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid9];
            if (!cell) {
                cell = [[QX5TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid9];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_CommentArray.count > indexPath.row-1) {
                
                CommentModel * model = _CommentArray[indexPath.row-1];
                NSString *titleStr =model.comment;// @"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
                cell.titleStr = titleStr;
                //  cell.headImgBtn.tag =
                [cell.headImgBtn addTarget:self action:@selector(ACtionBtnGeren:) forControlEvents:UIControlEventTouchUpInside];
                cell.headImgBtn.tag = 10000+(indexPath.row-1);
                cell.nameStr = model.nickname;
                [cell.headImgBtn sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] forState:0 placeholderImage:[UIImage imageNamed:@"Avatar_46"]];
                cell.timeStr = [CommonUtil getStringWithLong:model.add_time Format:@"yyyy.MM.dd"];//[[CommonUtil getStringWithLong:model.last_login_time] Format:@"yyyy.MM.dd"];
            }
            return cell;
            
            
        }
        
        
    }
    
    








    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 1 ){
        if (indexPath.row != 0) {
            if (_MatchListArray.count > indexPath.row-1) {
                MatchListModel * model = _MatchListArray[indexPath.row-1];
                if (model.url) {
                    MallViewController *mall = [[MallViewController alloc]init];
                    mall.isQXCtl = YES;
                    mall.menuagenturl = model.url;
                    [self pushNewViewController:mall];
                    
                    
                    
                }
                
                
                
                
            }
            
        }
        
    }
    
    if(indexPath.section == 2){
        if (indexPath.row == 0) {
        }
        else{
            if (_CommentArray.count > indexPath.row-1) {
                CommentModel * model = _CommentArray[indexPath.row-1];
                GerenViewController *ctl = [[GerenViewController alloc]init];
                ctl.user_id = model.user_id;
                
                [self pushNewViewController:ctl];
                
                
                
                
                
                
            }
        }
    }
    
    
}

#pragma mark-点击头像
-(void)actionHeadbtn:(UIButton*)btn{
    
    GerenViewController *ctl = [[GerenViewController alloc]init];
    ctl.user_id = _XQModel.user_id;
    
    [self pushNewViewController:ctl];
    
    
    
}
#pragma mark-关注
-(void)ACtionGuanzhu{
    
    
    if (!_faxianModel.id &&!_faxianModel.msg_id) {
        return;
    }
    if (!self.isgion) {
        [self showAllTextDialog:@"没登录"];
        return;
    }
    
    NSDictionary * Parameterdic = @{
                                    @"to_id":_faxianModel.user_id ? _faxianModel.user_id : _faxianModel.msg_id
                                    };
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"Friends/toFriend" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        if (_XQModel.isFans) {
            _XQModel.isFans = NO;

        }
        else
            _XQModel.isFans = YES;
        
        
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];


        //[self showAllTextDialog:@"点赞成功"];
       // [self load_Data:YES];
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
    }];
    
    
    
    
}
#pragma mark-点赞
-(void)ActionDianzan{
    if (!_faxianModel.id &&!_faxianModel.msg_id) {
        return;
    }
    if (!self.isgion) {
        [self showAllTextDialog:@"没登录"];
        return;
    }
    
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ? _faxianModel.id : _faxianModel.msg_id
                                    };
    
    
    [self showLoading:YES AndText:nil];
    
    [self.requestManager requestWebWithParaWithURL:@"Msg/messageLike" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
      //  [_DataView ActionDianzan];
        //[self isLiked:YES];
        
        //[self showAllTextDialog:@"点赞成功"];
       [self load_Data:YES];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
}
#pragma mark-赞个人信息
-(void)actionZanBtn:(BOOL)isAll likelist:(like_list *)model
{
    if (isAll) {
        
        
        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        ctl.titleStr = @"3";
        
        ctl.likearray = _XQModel.like_list;
        
        [self pushNewViewController:ctl];
        
        
        //        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        //        ctl.titleStr = @"3";
        //        [self pushNewViewController:ctl];
        //
        
    }
    else
    {
        if (model) {
            
            NSLog(@"%@",model.user_id);
            GerenViewController *ctl = [[GerenViewController alloc]init];
            ctl.user_id = model.user_id;
            
            [self pushNewViewController:ctl];
        }
    }
}
-(void)Actionsyek{
    
    // cell.sykeLbl.text = _XQModel.style_name;
    SearchViewController * ctl = [[SearchViewController alloc]init];
    ctl.sekyStr = _XQModel.style_name;
    [self pushNewViewController:ctl];
    
    
    //    //发送通知
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectTextFieldObjNotification" object:_XQModel.style_name];
    
    
}
-(void)ACtionBtnGeren:(UIButton*)btn{
    GerenViewController *ctl = [[GerenViewController alloc]init];
    if (_CommentArray.count >btn.tag - 10000 ) {
        
        
        CommentModel * model = _CommentArray[btn.tag - 10000];
        ctl.user_id = model.user_id;
        
        [self pushNewViewController:ctl];
    }
    
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    _textViewStr = textView.text;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    //    UILabel * lbl = (UILabel*)[self.view viewWithTag:600];
    //
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 76) {
        //[_tableview reloadData];
        
        
        return NO;
    }
    return YES;
    
    
}
#pragma mark-发送
-(void)actionSend{
    
    
    [_pinLunTextView resignFirstResponder];
    if (!self.isgion) {
        [self showAllTextDialog:@"没登录"];
        return;
    }
    
    if (!_pinLunTextView.text.length) {
        return;
    }
    
    if (!_faxianModel.id &&!_faxianModel.msg_id) {
        return;
    }
    
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ? _faxianModel.id : _faxianModel.msg_id,
                                    @"comment":_pinLunTextView.text
                                    };
    
    
    [self showLoading:YES AndText:nil];
    
    [self.requestManager requestWebWithParaWithURL:@"Msg/addMessageComment" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        _pinLunTextView.text = @"";
        
        [self showAllTextDialog:@"评论成功"];
        pagenum = 0;
        [self showMessageComment:YES];
        // -(void)showMessageComment:(BOOL)Refresh{
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
    
    
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
