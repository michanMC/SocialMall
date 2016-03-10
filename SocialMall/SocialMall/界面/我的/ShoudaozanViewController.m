//
//  ShoudaozanViewController.m
//  SocialMall
//
//  Created by MC on 16/3/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoudaozanViewController.h"
#import "ShoudaozanTableViewCell.h"
#import "faXianModel.h"
#import "GerenViewController.h"
@interface ShoudaozanViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger _page;

    
}

@end

@implementation ShoudaozanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收到的赞";
    _dataArray = [NSMutableArray array];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView ];
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(actionheadRefresh)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(actionFooer)];
    [self loadata:YES];

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

-(void)loadata:(BOOL)Refresh{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"userId"]) {
        // [self prepareUI2];
        [self showAllTextDialog:@"没登陆"];
        return;
        
        
    }
    NSString * userId = [defaults objectForKey:@"userId"];
    
    
    
    NSDictionary * Parameterdic = @{
                                    @"userId":_userIdStr? _userIdStr: userId,
                                    @"page":@(_page)
                                    
                                    };
    
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/getLike" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *messageList = resultDic[@"data"][@"list"];
        for (NSDictionary * dic in messageList) {
            faXianModel * model = [faXianModel mj_objectWithKeyValues:dic];
//            for (NSDictionary * dic1 in dic[@"like_list"]) {
//                [model addlike_listDic:dic1];
//                
//            }
            
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
    return _dataArray.count;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoudaozanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShoudaozanTableViewCell"];
    if (!cell) {
        cell = [[ShoudaozanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellStyleDefault"];
    }
    if (_dataArray.count > indexPath.section) {
        faXianModel * model = _dataArray [indexPath.section];

        cell.nameLbl.text = model.nickname;
        [cell.headimgView sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholderImage:[UIImage imageNamed:@"Avatar_76"]];
        
        cell.timeLbl.text = [CommonUtil getStringWithLong:[model.add_time longLongValue] Format:@"MM月dd日 HH:mm"];
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"message_default-photo"]];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_dataArray.count > indexPath.section) {
        
        faXianModel * model = _dataArray [indexPath.section];
        GerenViewController *ctl = [[GerenViewController alloc]init];
        ctl.user_id = model.user_id;
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
