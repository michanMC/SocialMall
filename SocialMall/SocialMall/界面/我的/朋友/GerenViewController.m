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

}

@end

@implementation GerenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headView = [self head_View];
    _collectionView =[HHContentCollectionView contentCollectionViewKey:@"1"];
    [_collectionView loadData];
    _zancollectionView =[HHContentCollectionView contentCollectionViewKey:@"2"];
    [_zancollectionView loadData];

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
    MCHHHorizontalPagingView *pagingView = [MCHHHorizontalPagingView pagingViewWithHeaderView:_headView headerHeight:164.f segmentButtons:buttonArray segmentHeight:44 contentViews:@[_collectionView, _zancollectionView]];
    // pagingView.segmentButtonSize = CGSizeMake(60., 30.);              //自定义segmentButton的大小
    pagingView.segmentView.backgroundColor = [UIColor whiteColor];     //设置segmentView的背景色
    pagingView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    pagingView.horizontalCollectionView.contentOffset = CGPointMake(Main_Screen_Width*_index, 0);
//    MCseleButton * btn = (MCseleButton*)[pagingView viewWithTag:1000+ _index];
//    btn.selected = YES;
//    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    
    
    
    
    [self.view addSubview:pagingView];

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
