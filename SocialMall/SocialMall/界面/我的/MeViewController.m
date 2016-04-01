//
//  MeViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MeViewController.h"
#import "me1TableViewCell.h"
#import "me2TableViewCell.h"
#import "me3TableViewCell.h"
#import "settgViewController.h"
#import "yonghuViewController.h"
#import "MyshouyiViewController.h"
#import "tixingViewController.h"
#import "tixing2ViewController.h"
#import "FenGuanViewController.h"
#import "zhanshiViewController.h"
#import "me4TableViewCell.h"
#import "loginViewController.h"
#import "userDatamodel.h"
#import "MallViewController.h"
#import "ShoudaozanViewController.h"
@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    NSArray *_titleArray;
    NSArray *_imgArray;
    userDatamodel * _usermodel;
    BOOL _Refresh;
    NSString * _cityStr;
}

@end

@implementation MeViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //跳登录
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:@"didSelectDLNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData2:) name:@"didSelectloadData2Notification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCity:) name:@"didupdateCityNotification" object:nil];


    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    /*保存数据－－－－－－－－－－－－－－－－－begin*/
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    _cityStr = [defaults objectForKey:@"city"];
    

    _titleArray = @[@"我的收益",@"收货地址管理",@"消息提醒",@"我的收藏",@"我的订单"];
    _imgArray = @[@"我的收益",@"收货地址管理",@"消息提醒",@"我的收藏",@"我的订单"];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)login:(NSNotification*)Notification{
    
    loginViewController * ctl = [[loginViewController alloc]init];
    ctl.isMeCtl = YES;
    [self pushNewViewController:ctl];

    
}
-(void)updateCity:(NSNotification*)Notification{
    
    if (!_cityStr) {
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"city":_cityStr
                                    };

    [self.requestManager requestWebWithParaWithURL:@"User/updateCity" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"返回==%@",resultDic);
      //  [_tableView reloadData];

    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        
        [self showAllTextDialog:description];

    } ];
    
}
-(void)loadData2:(NSNotification*)Notification{
    if (!_Refresh)
    [self loadaData:YES];
    
}
-(void)prepareUI{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_set-up_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionrightBar)];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    if (self.isgion) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didupdateCityNotification" object:@""];
    }
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    if ([defaults objectForKey:@"sessionId"]) {
//        // [self prepareUI2];
//        [self loadaData:YES];
//
//
//    }
    
}
-(void)loadaData:(BOOL)Refresh{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    if (![defaults objectForKey:@"userId"]) {
        // [self prepareUI2];
        [self showAllTextDialog:@"没登陆"];
        return;
        
        
    }
    NSString * userId = [defaults objectForKey:@"userId"];
    
    
    NSDictionary * Parameterdic = @{
                                    @"userId":userId
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    
    _Refresh = YES;
    [self.requestManager requestWebWithGETParaWith:@"User/userInfo" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        _Refresh = NO;

        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        _usermodel = [userDatamodel mj_objectWithKeyValues:resultDic[@"data"][@"data"]];
        
       
        if (_usermodel.headimgurl) {
            /*保存数据－－－－－－－－－－－－－－－－－begin*/
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

            [defaults setObject:_usermodel.headimgurl forKey:@"headimgurl"];
            //强制让数据立刻保存
            [defaults synchronize];

        }
        
        
        
        
        [_tableView reloadData];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        
        [self showAllTextDialog:description];
        _Refresh = NO;
        NSLog(@"失败");
        
    }];
 
    
    
}
-(void)ActionrightBar{
    settgViewController * ctl = [[settgViewController alloc]init];
    ctl.userModel = _usermodel;

    [self pushNewViewController:ctl];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section== 0)
    return 10;
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 240;
    }
