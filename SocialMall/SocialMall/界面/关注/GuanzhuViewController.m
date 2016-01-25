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
@interface GuanzhuViewController ()<UIScrollViewDelegate>
{
    
    //缺省页
    MCNoMuiscView * _noDataView;
    
    
    JT3DScrollView *_scrollView;


}

@end

@implementation GuanzhuViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self appColorNavigation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //跳个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectgerenDataObj:) name:@"didSelectgerenDataObjNotification" object:nil];

    
    
    [self prepareUI2];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark-监听跳个人信息
-(void)didSelectgerenDataObj:(NSNotification*)Notification{
    if ([Notification.object isEqualToString:@"1"]) {
        //
        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        ctl.titleStr = @"3";
        [self pushNewViewController:ctl];

    }
    else
    {
    
    GerenViewController *ctl = [[GerenViewController alloc]init];
    [self pushNewViewController:ctl];
    }
    
}

-(void)prepareUI{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_search_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionTime)];
    
    _noDataView = [[MCNoMuiscView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 44)];
    [_noDataView.btn addTarget:self action:@selector(actionBtnFX) forControlEvents:UIControlEventTouchUpInside];

   // _noDataView.hidden = YES;
    //_noDataView.delegate = self;
    _noDataView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_noDataView];

    
    
    
    
}
-(void)prepareUI2{

    _scrollView = [[JT3DScrollView alloc]initWithFrame:CGRectMake(20, 64, Main_Screen_Width - 40, Main_Screen_Height - 64 - 44)];
    _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _scrollView.effect = JT3DScrollViewEffectNone;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    for (int i = 0; i < 10; i ++) {
        [self createCardWithColor:i];
    }
   
}
- (void)createCardWithColor:(NSInteger)index
{
    CGFloat width = CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    
    CGFloat x = _scrollView.subviews.count * width;
    
    // contr = [[zuopinDataViewController alloc] initFrame:CGRectMake(x, 0, width, height)];
    zuopinDataView * zuoView = [[zuopinDataView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
    ViewRadius(zuoView, 5);
       // contr.view.backgroundColor = [UIColor yellowColor];//
    [zuoView prepareUI];
    [_scrollView addSubview:zuoView];
    _scrollView.contentSize = CGSizeMake(x + width, height);
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
