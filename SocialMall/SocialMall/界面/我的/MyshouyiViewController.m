//
//  MyshouyiViewController.m
//  SocialMall
//
//  Created by MC on 15/12/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MyshouyiViewController.h"
#import "HHHorizontalPagingView.h"
#import "headView.h"
#import "MCseleButton.h"
#import "allTableView.h"
#import "shouruTableView.h"
#import "tixianTableView.h"
#import "MyshouyiBtn.h"
#import "UserFinanceModel.h"
#import "userDatamodel.h"
@interface MyshouyiViewController ()<UITextFieldDelegate>
{
    HHHorizontalPagingView *pagingView;
    headView * _headView;
    allTableView *_quanbuTableView;
    shouruTableView *_shouruTableView;
    tixianTableView *_tixianTableView;

    UITextField * _tixianText;
    
    
    UserFinanceModel *_FinanceModel;
    userDatamodel *_usermodel;
    NSString *ali_account;
    
}
//@property (nonatomic,strong) NetworkManager *requestManager;

@end

@implementation MyshouyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的收益";
//    _requestManager = [NetworkManager instanceManager];
//    _requestManager.needSeesion = YES;
//
    

    _headView = [self head_View];
    

    _quanbuTableView = [allTableView contentTableView];
    _shouruTableView = [shouruTableView contentTableView];

    _tixianTableView = [tixianTableView contentTableView];

    
    //[self prepareUI];

    
    [self loadaData2:YES];
    [self loadAliAccount];
    [_quanbuTableView loadData];
    //_quanbuTableView.contentOffset = CGPointMake(0, -100);

    [_shouruTableView loadData];

    [_tixianTableView loadData];

    // Do any additional setup after loading the view.
}
#pragma mark-获取个人信息
-(void)loadaData2:(BOOL)Refresh{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString * userId = [defaults objectForKey:@"userId"];
    
    
    NSDictionary * Parameterdic = @{
                                    @"userId":userId
                                    };
    
    [self showHudInView:self.view hint:nil];
    
    [self.requestManager requestWebWithGETParaWith:@"User/userInfo" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
       // [self hideHud];
        
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        _usermodel = [userDatamodel mj_objectWithKeyValues:resultDic[@"data"][@"data"]];
//        [self checkFans:YES];
        
        //_headView.zhanshiLbl.text = _usermodel.messages;
        
        [self loadaData:NO];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];
        NSLog(@"失败");
        
    }];
    
    
    
}
#pragma mark-获取个人支付宝

-(void)loadAliAccount{
    
    
    [self.requestManager requestWebWithParaWithURL:@"User/loadAliAccount" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        NSLog(@"返回==%@",resultDic);
        ali_account = resultDic[@"ali_account"];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];

    }];
    
}
#pragma mark-获取个人金钱信息
-(void)loadaData:(BOOL)Refresh{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
//    if (!_user_id) {
//        return;
//        
//        
//    }
    NSString * userId = [defaults objectForKey:@"userId"];
    
    
    NSDictionary * Parameterdic = @{
                                    @"userId":userId
                                    };
    
    
   // [self showLoading:Refresh AndText:nil];
    
    [self.requestManager requestWebWithGETParaWith:@"User/getUserFinanceDetail" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        
       _FinanceModel = [UserFinanceModel mj_objectWithKeyValues:resultDic[@"data"][@"data"]];
//        [self checkFans:YES];
        
        //_headView.zhanshiLbl.text = _usermodel.messages;
    [_headView.headBtn sd_setImageWithURL:[NSURL URLWithString:_usermodel.headimgurl] forState:0 placeholderImage:[UIImage imageNamed:@"Avatar_136"]];
        
        
        ViewRadius(_headView.headBtn, 34);
        _headView.sexLbl.text = [_usermodel.sex isEqualToString:@"0"]? @"男":@"女";
        _headView.namelbl.text =  _usermodel.nickname;
        _headView.qianmingLbl.text = [NSString stringWithFormat:@"%@",_usermodel.autograph];
        _headView.zongshuoyiLbl.text = [NSString stringWithFormat:@"￥%@",_FinanceModel.history_money];
//        MyshouyiBtn *segmentButton = [self.view viewWithTag:20000];
//        segmentButton.titleSubLbl.text = _FinanceModel.history_money;
//        segmentButton = [self.view viewWithTag:20001];
//        segmentButton.titleSubLbl.text = _FinanceModel.history_money;
//        segmentButton = [self.view viewWithTag:20002];
//        segmentButton.titleSubLbl.text = _FinanceModel.withdrawing;
        [self prepareUI];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];

        NSLog(@"失败");
        
    }];
    
    
    
}

