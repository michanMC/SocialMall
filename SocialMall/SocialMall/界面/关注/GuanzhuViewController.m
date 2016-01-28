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
@interface GuanzhuViewController ()<UIScrollViewDelegate>
{
    
    //缺省页
    MCNoMuiscView * _noDataView;
    
    CGFloat _scrollViewSizeW;
    NSInteger indexnum;//假数据
    
    
    NSMutableArray *_arrayView;
    BOOL _isRefresh;
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
    _arrayView = [NSMutableArray array];
    //跳个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectgerenDataObj:) name:@"didSelectgerenDataObjNotification" object:nil];
    //跳详情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectXQObj:) name:@"didSelectXQObjNotification" object:nil];

    indexnum = 3;
    
    [self prepareUI2];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark-监听跳详情
-(void)didSelectXQObj:(NSNotification*)Notification{
    
    XQViewController * ctl = [[XQViewController alloc]init];
    NSLog(@"跳第%ld",(long)_index);
    [self pushNewViewController:ctl];

    
    
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
        _McFooter.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _McFooter.state = ZYBannerFooterStateIdle;
        //想显示这个视图，那得让这个视图跟着tableView的滚动来进出
        //所以需要把这个视图加到tableView上
        
        //a.将label加到view上
//        [self.scrollView addSubview:_McFooter];
        
    }
    CGFloat width = CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);

    _McFooter.frame = CGRectMake(_arrayView.count * width+20,0 , 100,height) ;

    return _McFooter;
}

-(void)prepareUI2{

    [self.view addSubview:self.scrollView];
    for (int i = 0; i < indexnum; i ++) {
        [self createCardWithColor:i];
    }
    _scrollView.contentOffset = CGPointMake(_index * (Main_Screen_Width - 40), 0);
    
    if (_index==0) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        
    }
   
    
    
  
  [_scrollView addSubview:self.McFooter];
    
    
   
}

- (void)createCardWithColor:(NSInteger)index
{
    CGFloat width = CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    
    CGFloat x = _arrayView.count * width;
    
    // contr = [[zuopinDataViewController alloc] initFrame:CGRectMake(x, 0, width, height)];
    zuopinDataView * zuoView = [[zuopinDataView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
    ViewRadius(zuoView, 5);
       // contr.view.backgroundColor = [UIColor yellowColor];//
    [zuoView prepareUI];
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

    if ((scrollView.contentOffset.x + Main_Screen_Width - _scrollViewSizeW) > 100) {
        
        _McFooter.state = ZYBannerFooterStateTrigger;
        
        if (scrollView.isDragging) {
            
            NSLog(@"1");
        } else {
            _isRefresh = YES;
            _index =indexnum;
            indexnum += 2;
            
            [self showLoading:YES AndText:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                for (zuopinDataView * view in _arrayView) {
                    [view removeFromSuperview];
                }
                [_arrayView removeAllObjects];
                [self prepareUI2];
                _isRefresh = NO;
                [self stopshowLoading];
                NSLog(@"刷新");

            });

            
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

    zuopinDataView * view = _arrayView[_index];
    
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
