//
//  XQViewController.m
//  SocialMall
//
//  Created by MC on 16/1/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "XQViewController.h"
#import "CLAnimationView.h"
#import "zuopinDataView1.h"
#import "zuopinDataView2Cell.h"
@interface XQViewController ()
<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    UIViewController *currentViewController;
    //系统自的下拉刷新控制器
    UIRefreshControl * _refreshControl;
}
@property(nonatomic,strong) UITableView *firstViewTableView;
@property(nonatomic,strong) UITableView *secondViewTableView;
@property(nonatomic,strong) UIWebView *secondWebView;

//@property(nonatomic,strong)UILabel * foortlabel;//继续滑动Lbl
@property(nonatomic,strong)UIView * foortView;//继续滑动view

@property(nonatomic,strong)UIImageView * foortimg;//继续滑动img

@property(nonatomic,strong)UILabel * headlabel;//继续滑动返回Lbl

@property(nonatomic,strong)UIView * firstViewPullview;

@end

@implementation XQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(fenxiang)];
    [self prepareFirstView];
    [self prepareSecondView];
    currentViewController=_firstViewController;

    // Do any additional setup after loading the view.
}
-(void)prepareFirstView{
    _firstViewController = [[UIViewController alloc]init];
    [self addChildViewController:_firstViewController];
    _firstViewController.view.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height -64 );
    _firstViewController.view.backgroundColor = [UIColor yellowColor];
    //再准备一下准背景视图
    //让这个view初始状态，是显示在屏幕外面的，当下拉时，才被显示进来
    _firstViewPullview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    _firstViewPullview.backgroundColor = [UIColor whiteColor];
    
    _foortimg = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 25)/2,( 50 - 25)/2, 25, 25)];
    _foortimg.image =[UIImage imageNamed:@"arrow_pull-down"];
    //准备下拉刷新的视图
    _foortView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    _foortView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_foortView addSubview:_foortimg];
