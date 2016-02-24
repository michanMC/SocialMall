
//
//  SearchViewController.m
//  SocialMall
//
//  Created by MC on 16/1/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SearchViewController.h"
#import "HMSegmentedControl.h"
#import "fenGeViewController.h"
#import "pinpaiViewController.h"
#import "chengyuanViewController.h"
#import "MCplaceholderText.h"
#import "XQViewController.h"
#import "GerenViewController.h"
@interface SearchViewController ()<UIScrollViewDelegate,UITextFieldDelegate>{
    HMSegmentedControl *titleSegment;
    fenGeViewController * _fengeCtl;
    pinpaiViewController * _pinpaiCtl;
    chengyuanViewController * _chengyuanCtl;
  
    UITextField *_searchtext;

    NSString * _searchStr;
    
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //更改输入框文字
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectTextFieldObj:) name:@"didSelectTextFieldObjNotification" object:nil];
    
    //跳详情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelecsearchtFXXQObj:) name:@"didSelectFsearchXXQObjNotification" object:nil];
    //跳个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelecsearchtGRXQObj:) name:@"didSelectFsearchGRObjNotification" object:nil];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 100, 30)];//allocate titleView
            UIColor *color =  self.navigationController.navigationBar.barTintColor;

    titleView.backgroundColor = [UIColor whiteColor];
    ViewRadius(titleView, 30/2);
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    imgView.image = [UIImage imageNamed:@"search_icon"];
    [titleView addSubview:imgView];
    
    
    CGFloat x = 30;
    CGFloat y = 0;
    CGFloat width = titleView.frame.size.width - 40;
    CGFloat height = 30;
    _searchtext = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _searchtext.tintColor = [UIColor grayColor];
    _searchtext.placeholder = @"输入搜索关键词";
    _searchtext.textColor  =[UIColor darkGrayColor];
    _searchtext.font = AppFont;
    _searchtext.delegate =self;
    //_searchtext.clearButtonMode = UITextFieldViewModeAlways;
    //_searchtext.backgroundColor = [UIColor redColor];
   // [_searchtext addTarget:self action:@selector(actionText:) forControlEvents:UIControlEventEditingChanged];
    [titleView addSubview:_searchtext];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButton)];
    
    
    
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
    [self addSegmentView];
    //    添加滚动
    [self addScrollView];
    [self addfenge];
    [self addpinpai];
    [self addchengyuan];

    
    
}
-(void)addSegmentView{
    //选择框
    titleSegment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    titleSegment.sectionTitles = @[@"风格", @"品牌",@"成员"];
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
    //  __block typeof(NSInteger) weakisBianji = _isBianji;
    
    [titleSegment setIndexChangeBlock:^(NSInteger index) {
        weakSelf.mainScroll.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        
    }];
    
    [self.view addSubview:titleSegment];
    
    
}
- (void)addScrollView
{
    //中间View
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 44, Main_Screen_Width, Main_Screen_Height - 44 - 64)];
    self.mainScroll.contentSize = CGSizeMake(Main_Screen_Width * 3, 0);
    //self.mainScroll.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    _mainScroll.contentOffset = CGPointMake(Main_Screen_Width * 0, 0);
    self.mainScroll.delegate = self;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScroll];
    
    
}
-(void)addfenge{
    _fengeCtl = [[fenGeViewController alloc]init];
    [self.mainScroll addSubview:_fengeCtl.view];
    
}
-(void)addpinpai{
    _pinpaiCtl = [[pinpaiViewController alloc]init];
    [self.mainScroll addSubview:_pinpaiCtl.view];
    
}
-(void)addchengyuan{
    
    _chengyuanCtl = [[chengyuanViewController alloc]init];
    [self.mainScroll addSubview:_chengyuanCtl.view];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger indepage = scrollView.contentOffset.x / Main_Screen_Width;
    
    titleSegment.selectedSegmentIndex =indepage;
    
    
    
}
#pragma mark-取消
-(void)rightBarButton{
    if (_searchtext.text.length) {
        [_searchtext resignFirstResponder];
        NSString * text = _searchtext.text;
    NSInteger indepage = _mainScroll.contentOffset.x / Main_Screen_Width;
    if (indepage==0) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectFGObjNotification" object:text];
    }
    else if(indepage == 1){
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectPPObjNotification" object:text];
    }
    else
    {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectCYObjNotification" object:text];
    }
    }
    
    
    
}
#pragma mark-更改输入框文字
-(void)didSelectTextFieldObj:(NSNotification*)Notification{
    if ([Notification.object length]>0) {
        
        _searchtext.text = Notification.object;
        _searchStr = _searchtext.text;
       //  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButton)];
        
        NSInteger indexpage = _mainScroll.contentOffset.x / Main_Screen_Width;
        
        if (indexpage == 0) {
          
            
        }
        if (indexpage == 1) {
          
            
        }if (indexpage == 2) {
           
            
        }
        
        
    }
    
    
    
    
}
#pragma mark-跳个人信息didSelecsearchtGRXQObj
-(void)didSelecsearchtGRXQObj:(NSNotification*)Notification{
    GerenViewController * ctl = [[GerenViewController alloc]init];
    [self pushNewViewController:ctl];

    
    
}
#pragma mark-跳详情
-(void)didSelecsearchtFXXQObj:(NSNotification*)Notification{
    
    XQViewController * ctl = [[XQViewController alloc]init];
    ctl.faxianModel = Notification.object;
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
