//
//  zhanshiViewController.m
//  SocialMall
//
//  Created by MC on 16/1/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "zhanshiViewController.h"
#import "zhanshiTableViewCell.h"
#import "zhanshiModel.h"
@interface zhanshiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
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
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView ];
    
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
                                    @"userId":userId
                                    };
    
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
        urlstr = @"Msg/messageLiked";

    }
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:urlstr Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *messageList = resultDic[@"data"][@"messageList"];
        for (NSDictionary * dic in messageList) {
            zhanshiModel * model = [zhanshiModel mj_objectWithKeyValues:dic];
            [_dataArray addObject:model];
        }
        
        
        
        [_tableView reloadData];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
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
        
    
    if (indexPath.row == 0) {
        cell.fenxianBtn.hidden = YES;
    }
    else
    {
        cell.fenxianBtn.hidden = NO;

        
    }
        zhanshiModel * model = _dataArray [indexPath.row];
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
