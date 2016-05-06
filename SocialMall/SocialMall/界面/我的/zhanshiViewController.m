//
//  zhanshiViewController.m
//  SocialMall
//
//  Created by MC on 16/1/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "zhanshiViewController.h"
#import "zhanshiTableViewCell.h"
#import "faXianModel.h"
#import "MCXQViewController.h"
#import "CLAnimationView.h"
@interface zhanshiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger _page;

}

@end

@implementation zhanshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    if ([_keyStr isEqualToString:@"1"]) {
      self.title = @"发布列表";
    }
    else if ([_keyStr isEqualToString:@"2"])
    {
        self.title = @"赞过列表";
 
    }
    else if ([_keyStr isEqualToString:@"3"])
    {
        self.title = @"收到的赞";
        
    }
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)actionheadRefresh{
    _page = 0;
    [_dataArray removeAllObjects];
    [self loadata:YES];
    
    
}
-(void)actionFooer{
    _page ++;

    [self loadata:YES];
}

-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView ];
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(actionheadRefresh)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(actionFooer)];
    [self loadata:YES];
    
    
}
-(void)loadata:(BOOL)Refresh{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"userId"]) {
        // [self prepareUI2];
        [self showAllTextDialog:@"没登陆"];
        return;
        
        
    }
    NSString * userId = [defaults objectForKey:@"userId"];
    
    

    NSDictionary * Parameterdic = @{
                                    @"userId":_userStr?_userStr:userId,
                                     @"page":@(_page)
                                    
                                    };
//     if ([_keyStr isEqualToString:@"3"])
//    {
//        Parameterdic = @{
//                        
//                         @"page":@(_page)
//                         
//                         };
//        
//    }
    
    NSString * urlstr;
    if ([_keyStr isEqualToString:@"1"]) {
        urlstr = @"Msg/showMessage";

    }
    else if ([_keyStr isEqualToString:@"2"])
    {
        urlstr = @"Msg/messageLiked";
        
    }
    else if ([_keyStr isEqualToString:@"3"])
    {
        urlstr = @"Msg/getLike";

    }
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:urlstr Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *messageList = resultDic[@"data"][@"messageList"];
        if ([_keyStr isEqualToString:@"3"])
        {
          
            messageList = resultDic[@"data"][@"list"];
        }

        for (NSDictionary * dic in messageList) {
            faXianModel * model = [faXianModel mj_objectWithKeyValues:dic];
            for (NSDictionary * dic1 in dic[@"like_list"]) {
                [model addlike_listDic:dic1];
                
            }

            [_dataArray addObject:model];
        }
        
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];

        
        [_tableView reloadData];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];

        NSLog(@"失败");
        
    }];

    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    zhanshiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zhanshiTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"zhanshiTableViewCell" owner:self options:nil]lastObject];
    }
    if (_dataArray.count > indexPath.row) {
        
    
        [cell.fenxianBtn addTarget:self action:@selector(actionFenX:) forControlEvents:UIControlEventTouchUpInside];
        cell.fenxianBtn.tag = indexPath.row + 1000000;
        faXianModel * model = _dataArray [indexPath.row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"releaes_default-photo"]];
        
        cell.titleLbl.text = model.content;
        [cell.pinglunBtn setTitle:model.comments forState:0];
        [cell.aixinBtn setTitle:model.like forState:0];
        
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        
        NSString * userId = [defaults objectForKey:@"userId"];
        if ([userId isEqualToString:model.user_id]) {
            cell.fenxianBtn.hidden = NO;

        }
        else
        {
            cell.fenxianBtn.hidden = YES;

        }
    
    
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_dataArray.count > indexPath.row) {

    faXianModel * model = _dataArray [indexPath.row];
    MCXQViewController * ctl = [[MCXQViewController alloc]init];
    ctl.faxianModel = model;
    [self pushNewViewController:ctl];
    }
}
-(void)actionFenX:(UIButton*)btn{
    
     faXianModel * model = _dataArray [btn.tag - 1000000];
    
    CLAnimationView *animationView = [[CLAnimationView alloc]initWithTitleArray:@[@"朋友圈",@"微信好友"] picarray:@[@"share_friends",@"share_wechat"]];
    __weak MCXQViewController *weakSelf = self;
    
    [animationView selectedWithIndex:^(NSInteger index) {
        NSLog(@"你选择的index ＝＝ %ld",(long)index);
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        NSString * url = [NSString stringWithFormat:@"111"];
        [dic setObject:url forKey:@"url"];
        [dic setObject:model.content forKey:@"title"];
        [dic setObject:@"分享详情" forKey:@"titlesub"];
        
        
        if (index == 1) {
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatTimeline PopToRoot:NO SsDic:dic];
            
        }
        else
        {
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatSession PopToRoot:NO SsDic:dic];
            
        }
        
        
        
        
        
        
        
    }];
    [animationView CLBtnBlock:^(UIButton *btn) {
        NSLog(@"你点了选择/取消按钮");
    }];
    [animationView show];

    
    
}
//编辑时调用的两个协议方法
//一返回编辑状态
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_keyStr isEqualToString:@"1"]) {
        //这个方法默认返回删除状态
        return UITableViewCellEditingStyleDelete;

    }
    return UITableViewCellEditingStyleNone;
}
//提交编辑操作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_keyStr isEqualToString:@"1"]) {
        //这个方法默认返回删除状态
        [self delMessage:indexPath];
    }


    
}
-(void)delMessage:(NSIndexPath*)indexPath{
    faXianModel * model =   _dataArray[indexPath.row];
    if (!model.id) {
        return;
    }

    [self showLoading:YES AndText:nil];
    NSDictionary * Parameterdic = @{
                                    @"id":model.id
                                  
                                    
                                    };

    [self.requestManager requestWebWithParaWithURL:@"Msg/delMessage" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        //删除的效果,tableView已经帮我们实现好了
        //我们需要作的事是将数据源中的需要被删除的数据,移除掉
        [_dataArray removeObjectAtIndex:indexPath.row];
        //删除完成后,我们需要刷新一下表格视图
        //a.可以刷新整个视图
        //这种刷新方式不适用于刷单格,或少部分数据
        //而是用在需要刷新整个视图时
        //[_tableView reloadData];
        
        //b.针对删除的行,进行刷新
        //第一个参数需要是一个数组,当前删除行的indexPath数组
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectloadData2Notification" object:nil];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];

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
