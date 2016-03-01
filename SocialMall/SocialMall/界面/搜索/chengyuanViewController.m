//
//  chengyuanViewController.m
//  SocialMall
//
//  Created by MC on 16/1/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "chengyuanViewController.h"
#import "FenGuanTableViewCell.h"
#import "GerenViewController.h"
#import "userDatamodel.h"

@interface chengyuanViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    
    UITableView *_tableView;

    NSMutableArray *_dataarray;

    
    NSInteger _page;

    NSString *_seachStr;

}

@end

@implementation chengyuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    _dataarray = [NSMutableArray array];

    self.view.frame = CGRectMake(Main_Screen_Width * 2, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64);
    //输入框搜索
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectCYObj:) name:@"didSelectCYObjNotification" object:nil];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)didSelectCYObj:(NSNotification*)Notification{
    
   // [self searchsearch:YES Seachstr:Notification.object];
    
    [_dataarray removeAllObjects];
   

    [self searchsearch:YES Seachstr:Notification.object];
    
}
#pragma mark-获取数据
-(void)searchsearch:(BOOL)Refresh Seachstr:(NSString*)seachstr{
    _seachStr = seachstr;
    NSDictionary * Parameterdic = @{
                                    @"searchType":@"member",
                                    @"keyword":seachstr?seachstr:@"",
                                    @"page":@(_page),
                                    
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"System/search" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *  messageList = resultDic[@"data"][@"returnList"];
        for (NSDictionary * dic in messageList) {
            userDatamodel * model = [userDatamodel mj_objectWithKeyValues:dic];
            [_dataarray addObject:model];
            
        }
        [_tableView reloadData ];
        
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        
        
    }];
    
    
}
-(void)actionheadRefresh{
    [_dataarray removeAllObjects];
    _page = 0;
    [self searchsearch:YES Seachstr:_seachStr];
    
    
}
-(void)actionFooer{
    _page ++;
    [self searchsearch:YES Seachstr:_seachStr];
    
    
    
    
}


-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(actionheadRefresh)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(actionFooer)];

    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FenGuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FenGuanTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FenGuanTableViewCell" owner:self options:nil]lastObject];
    }
    if (_dataarray.count > indexPath.row) {
        userDatamodel * modle = _dataarray[indexPath.row];
        cell.namelbl.text = @"";
        [cell.headViewimg sd_setImageWithURL:[NSURL URLWithString:modle.image] placeholderImage:[UIImage imageNamed:@"Avatar_42"]];
        ViewRadius(cell.headViewimg, 15);
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_dataarray.count > indexPath.row) {
        userDatamodel * modle = _dataarray[indexPath.row];
        if (!modle.id)
            return;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectFsearchGRObjNotification" object:modle.id];

        
        
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
