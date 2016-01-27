//
//  fabu5ViewController.m
//  SocialMall
//
//  Created by MC on 15/12/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "fabu5ViewController.h"
#import "titleTableViewCell.h"
#import "fabu5TableViewCell.h"
#import "fabu6TableViewCell.h"
#import "Fabu4ViewController.h"
#import "liebiaoTableViewCell.h"

@interface fabu5ViewController ()<UITableViewDataSource,UITableViewDelegate,fabu4Viewdelegate>
{
    UITableView*_tableView;
    NSInteger _xuanzheIndedx;

    
}
@end

@implementation fabu5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _xuanzheIndedx = -1;
    self.title  =@"确定发布";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonFabu)];

    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64 , Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
   // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self headView];

    
}
-(UIView*)headView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
    imgView.image = _dataDic[@"img"];
    [view addSubview:imgView];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES; // 裁剪边缘
    
    return view;
    
}
-(void)rightBarButtonFabu{
    
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 1;
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat h = [MCIucencyView heightForString:_dataDic[@"title"] fontSize:13 andWidth:Main_Screen_Width - 10];
        return h + 20;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 50;
        }
        
        if (indexPath.row == 3) {
            return 30;
        }
        
        
        
        
    }
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        titleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mac"];
        if (!cell) {
            cell = [[titleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mac"];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        cell.titleStr = _dataDic[@"title"];
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            fabu5TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mac2"];
            if (!cell) {
                cell = [[fabu5TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mac2"];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            cell.title2Str = @"1123231";
            return cell;
         }
        
        
        
        if (indexPath.row == 3) {
            fabu6TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"fabu6TableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"fabu6TableViewCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell.btn addTarget:self action:@selector(ActionBtn) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
        if (indexPath.row != 0 || indexPath.row != 3) {
            static NSString * cellid2 = @"mcm";
            liebiaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[liebiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            }
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nameStr = @"xxxxxxxxx";
            cell.mashuStr = @"GAP";
            cell.deleBtn.tag = 800 + indexPath.row;
            [cell.deleBtn addTarget:self action:@selector(ACtionDeleBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (indexPath.row == _xuanzheIndedx) {
                cell.bgView.backgroundColor = [UIColor lightGrayColor];
            }
            else
            {
                cell.bgView.backgroundColor = [UIColor whiteColor];
                
            }
            return cell;

        }
        
        
        
    }
    return [[UITableViewCell alloc]init];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        if (indexPath.row != 0 || indexPath.row != 1) {
            

        _xuanzheIndedx = indexPath.row;
        //一个section刷新
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
}
-(void)ACtionDeleBtn:(UIButton*)btn{
    
    
    
}

-(void)ActionBtn{
    
    fabu4ViewController * ctl = [[fabu4ViewController alloc]init];
    ctl.delegate = self;
    [self pushNewViewController:ctl];

    
}
-(void)backDic:(NSDictionary *)dic
{
    
    
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
