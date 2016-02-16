//
//  GerenViewController.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "GerenViewController.h"
#import "MCHHHorizontalPagingView.h"
#import "allTableView.h"
#import "shouruTableView.h"
#import "head2View.h"
#import "MCseleButton.h"
#import "HHContentCollectionView.h"
#import "FenGuanViewController.h"

@interface GerenViewController ()
{
    head2View * _headView;
    HHContentCollectionView *_collectionView;
    HHContentCollectionView *_zancollectionView;
    userDatamodel *_usermodel;
}

@end

@implementation GerenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headView = [self head_View];
    _collectionView =[HHContentCollectionView contentCollectionViewKey:@"1"];
    [_collectionView loadData:_user_id];
    _zancollectionView =[HHContentCollectionView contentCollectionViewKey:@"2"];
    [_zancollectionView loadData:_user_id];

    NSMutableArray *buttonArray = [NSMutableArray array];
    for(int i = 0; i < 2; i++) {
        MCseleButton *segmentButton = [MCseleButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            [segmentButton setTitle:[NSString stringWithFormat:@"赞过"] forState:UIControlStateNormal];
        }
        else if(i == 1){
            [segmentButton setTitle:[NSString stringWithFormat:@"展示"] forState:UIControlStateNormal];
        }
        
        //        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
        //        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_selected"] forState:UIControlStateSelected];
        //        [segmentButton setTitle:[NSString stringWithFormat:@"view%@",@(i)] forState:UIControlStateNormal];
        //        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [buttonArray addObject:segmentButton];
    }
    MCHHHorizontalPagingView *pagingView = [MCHHHorizontalPagingView pagingViewWithHeaderView:_headView headerHeight:174.f segmentButtons:buttonArray segmentHeight:44 contentViews:@[_collectionView, _zancollectionView]];
    // pagingView.segmentButtonSize = CGSizeMake(60., 30.);              //自定义segmentButton的大小
    pagingView.segmentView.backgroundColor = [UIColor whiteColor];     //设置segmentView的背景色
    pagingView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    pagingView.horizontalCollectionView.contentOffset = CGPointMake(Main_Screen_Width*_index, 0);
//    MCseleButton * btn = (MCseleButton*)[pagingView viewWithTag:1000+ _index];
//    btn.selected = YES;
//    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    
    
    
    
    [self.view addSubview:pagingView];
    
    
    [self loadaData:YES];
    // Do any additional setup after loading the view.
}
-(head2View*)head_View{
    head2View *headerView = [[NSBundle mainBundle] loadNibNamed:@"head2View" owner:self options:nil][0];
    headerView.guanzhuBtn.backgroundColor = AppCOLOR;
    ViewRadius(headerView.guanzhuBtn, 5);
    //[headerView.guanzhuBtn addTarget:self action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>]
    [headerView.guanzhu2btn addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    headerView.guanzhu2btn.tag = 50000;
    [headerView.fensiBtn2 addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    headerView.fensiBtn2.tag = 50001;

    return headerView;
    
    
    
}
-(void)ActionBtn:(UIButton*)btn{
    if (btn.tag == 50000) {//关
        //粉
        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        ctl.titleStr = @"1";
        [self pushNewViewController:ctl];
 
    }
    else
    {
        //粉
        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        ctl.titleStr = @"2";
        [self pushNewViewController:ctl];

        
    }
    
    
}
#pragma mark-获取个人信息
-(void)loadaData:(BOOL)Refresh{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if (!_user_id) {
        return;
        
        
    }
    NSString * userId = [defaults objectForKey:@"userId"];
    
    
    NSDictionary * Parameterdic = @{
                                    @"userId":_user_id
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    
    [self.requestManager requestWebWithGETParaWith:@"User/userInfo" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        _usermodel = [userDatamodel mj_objectWithKeyValues:resultDic[@"data"][@"data"]];
        [self checkFans:YES];

        //_headView.zhanshiLbl.text = _usermodel.messages;

        
        

    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
    }];
    
    
    
}
#pragma mark-检查是否关注
-(void)checkFans:(BOOL)Refresh{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * userid = [defaults objectForKey:@"userId"];
    NSDictionary * Parameterdic = @{
                                    @"toId":_user_id,
                                    @"fromId":userid?userid:@""
                                    
                                    };
    
    
   // [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/checkFans" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSDictionary * messageList = resultDic[@"data"];
        _usermodel.isFans = [messageList[@"isFans"] boolValue];
        ViewRadius(_headView.headimgView, 68/2);
        [_headView.headimgView sd_setImageWithURL:[NSURL URLWithString:_usermodel.headimgurl] forState:0 placeholderImage:[UIImage imageNamed:@"Avatar_136"]];
        self.title = _usermodel.nickname ;//? _usermodel.nickname:userPhone;
        
        _headView.sexLbl.text = [_usermodel.sex isEqualToString:@"0"]? @"男":@"女";
        _headView.zanlbl.text = [NSString stringWithFormat:@"赞 %@",_usermodel.likeds];
        _headView.fensiLbl.text = [NSString stringWithFormat:@"粉丝 %@",_usermodel.fans];//_usermodel.fans;
        _headView.guanzhuLbl.text = [NSString stringWithFormat:@"关注 %@",_usermodel.follows];//_usermodel.follows;
        _headView.qianmingLbl.text = [NSString stringWithFormat:@"个性签名:%@",_usermodel.autograph];

        if (_usermodel.isFans) {
            _headView.guanzhuBtn.layer.borderColor = UIColorFromRGB(0x29477d).CGColor;
            _headView.guanzhuBtn.layer.borderWidth = 1;
            
            [_headView.guanzhuBtn setTitle:@"已关注" forState:0];
            _headView.guanzhuBtn.backgroundColor = [UIColor whiteColor];
            [_headView.guanzhuBtn setTitleColor:UIColorFromRGB(0x29477d) forState:0 ];
            
            
        }
        
        else
        {
            [_headView.guanzhuBtn setTitle:@"关注" forState:0];
            _headView.guanzhuBtn.backgroundColor = AppCOLOR;
            [_headView.guanzhuBtn setTitleColor:[UIColor whiteColor] forState:0 ];
        }
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString * userid = [defaults objectForKey:@"userId"];
        
        if ([_usermodel.user_id ? _usermodel.user_id :_usermodel.id  isEqualToString:userid]) {
            _headView.guanzhuBtn.hidden = YES;
        }
        else
        {
            _headView.guanzhuBtn.hidden = NO;
            
        }

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
