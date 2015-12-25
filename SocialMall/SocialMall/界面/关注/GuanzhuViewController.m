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
@interface GuanzhuViewController ()
{
    
    //缺省页
    MCNoMuiscView * _noDataView;

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
    [self prepareUI];
    
    
    // Do any additional setup after loading the view.
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
