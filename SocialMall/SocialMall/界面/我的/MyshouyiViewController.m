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
@interface MyshouyiViewController ()
{
    headView * _headView;
    allTableView *_quanbuTableView;
    shouruTableView *_shouruTableView;
    tixianTableView *_tixianTableView;

    UITextField * _tixianText;
    
}

@end

@implementation MyshouyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收益";
    
    

    _headView = [self head_View];
    

    _quanbuTableView = [allTableView contentTableView];
    _shouruTableView = [shouruTableView contentTableView];
    _tixianTableView = [tixianTableView contentTableView];
    NSMutableArray *buttonArray = [NSMutableArray array];
    NSMutableArray *ViewArray = [NSMutableArray array];

    for(int i = 0; i < 3; i++) {
        MyshouyiBtn *segmentButton ;//= [MyshouyiBtn buttonWithType:UIButtonTypeCustom];
       // MyshouyiBtn *segmentButton =

        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 60)];
        if (i == 0) {
            segmentButton = [[MyshouyiBtn alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 60) TilteStr:@"全部" TilteSubStr:@"112.10" TmgViewStr:@"mine_all_icon"];
            
        }
        else if(i == 1){
            segmentButton = [[MyshouyiBtn alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 60) TilteStr:@"收入" TilteSubStr:@"112.31" TmgViewStr:@"mine_income_icon"];
        }
        else{
            segmentButton = [[MyshouyiBtn alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width/3, 60) TilteStr:@"提现" TilteSubStr:@"111.12" TmgViewStr:@"mine_Withdraws-cash_icon"];
        }

//        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
//        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_selected"] forState:UIControlStateSelected];
//        [segmentButton setTitle:[NSString stringWithFormat:@"view%@",@(i)] forState:UIControlStateNormal];
//        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [buttonArray addObject:segmentButton];
        [ViewArray addObject:view];

    }
    HHHorizontalPagingView *pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:_headView headerHeight:224.f segmentButtons:buttonArray segmentViews:ViewArray segmentHeight:60 contentViews:@[_quanbuTableView, _shouruTableView, _tixianTableView]];

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

    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 15 - 100, 6, 100, 32)];
    [btn3 setTitle:@"申请提现" forState:0];
    [btn3 setTitleColor:[UIColor whiteColor] forState:0];
    btn3.backgroundColor = AppCOLOR;
    ViewRadius(btn3, 5);
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [_botBtnView addSubview:btn3];

    
    
    
    
    [self.view addSubview:_botBtnView];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
    
    
    
}
-(headView*)head_View{
    headView *headerView = [[NSBundle mainBundle] loadNibNamed:@"headView" owner:self options:nil][0];
    return headerView;

    
    
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