//    _foortlabel.text = @"继续滑动看详情";
//    _foortlabel.tag = 1000;
//    _foortlabel.textAlignment = NSTextAlignmentCenter;
//    _foortlabel.textColor = [UIColor purpleColor];
//    
    //想显示这个视图，那得让这个视图跟着tableView的滚动来进出
    //所以需要把这个视图加到tableView上
    
    //a.将label加到view上
    [_firstViewPullview addSubview:_foortView];
    
    _firstViewTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _firstViewTableView.delegate  =self;
    _firstViewTableView.dataSource = self;
    
    //  [_firstViewTableView addSubview:firstViewPullview];
    
    _firstViewTableView.tableFooterView = _firstViewPullview;
    [_firstViewController.view addSubview:_firstViewTableView];
    [self.view addSubview:self.firstViewController.view];
    
    
}
-(void)prepareSecondView{
    _secondViewController = [[UIViewController alloc]init];
    _secondViewController.view.backgroundColor = [UIColor redColor];
    _secondViewController.view.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height -64 );
    //    [self.view addSubview:secondViewController.view];
    [self addChildViewController:_secondViewController];
    
    _secondViewTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _secondViewTableView.delegate  =self;
    _secondViewTableView.dataSource = self;
    
    
    //b.将view加到tableView上
    [_secondViewTableView addSubview:[self secondViewPullview]];
    
    [_secondViewController.view addSubview:_secondViewTableView];
    
}
-(UIView*)secondViewPullview{
    //再准备一下准背景视图
    //让这个view初始状态，是显示在屏幕外面的，当下拉时，才被显示进来
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, -200, Main_Screen_Width, 200)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 25)/2, 100, 25, 25)];
    imgView.image =[UIImage imageNamed:@"arrow_pull-down"];
    //准备下拉刷新的视图
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, Main_Screen_Width, 100)];
    label.text = @"释放返回商品详情";
    label.tag = 1001;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor purpleColor];
    
    //想显示这个视图，那得让这个视图跟着tableView的滚动来进出
    //所以需要把这个视图加到tableView上
    
    //a.将label加到view上
    [view addSubview:label];
    return view;
}
- (void)refreshAction{
    
    [_refreshControl endRefreshing];
    UIViewController *oldViewController=currentViewController;
    
    [self transitionFromViewController:currentViewController toViewController:_firstViewController duration:.6 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    }  completion:^(BOOL finished) {
        
        
        if (finished) {
            currentViewController=_firstViewController;
        }else{
            currentViewController=oldViewController;
        }
    }];
    
    
}

 #pragma mark-实现滚动视图的didScroll这个协议方法，来判断是否在刷新数据
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //在这里实现下拉刷新，就是利用了tableView在上下滚动时，
    //y轴的坐标变化来控制是否刷新的
    NSLog(@"---- %f ----",scrollView.contentOffset.y);
    NSLog(@"+++ %f +++++",scrollView.contentSize.height);

    
    BOOL istiao = NO;
    if (scrollView == _firstViewTableView) {
        
        if (scrollView.contentSize.height > Main_Screen_Height-64 ) {
            if ((scrollView.contentOffset.y + (Main_Screen_Height-64) - scrollView.contentSize.height) > 40) {
                istiao = YES;
                
            }
 
        }
        else
        {
            if (scrollView.contentOffset.y  > 40) {
                istiao = YES;
                
            }
  
        }
        if (istiao) {
          //  _foortlabel.text = @"释放查看图文详情";
//            [UIView animateWithDuration:0.3 animations:^{
//                _foortimg.transform = CGAffineTransformMakeRotation(0);
//            }];
            [UIView animateWithDuration:0.3 animations:^{
                _foortimg.transform = CGAffineTransformMakeRotation(M_PI);
            }];

            if (scrollView.isDragging) {
                
                NSLog(@"1");
            } else {
                
                NSLog(@"2");
                
                UIViewController *oldViewController=currentViewController;
                
                [self transitionFromViewController:currentViewController toViewController:_secondViewController duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                }  completion:^(BOOL finished) {
                    
                    
                    if (finished) {
                        currentViewController=_secondViewController;
                    }else{
                        currentViewController=oldViewController;
                    }
                }];
                
            }
            
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                _foortimg.transform = CGAffineTransformMakeRotation(0);
            }];

           // _foortlabel.text = @"继续滑动看详情";
        }
    }
    else
        
    {
        
        if (scrollView.contentOffset.y < -58) {
            
            if (scrollView.isDragging) {
                
                NSLog(@"1");
            } else {
                
                NSLog(@"2");
                
                UIViewController *oldViewController=currentViewController;
                
                [self transitionFromViewController:currentViewController toViewController:_firstViewController duration:.6 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                }  completion:^(BOOL finished) {
                    
                    
                    if (finished) {
                        currentViewController=_firstViewController;
                    }else{
                        currentViewController=oldViewController;
                    }
                }];
                
            }
            
        }
        else
        {
            NSLog(@"3");
            
            
        }
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _firstViewTableView) {
        if (indexPath.row == 0) {
            return 64;
        }
        if (indexPath.row == 1) {
            return Main_Screen_Width;
        }
        return 44;
    }
    if (indexPath.row == 3) {
        
        return 60;
    }
    if (indexPath.row == 2) {
        
        return 100;
    }
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_firstViewTableView==tableView) {
        
        CGFloat hh =tableView.contentSize.height;
        
        if (hh > Main_Screen_Height-64) {
            _foortView.frame = CGRectMake(0, 0, Main_Screen_Width, 50);
            
            
        }
        else
        {
            CGFloat ff =  tableView.frame.size.height - hh;
            NSLog(@"MMMMMMMM%f",ff);
            _firstViewPullview.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - hh-10);
            _foortView.frame = CGRectMake(0, _firstViewPullview.frame.size.height - 50, Main_Screen_Width, 50);
            //_foortimg = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 25)/2,_firstViewPullview.frame.size.height - 50 + 12.5, 25, 25)];

            // b.将view加到tableView上
            //[_firstViewTableView addSubview:firstViewPullview];
            
        }
        
        return 3;
    }
    return 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _firstViewTableView) {
        static NSString *cellid1 = @"zuopinDataView1";
        static NSString *cellid2 = @"zuopinDataView2Cell";

        if (indexPath.row == 0) {
            zuopinDataView1 * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid1 owner:self options:nil]lastObject];
            }
            cell.headImgBtn.tag = 90000;
           // [cell.headImgBtn addTarget:self action:@selector(actionHeadbtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
        if (indexPath.row == 1) {
            zuopinDataView2Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid2 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
 
        
        
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MC"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MC"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.textLabel.textColor = AppCOLOR;
    return cell;
    
    
}

#pragma mark-分享
-(void)fenxiang{
    
    CLAnimationView *animationView = [[CLAnimationView alloc]initWithTitleArray:@[@"朋友圈",@"微信好友"] picarray:@[@"share_friends",@"share_wechat"]];
    [animationView selectedWithIndex:^(NSInteger index) {
        NSLog(@"你选择的index ＝＝ %ld",(long)index);
    }];
    [animationView CLBtnBlock:^(UIButton *btn) {
        NSLog(@"你点了选择/取消按钮");
    }];
    [animationView show];

    
    
    
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