-(void)prepareUI{
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    NSMutableArray *ViewArray = [NSMutableArray array];
    
    for(int i = 0; i < 3; i++) {
        MyshouyiBtn *segmentButton ;//= [MyshouyiBtn buttonWithType:UIButtonTypeCustom];
        // MyshouyiBtn *segmentButton =
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 60)];
        if (i == 0) {
            
            segmentButton = [[MyshouyiBtn alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 60) TilteStr:@"全部" TilteSubStr:_FinanceModel.history_money TmgViewStr:@"mine_all_icon"];
           // segmentButton.tag = 20000;
            
        }
        else if(i == 1){
            segmentButton = [[MyshouyiBtn alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 60) TilteStr:@"收入" TilteSubStr:_FinanceModel.history_money TmgViewStr:@"mine_income_icon"];
           // segmentButton.tag = 20001;
            
        }
        else{
            segmentButton = [[MyshouyiBtn alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 60) TilteStr:@"提现" TilteSubStr:_FinanceModel.history_money TmgViewStr:@"mine_Withdraws-cash_icon"];
//            segmentButton.tag = 20002;
            
        }
        
        //        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
        //        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_selected"] forState:UIControlStateSelected];
        //        [segmentButton setTitle:[NSString stringWithFormat:@"view%@",@(i)] forState:UIControlStateNormal];
        //        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [buttonArray addObject:segmentButton];
        [ViewArray addObject:view];
        
    }
   pagingView  = [HHHorizontalPagingView pagingViewWithHeaderView:_headView headerHeight:224.f segmentButtons:buttonArray segmentViews:ViewArray segmentHeight:60 contentViews:@[_quanbuTableView, _shouruTableView, _tixianTableView]];
    
    // pagingView.segmentButtonSize = CGSizeMake(60., 30.);              //自定义segmentButton的大小
    pagingView.segmentView.backgroundColor = [UIColor whiteColor];     //设置segmentView的背景色
    pagingView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    pagingView.horizontalCollectionView.contentOffset = CGPointMake(Main_Screen_Width*_index, 0);
    MCseleButton * btn = (MCseleButton*)[pagingView viewWithTag:1000+ _index];
    btn.selected = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    
    
    
    
    [self.view addSubview:pagingView];
    UIView * _botBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 44, Main_Screen_Width, 44)];
    UIView *_lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    
    [_botBtnView addSubview:_lineView];
    
    
    _botBtnView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    _tixianText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width/2, 44)];
    _tixianText.placeholder = @"请输入提现金额";
    _tixianText.textColor = [UIColor darkTextColor];
    _tixianText.font =AppFont;
    [_botBtnView addSubview:_tixianText];
    _tixianText.delegate = self;
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 15 - 100, 6, 100, 32)];
    [btn3 setTitle:@"申请提现" forState:0];
    [btn3 setTitleColor:[UIColor whiteColor] forState:0];
    btn3.backgroundColor = AppCOLOR;
    ViewRadius(btn3, 5);
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn3 addTarget:self action:@selector(actionTX) forControlEvents:UIControlEventTouchUpInside];
    [_botBtnView addSubview:btn3];
    
    
    
    
    
    [self.view addSubview:_botBtnView];
 
    
        MyshouyiBtn * btnvv = (MyshouyiBtn*)[pagingView viewWithTag:1002];
    
   // btnvv.titleSubLbl.text = @"121212";
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}
-(headView*)head_View{
    headView *headerView = [[NSBundle mainBundle] loadNibNamed:@"headView" owner:self options:nil][0];
    return headerView;

    
    
}
-(void)actionTX{
    [_tixianText resignFirstResponder];
    if (!_tixianText.text.length) {
        [self showAllTextDialog:@"请输入提现金额"];
        return;
    }
    if (!ali_account.length) {
        [self showAllTextDialog:@"你还没设置支付宝账号"];
        return;
    }
    [self showLoading:YES AndText:nil];
    
    NSDictionary * Parameterdic = @{
                                    @"money":_tixianText.text,
                                    @"ali_account":ali_account,
                                    };
    

    
    [self.requestManager requestWebWithParaWithURL:@"User/withdrawing" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"提现成功"];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];
        
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
