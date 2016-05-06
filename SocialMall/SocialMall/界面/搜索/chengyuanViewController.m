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
#import "noDataTableViewCell.h"
#import "ItemView.h"
#import "KeywordModel.h"

@interface chengyuanViewController ()<UITableViewDataSource,UITableViewDelegate,ItemViewDelegate>{

    
    UITableView *_tableView;

    NSMutableArray *_dataarray;
    NSMutableArray *_keywordArray;

    
    NSInteger _page;

    NSString *_seachStr;
    BOOL _isnoData;

    UIView *_bgView;

    UIView*_headView;
    ItemView*_itemView;

    
    

}

@end

@implementation chengyuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    _dataarray = [NSMutableArray array];
    _keywordArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    if (!_sekyStr)
        [self searchTagFG:YES];
    self.view.frame = CGRectMake(Main_Screen_Width * 2, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64);
    //输入框搜索
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectCYObj:) name:@"didSelectCYObjNotification" object:nil];
    [self prepareUI];
    //[self searchsearch:YES Seachstr:@""];

    // Do any additional setup after loading the view.
}
-(void)didSelectCYObj:(NSNotification*)Notification{
    
   // [self searchsearch:YES Seachstr:Notification.object];
    
    [_dataarray removeAllObjects];
   
    _page = 0;
    [self searchsearch:YES Seachstr:Notification.object];
    
}
#pragma mark-获取标签
-(void)searchTagFG:(BOOL)Refresh {
    
    NSDictionary * Parameterdic = @{
                                    @"searchType":@"member"
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"System/searchTag" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        NSArray *  messageList = resultDic[@"data"][@"keyword"];
        for (NSDictionary * dic in messageList) {
            KeywordModel * model = [KeywordModel mj_objectWithKeyValues:dic];
            [_keywordArray addObject:model];
            
        }
        [self nosearchView];
//
        
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
    }];
    
    
}
-(void)nosearchView{
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 20)];
    lbl.text = @"推荐";
    lbl.textColor = [UIColor darkGrayColor];
    lbl.font = AppFont;
    [_headView addSubview:lbl];
    
    
    _itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width , 100) Skeystr:@"1"];
    _itemView.seleColor = [UIColor whiteColor];
    
    _itemView.delegate = self;
    _itemView.itemHeith = 25;
    NSMutableArray * arr = [NSMutableArray array];
    for (KeywordModel * model in _keywordArray) {
        [arr addObject:model.tag];
        
    }
    _itemView.itemArray = arr;//@[@"的萨芬",@"撒旦飞洒地方",@"阿斯顿",@"撒地方",@"阿斯顿发送到",@"阿斯蒂芬斯蒂芬",@"撒地方",@"撒地方都是"];
    
    [_headView addSubview:_itemView];
    _itemView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    
    
}
#pragma mark-_itemView代理
-(void)itemH:(CGFloat)itemh
{
    _itemView.frame = CGRectMake(CGRectGetMinX(_itemView.frame), CGRectGetMinY(_itemView.frame), CGRectGetWidth(_itemView.frame), itemh + 10);
    _headView.frame = CGRectMake(CGRectGetMinX(_headView.frame), CGRectGetMinY(_headView.frame), CGRectGetWidth(_headView.frame), itemh + 10 + 30);
    
}
-(void)seleIndex:(NSInteger)index
{
    NSString * ss = _itemView.itemArray[index];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectTextFieldObjNotification" object:ss];
    _headView.hidden = YES;
    _bgView.hidden = NO;
    
    [self searchsearch:YES Seachstr:ss];
    
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
        if (_dataarray.count==0 || !_dataarray) {
            _isnoData = YES;
        }
        else
        {
            _isnoData = NO;
            
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
        _isnoData = YES;

        
         [_tableView reloadData ];
        
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
    _bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgView.hidden = YES;
    [self.view addSubview:_bgView];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [_bgView addSubview:_tableView];
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(actionheadRefresh)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(actionFooer)];

    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isnoData) {
        return Main_Screen_Height - 64 - 44;
    }
    else
        
        //item
        return 44;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isnoData) {
        return 1;
    }
    else

    return _dataarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isnoData) {
       
        noDataTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"noDataTableViewCell"];

        if (!cell) {
            cell = [[noDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noDataTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else{

    
    
    FenGuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FenGuanTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FenGuanTableViewCell" owner:self options:nil]lastObject];
    }
    if (_dataarray.count > indexPath.row) {
        userDatamodel * modle = _dataarray[indexPath.row];
        cell.namelbl.text = modle.nickname;
        [cell.headViewimg sd_setImageWithURL:[NSURL URLWithString:modle.image] placeholderImage:[UIImage imageNamed:@"Avatar_42"]];
        ViewRadius(cell.headViewimg, 15);
        
    }
    return cell;
    }
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isnoData) {
        
        return;
        
    }
    
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
