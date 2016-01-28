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
#import "QX1TableViewCell.h"
#import "QX2TableViewCell.h"
#import "QX3TableViewCell.h"
#import "QX4TableViewCell.h"
#import "QX5TableViewCell.h"

#import "zuopinDataView3Cell.h"
#import "FenGuanViewController.h"
#import "GerenViewController.h"
#import "liebiaoTableViewCell.h"
@interface XQViewController ()
<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UITextViewDelegate,zuopinDataView3CellDelegate>
{
    UIViewController *currentViewController;
    //系统自的下拉刷新控制器
    UIRefreshControl * _refreshControl;
    UIImageView *_pinglunHeadImg;
    UIView * _pinlunBgview;
    UITextView *_pinLunTextView;
    NSString *_textViewStr;
    
    
    
    UIButton *_zhidingBtn;
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
#pragma mark-第一个
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
    _firstViewTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //  [_firstViewTableView addSubview:firstViewPullview];
    
    _firstViewTableView.tableFooterView = _firstViewPullview;
    [_firstViewController.view addSubview:_firstViewTableView];
    [self.view addSubview:self.firstViewController.view];
    
    
}
#pragma mark-第2个

-(void)prepareSecondView{
    _secondViewController = [[UIViewController alloc]init];
    _secondViewController.view.backgroundColor = [UIColor redColor];
    _secondViewController.view.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height -64  );
    //    [self.view addSubview:secondViewController.view];
    [self addChildViewController:_secondViewController];
   
    
    _pinlunBgview = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height- 48-64, Main_Screen_Width, 48)];
    UIView * lineview= [[ UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_pinlunBgview addSubview:lineview];
    _pinlunBgview.backgroundColor = [UIColor whiteColor];
    _pinglunHeadImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 28, 28)];
    _pinglunHeadImg.image = [UIImage imageNamed:@"Avatar_46"];
    [_pinlunBgview addSubview:_pinglunHeadImg];
    
    
    _pinLunTextView = [[UITextView alloc]initWithFrame:CGRectMake(10 + 28 + 10, 5, Main_Screen_Width - 20 - 28 - 50, 38)];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 28 + 5, 5, Main_Screen_Width - 15 - 28 - 50, 38)];
    img.image = [UIImage imageNamed:@"Input_comment_bg"];
    [_pinlunBgview addSubview:img];
    _pinLunTextView.backgroundColor = [UIColor clearColor];
    _pinLunTextView.font = AppFont;
    _pinLunTextView.delegate =self;
    [_pinlunBgview addSubview:_pinLunTextView];
    
    
    UIButton * sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 50, 0, 50, 48)];
    [sendBtn setTitle:@"发送" forState:0];
    [sendBtn setTitleColor:UIColorFromRGB(0x29477d) forState:0];
    [_pinlunBgview addSubview:sendBtn];
    
    
    [_secondViewController.view addSubview:_pinlunBgview];
    
    _secondViewTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 48) style:UITableViewStyleGrouped];
    _secondViewTableView.delegate  =self;
    _secondViewTableView.dataSource = self;
    _secondViewTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    //b.将view加到tableView上
    [_secondViewTableView addSubview:[self secondViewPullview]];
    
    [_secondViewController.view addSubview:_secondViewTableView];
    _zhidingBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 50, Main_Screen_Height - 64 - 48 - 50 - 50, 50, 50)];
    [_zhidingBtn setImage:[UIImage imageNamed:@"iconfont-zhiding"] forState:0];
    _zhidingBtn.hidden = YES;
    [_zhidingBtn addTarget:self action:@selector(releaseBtn) forControlEvents:UIControlEventTouchUpInside];

    [_secondViewController.view addSubview:_zhidingBtn];
    

    
}
-(UIView*)secondViewPullview{
    //再准备一下准背景视图
    //让这个view初始状态，是显示在屏幕外面的，当下拉时，才被显示进来
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, -200, Main_Screen_Width, 200)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 25)/2, 100, 25, 25)];
    imgView.image =[UIImage imageNamed:@"arrow_pull-down"];
    //准备下拉刷新的视图
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, Main_Screen_Width, 50)];
    label.text = @"释放返回详情图文";
    label.tag = 1001;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = AppCOLOR;//[UIColor purpleColor];
    
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
    else  if (scrollView == _secondViewTableView)

        
    {
        
        if (scrollView.contentOffset.y < Main_Screen_Height - 64 - 48)
            _zhidingBtn.hidden = YES;
        else
        {
            _zhidingBtn.hidden = NO;
        }

        
        
        
        if (scrollView.contentOffset.y < -35) {
            
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
    if(_secondViewTableView == tableView ){
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_secondViewTableView == tableView) {
        return 10;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_secondViewTableView == tableView) {
        return 0.01;
    }

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
        if (indexPath.row == 2) {
            NSString *titleStr = @"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
            CGFloat h = [MCIucencyView heightForString:titleStr fontSize:14 andWidth:Main_Screen_Width - 20] + 20;

            return h;
        }
        if (indexPath.row == 3) {
            return 50;
        }

        return 44;
    }
    if (tableView == _secondViewTableView) {
        if (indexPath.section == 0) {
            return 44;
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                return 50;
            }
            return 60;
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                return 50;
            }
            
            NSString *titleStr = @"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
            CGFloat h = [MCIucencyView heightForString:titleStr fontSize:14 andWidth:Main_Screen_Width - 10 - 48] ;
            
            return 40 + h + 10 + .5;
        }
        
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
        
        return 4;
    }
    if (_secondViewTableView==tableView) {
        if (section == 0) {
            return 2;
        }
        if (section == 1) {
            return 4;//搭配
        }
        return 10;//评论
        
        
        
        
        
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _firstViewTableView) {
        static NSString *cellid1 = @"zuopinDataView1";
        static NSString *cellid2 = @"QX1TableViewCell";
        static NSString *cellid3 = @"QX2TableViewCell";
        static NSString *cellid4 = @"QX3TableViewCell";

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
            QX1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid2 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
 
        if (indexPath.row == 2) {
            QX2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
            if (!cell) {
                cell = [[QX2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleStr = @"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
            return cell;
        }
        if (indexPath.row == 3) {
            QX3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid4];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid4 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }

        
    }
    if (tableView == _secondViewTableView) {
        static NSString *cellid5 = @"mc5";
        static NSString *cellid6 = @"zuopinDataView3Cell";
        static NSString *cellid7 = @"liebiaoTableViewCell";
        static NSString *cellid8 = @"QX4TableViewCell";
        static NSString *cellid9 = @"QX5TableViewCell";

        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid5];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid5];
                }
                cell.textLabel.text = @"15人喜欢";
                cell.textLabel.textColor = [UIColor darkGrayColor];
                cell.textLabel.font = AppFont;
                return cell;
                
            
            }
            if (indexPath.row == 1) {
                zuopinDataView3Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellid6];
                if (!cell) {
                    cell = [[zuopinDataView3Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid6];
                    
                }
                cell.isQX = YES;
                [cell prepareUI];
                cell.deleGate =self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;

            }
        
        }
        if(indexPath.section == 1 ){
            if (indexPath.row == 0) {
                QX4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid8];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:cellid8 owner:self options:nil]lastObject];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;                cell.titleLbl.text = @"搭配详情";
                cell.imgView2.hidden = YES;
                cell.imgView1.hidden = NO;

                return cell;
                
                
            }
            liebiaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid7];
            if (!cell) {
                cell = [[liebiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid7];
            }
//            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nameStr = @"xxxxxxxxx";
            cell.deleBtn.hidden = YES;

            cell.mashuStr = @"GAP M码";
           // cell.deleBtn.tag = 800 + indexPath.row;
           // [cell.deleBtn addTarget:self action:@selector(ACtionDeleBtn:) forControlEvents:UIControlEventTouchUpInside];
//            if (indexPath.row == _xuanzheIndedx) {
//                cell.bgView.backgroundColor = [UIColor lightGrayColor];
//            }
//            else
//            {
                cell.bgView.backgroundColor = [UIColor whiteColor];
                
           // }
            return cell;
        }
        if(indexPath.section == 2){
            if (indexPath.row == 0) {
                QX4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid8];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:cellid8 owner:self options:nil]lastObject];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;                cell.titleLbl.text = @"评论(22)";
                cell.imgView1.hidden = YES;
                cell.imgView2.hidden = NO;
                cell.textLabel.font = AppFont;
                return cell;

            }
            else
            {
                QX5TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid9];
                if (!cell) {
                    cell = [[QX5TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid9];

                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString *titleStr = @"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
                cell.titleStr = titleStr;
             //  cell.headImgBtn.tag =
                [cell.headImgBtn addTarget:self action:@selector(ACtionBtnGeren:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
                
                
            }
            
            
        }
        
        
        
        
        
    }
    
    
    
    return [[UITableViewCell alloc]init];
    
    
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
#pragma mark-赞个人信息
-(void)actionZanBtn:(BOOL)isAll
{
    if (isAll) {
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
-(void)ACtionBtnGeren:(UIButton*)btn{
    GerenViewController *ctl = [[GerenViewController alloc]init];
    [self pushNewViewController:ctl];
 
    
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    _textViewStr = textView.text;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    //    UILabel * lbl = (UILabel*)[self.view viewWithTag:600];
    //
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 76) {
        //[_tableview reloadData];
        
        
        return NO;
    }
    return YES;
    
    
}
-(void)releaseBtn{
    [UIView animateWithDuration:0.3 animations:^{
        _secondViewTableView.contentOffset = CGPointMake(0, 0);
        
    }];
   
    
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