//    if (indexPath.section == 1) {
//        return 44;
//    }
//    if (indexPath.section == 2) {
//        return 126;
//    }
    return 44;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
       
        return 1;
    }
    return 5;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {//头
        me1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me1TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me1TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headBtn.tag = 2000;
        cell.zanbtn.tag = 2001;
        cell.fenbtn.tag = 2002;
        cell.guanBtn.tag = 2003;
        cell.zhanBtn.tag = 2004;
        cell.shoudaozanBtn.tag = 2005;
        [cell.headBtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.zanbtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fenbtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.guanBtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.zhanBtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shoudaozanBtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];

        
        [cell.headImgview sd_setImageWithURL:[NSURL URLWithString:_usermodel.headimgurl] placeholderImage:[UIImage imageNamed:@"Avatar_136"]];
        ViewRadius(cell.headImgview, 70/2);

        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

        NSString * userPhone =[defaults objectForKey:@"UserPhone"];
        cell.nameLbl.text = _usermodel.nickname ? _usermodel.nickname:userPhone;
        
        cell.qianmingLbl.text = [NSString stringWithFormat:@"%@",_usermodel.autograph];
        
        cell.guanzhuLbl.text = _usermodel.follows;
        cell.fensiLbl.text = _usermodel.fans;
        cell.zanLbl.text = _usermodel.likeds;
        cell.zhanshiLbl.text = _usermodel.messages;
        cell.sexLbl.text = [_usermodel.sex isEqualToString:@"0"]? @"男":@"女";
        cell.shoudaoZanLbl.text = _usermodel.receiveLikeds;
        cell.dingweiLbl.text =[_usermodel.city length] ? _usermodel.city : _cityStr;
        
        
        return cell;

    }
     if (indexPath.section == 1) {
         
         me4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me4TableViewCell"];
         if (!cell) {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"me4TableViewCell" owner:self options:nil]lastObject];
         }
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         cell.imgView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
         cell.tiltleLbl.text = _titleArray[indexPath.row];
         if (indexPath.row == 2) {
             /*保存数据－－－－－－－－－－－－－－－－－begin*/
             NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
             if ([[defaults objectForKey:@"isdingdan"] isEqualToString:@"1"]) {
                 cell.hongdianView.hidden = NO;
             }
             else
             {
                 cell.hongdianView.hidden = YES;

             }
             ViewRadius(cell.hongdianView, 4);
            
         }
         else
             cell.hongdianView.hidden = YES;
         return cell;
         
         
         
     }
    
    /*弃用
    if (indexPath.section == 1) {
        
        
        
        me2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me2TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me2TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.shouyiBtn.tag = 3000;
        cell.quanbuBtn.tag = 3001;
        cell.shouruBtn.tag = 3002;
        cell.tixianBtn.tag = 3003;
        
        [cell.shouyiBtn addTarget:self action:@selector(actionCell2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.quanbuBtn addTarget:self action:@selector(actionCell2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shouruBtn addTarget:self action:@selector(actionCell2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tixianBtn addTarget:self action:@selector(actionCell2:) forControlEvents:UIControlEventTouchUpInside];

        
        
        
        
        
        return cell;
    }
    if (indexPath.section == 2) {
        me3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me3TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me3TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.shouhuoBtn.tag = 4000;
        cell.tixingBtn.tag = 4001;
        cell.shouchangBtn.tag = 4002;
        cell.dingdanBtn.tag = 4003;
        [cell.shouhuoBtn addTarget:self action:@selector(actionCell3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tixingBtn addTarget:self action:@selector(actionCell3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shouchangBtn addTarget:self action:@selector(actionCell3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.dingdanBtn addTarget:self action:@selector(actionCell3:) forControlEvents:UIControlEventTouchUpInside];

        
        return cell;

    }
     */
    return [[UITableViewCell alloc]init];

    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //收益
            MyshouyiViewController * ctl = [[MyshouyiViewController alloc]init];
            [self pushNewViewController:ctl];

        }
        if (indexPath.row == 1) {
//            //默认的图片
//            [self.tabBarItem setImage:[[UIImage imageNamed:@"mall_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//            self.tabBarItem.image = [UIImage imageNamed:@"mall_normal"];
            //self.tabBarController.tabBar.tintColor = [UIColor grayColor];
            //收货
            //[self showAllTextDialog:@"跳H5?"];
            MallViewController *mall = [[MallViewController alloc]init];
            mall.menuagenturl = [NSString stringWithFormat:@"%@Consignee/addressList",AppURL];
            
            
            //@"http://snsshop.111.xcrozz.com/Shop/Consignee/addressList";
            [self pushNewViewController:mall];

        }
        if (indexPath.row == 2) {
            //提醒
            //tixingViewController * ctl = [[tixingViewController alloc]init];
              tixing2ViewController * ctl = [[tixing2ViewController alloc]init];
            ctl.dagteView = self;
            [self pushNewViewController:ctl];
        }
        if (indexPath.row == 3) {
            //收藏
           // [self showAllTextDialog:@"跳H5?"];
            MallViewController *mall = [[MallViewController alloc]init];
            mall.menuagenturl = [NSString stringWithFormat:@"%@Goods/praiseList.html",AppURL];//@"http://snsshop.111.xcrozz.com/Shop/Goods/praiseList.html";
            [self pushNewViewController:mall];

        }
        if (indexPath.row == 4) {
            //订单
           // [self showAllTextDialog:@"跳H5?"];
            MallViewController *mall = [[MallViewController alloc]init];
            mall.menuagenturl = [NSString stringWithFormat:@"%@Order/index.html",AppURL];//@"http://snsshop.111.xcrozz.com/Shop/Order/index.html";
            [self pushNewViewController:mall];
        }
        

        
    }
    
    
}
#pragma mark-第一个cell的点击
-(void)actionCell1:(UIButton*)btn{
    if (btn.tag == 2000) {
        //人头
        yonghuViewController * ctl = [[yonghuViewController alloc]init];
        ctl.isMy = YES;
        ctl.userModel = _usermodel;
        [self pushNewViewController:ctl];
        
    }
    else if(btn.tag == 2001){
        //赞'
        zhanshiViewController * ctl = [[zhanshiViewController alloc]init];
        ctl.keyStr = @"2";
        [self pushNewViewController:ctl];

        
    }
    else if(btn.tag == 2002){
        //粉
        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        ctl.titleStr = @"2";
        [self pushNewViewController:ctl];
        
    } else if(btn.tag == 2003){
        //关
        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        ctl.titleStr = @"1";
        [self pushNewViewController:ctl];

        
    } else if(btn.tag == 2004){
        //展
        
        zhanshiViewController * ctl = [[zhanshiViewController alloc]init];
        ctl.keyStr = @"1";
        [self pushNewViewController:ctl];

        
    }
    else if(btn.tag == 2005){
        //收到的赞
        
        ShoudaozanViewController * ctl = [[ShoudaozanViewController alloc]init];
        [self pushNewViewController:ctl];
        
        
    }

    
    
    
}
/*弃用
#pragma mark-第2个cell的点击
-(void)actionCell2:(UIButton*)btn{
    //收益
    MyshouyiViewController * ctl = [[MyshouyiViewController alloc]init];
    if (btn.tag == 3000) {
        ctl.index = 0;
        
    }
    else if(btn.tag == 3001){
        //全
        ctl.index = 0;

    }
    else if(btn.tag == 3002){
        //收
        ctl.index = 1;

    } else if(btn.tag == 3003){
        //提
        ctl.index = 2;

    }     
    
[self pushNewViewController:ctl];
    
    
}
 
#pragma mark-第3个cell的点击
-(void)actionCell3:(UIButton*)btn{
    if (btn.tag == 4000) {
        //收货
        
    }
    else if(btn.tag == 4001){
        //提醒
        tixingViewController * ctl = [[tixingViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    else if(btn.tag == 4002){
        //收藏
        
    } else if(btn.tag == 4003){
        //订
        
    }
    
    
    
    
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadCell
{
    [_tableView reloadData];
}
-(void)pushDingdan{
    
    MallViewController *mall = [[MallViewController alloc]init];
    mall.menuagenturl = [NSString stringWithFormat:@"%@Order/index.html",AppURL];//@"http://snsshop.111.xcrozz.com/Shop/Order/index.html";
    [self pushNewViewController:mall];
  
    
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
