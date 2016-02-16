//
//  FenGuanViewController.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "FenGuanViewController.h"
#import "FenGuanTableViewCell.h"
#import "GerenViewController.h"
#import "userDatamodel.h"
@interface FenGuanViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *_dataArray;

}

@end

@implementation FenGuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];

    if([_titleStr isEqualToString:@"1"]){
        self.title = @"关注列表";
    }
    if([_titleStr isEqualToString:@"2"]){
        self.title = @"粉丝列表";
    }
    if([_titleStr isEqualToString:@"3"]){
        self.title = @"点赞列表";
    }
    

    
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
    if ([_titleStr isEqualToString:@"1"]) {
        urlstr = @"Friends/friendsList";
        
    }
    else if ([_titleStr isEqualToString:@"2"])
    {
        urlstr = @"Msg/fansList";
        
        
    }
    else if ([_titleStr isEqualToString:@"3"])
    {
        urlstr = @"Msg/messageLiked";
        
    }
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:urlstr Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *messageList = resultDic[@"data"][@"fansList"];
        for (NSDictionary * dic in messageList) {
            userDatamodel * model = [userDatamodel mj_objectWithKeyValues:dic];
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
    if (_dataArray.count > indexPath.row) {
        userDatamodel * model = _dataArray[indexPath.row];
    
        [cell.headViewimg sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholderImage:[UIImage imageNamed:@"Avatar_42"]];
        ViewRadius(cell.headViewimg, 30/2);
        cell.namelbl.text = model.nickname;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_dataArray.count > indexPath.row) {
        
    
    GerenViewController * ctl = [[GerenViewController alloc]init];
        userDatamodel * model = _dataArray[indexPath.row];

        ctl.user_id = model.user_id;//_dataArray[indexPath]
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
