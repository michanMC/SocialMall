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
#import "XQViewController.h"
#import "SearchViewController.h"
@interface FaxianViewController ()<UIScrollViewDelegate>
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
    //跳详情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectFXXQObj:) name:@"didSelectFXXQObjNotification" object:nil];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 7, Main_Screen_Width - 40, 40)];
    [btn setImage:[UIImage imageNamed:@"shous"] forState:0];
    [btn addTarget:self action:@selector(ActionTime) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;//[self MCtiteView];

    
    [self prepareUI];
    // Do any additional setup after loading the view.
}
#pragma mark-监听跳详情
-(void)didSelectFXXQObj:(NSNotification*)Notification{
    
    if ([Notification.object isKindOfClass:[faXianModel class]]) {
        XQViewController * ctl = [[XQViewController alloc]init];
        ctl.faxianModel = Notification.object;
        [self pushNewViewController:ctl];

    }
    
    
    
}

-(void)prepareUI{
//      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_search_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionTime)];
//    
   // self.navigationItem.titleView = [self MCtiteView];
   
    //    添加滚动
    [self addScrollView];
    [self addtuijian];
    [self addremen];
    [self addzuixin];
     [self addSegmentView];
}
-(void)addSegmentView{
    //选择框
    titleSegment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    titleSegment.sectionTitles = @[@"推荐", @"热门",@"最新"];
    titleSegment.selectedSegmentIndex = 0;
    titleSegment.backgroundColor = [UIColor whiteColor];
    titleSegment.textColor = [UIColor darkGrayColor];
    titleSegment.selectedTextColor = AppCOLOR;
    titleSegment.font = [UIFont systemFontOfSize:16];
    titleSegment.selectionIndicatorHeight = 3;
    titleSegment.selectionIndicatorColor = AppCOLOR;
    titleSegment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    titleSegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
   
    __weak typeof(self) weakSelf = self;
//    __block typeof(NSInteger) weakisBianji = _isBianji;
    __weak typeof(tuijianViewController*) weaktui = _tuijianCtl;
    __weak typeof(remenViewController*) weakremen = _remenCtl;
    __weak typeof(zuixinViewController*) weakzuixin = _zuixinCtl;

    [titleSegment setIndexChangeBlock:^(NSInteger index) {
        weakSelf.mainScroll.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        
        if (index == 0) {
            if(!weaktui.dataArray.count){
                [weaktui load_Data:YES];
                
                
            }
        }
        if (index == 1) {
            if(!weakremen.dataArray.count){
                [weakremen load_Data:YES];
            }
            
            
        } if (index == 2) {
            if(!weakzuixin.dataArray.count){
                [weakzuixin load_Data:YES];
                
            }
            
            
        }

    }];
  
    [self.view addSubview:titleSegment];
    
    
}

- (void)addScrollView
{
    //中间View
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 44, Main_Screen_Width, Main_Screen_Height - 44 - 64 - 49)];
    self.mainScroll.contentSize = CGSizeMake(Main_Screen_Width * 3, 0);
    //self.mainScroll.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    _mainScroll.contentOffset = CGPointMake(Main_Screen_Width * 0, 0);
    self.mainScroll.delegate = self;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScroll];
    
    
}
/*
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
 */
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
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger indepage = scrollView.contentOffset.x / Main_Screen_Width;
    
    titleSegment.selectedSegmentIndex =indepage;
    if (indepage == 0) {
        if(!_tuijianCtl.dataArray.count){
            [_tuijianCtl load_Data:YES];
        }
    }
    if (indepage == 1) {
        if(!_remenCtl.dataArray.count){
            [_remenCtl load_Data:YES];
        }

        
    } if (indepage == 2) {
        if(!_zuixinCtl.dataArray.count){
            [_zuixinCtl load_Data:YES];
        }
        
 
    }
    
    
    
}
#pragma mark-搜索
-(void)ActionTime{
    SearchViewController * ctl = [[SearchViewController alloc]init];
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
