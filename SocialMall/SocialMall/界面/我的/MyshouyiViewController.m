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
#import "HHContentTableView.h"
#import "MCseleButton.h"
@interface MyshouyiViewController ()
{
    headView * _headView;
    HHContentTableView *_quanbuTableView;
    HHContentTableView *_shouruTableView;
    HHContentTableView *_tixianTableView;

    
    
}

@end

@implementation MyshouyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收益";
    _headView = [self head_View];
    _quanbuTableView = [HHContentTableView contentTableView];
    _shouruTableView = [HHContentTableView contentTableView];
    _tixianTableView = [HHContentTableView contentTableView];
    NSMutableArray *buttonArray = [NSMutableArray array];
    for(int i = 0; i < 3; i++) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_selected"] forState:UIControlStateSelected];
        [segmentButton setTitle:[NSString stringWithFormat:@"view%@",@(i)] forState:UIControlStateNormal];
        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [buttonArray addObject:segmentButton];
    }
    HHHorizontalPagingView *pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:_headView headerHeight:162.f segmentButtons:buttonArray segmentHeight:44 contentViews:@[_quanbuTableView, _shouruTableView, _tixianTableView]];
       // pagingView.segmentButtonSize = CGSizeMake(60., 30.);              //自定义segmentButton的大小
        pagingView.segmentView.backgroundColor = [UIColor whiteColor];     //设置segmentView的背景色
    pagingView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    pagingView.horizontalCollectionView.contentOffset = CGPointMake(Main_Screen_Width*_index, 0);
    MCseleButton * btn = (MCseleButton*)[pagingView viewWithTag:1000+ _index];
    btn.selected = YES;
     [self.view addSubview:pagingView];
    
    
    // Do any additional setup after loading the view.
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
