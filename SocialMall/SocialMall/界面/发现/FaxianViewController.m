//
//  FaxianViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "FaxianViewController.h"
#import "loginViewController.h"
#import "HMSegmentedControl.h"
#import "tuijianViewController.h"
#import "remenViewController.h"
#import "zuixinViewController.h"

@interface FaxianViewController ()
{
    
    HMSegmentedControl *titleSegment;
    tuijianViewController * _tuijianCtl;
    remenViewController * _remenCtl;
    zuixinViewController * _zuixinCtl;
}

@end

@implementation FaxianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_search_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionTime)];
    
    self.navigationItem.titleView = [self MCtiteView];
    
    //    添加滚动
    [self addScrollView];
    [self addtuijian];
    [self addremen];
    [self addzuixin];
}
- (void)addScrollView
{
    //中间View
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 44)];
    self.mainScroll.contentSize = CGSizeMake(Main_Screen_Width * 3, 0);
    //self.mainScroll.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    _mainScroll.contentOffset = CGPointMake(Main_Screen_Width * 0, 0);
    _mainScroll.scrollEnabled = NO;
    self.mainScroll.delegate = self;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.bounces = NO;
    [self.view addSubview:self.mainScroll];
    
    
}

-(UIView*)MCtiteView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width , 44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    //选择框
    titleSegment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(60, 0, Main_Screen_Width-60* 2, 44)];
    titleSegment.sectionTitles = @[@"推荐", @"热门",@"最新"];
    titleSegment.selectedSegmentIndex = 0;
    titleSegment.backgroundColor = [UIColor clearColor];
    titleSegment.textColor = [UIColor whiteColor];
    titleSegment.selectedTextColor = [UIColor whiteColor];
    titleSegment.font = [UIFont systemFontOfSize:16];
    titleSegment.selectionIndicatorHeight = 3;
    titleSegment.selectionIndicatorColor = [UIColor whiteColor];
    titleSegment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    titleSegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    titleSegment.center = view.center;
    [view addSubview:titleSegment];
    __weak typeof(self) weakSelf = self;
  //  __block typeof(NSInteger) weakisBianji = _isBianji;
    
    [titleSegment setIndexChangeBlock:^(NSInteger index) {
        weakSelf.mainScroll.contentOffset =CGPointMake(index * Main_Screen_Width, 0);

    }];

    
    return view;
    
    
}
#pragma mark-addRemen

-(void)addremen{
    _remenCtl = [[remenViewController alloc]init];
    [self.mainScroll addSubview:_remenCtl.view];
    
}
-(void)addtuijian{
   _tuijianCtl = [[tuijianViewController alloc]init];
    [self.mainScroll addSubview:_tuijianCtl.view];

}
-(void)addzuixin{
    
    _zuixinCtl = [[zuixinViewController alloc]init];
    [self.mainScroll addSubview:_zuixinCtl.view];
    
}
#pragma mark-搜索
-(void)ActionTime{
    loginViewController * ctl = [[loginViewController alloc]init];
    [self pushNewViewController:ctl];
    
    
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
