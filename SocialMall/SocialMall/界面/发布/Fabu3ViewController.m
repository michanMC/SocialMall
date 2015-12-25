//
//  Fabu3ViewController.m
//  SocialMall
//
//  Created by MC on 15/12/25.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "Fabu3ViewController.h"
#import "ItemView.h"
#import "Fabu3TableViewCell.h"
@interface Fabu3ViewController ()<UITableViewDataSource,UITableViewDelegate,ItemViewDelegate>
{
    
    UITableView *_tableView;
    UIView*_headView;
    ItemView*_itemView;

    
}

@end

@implementation Fabu3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搭配列表";
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];
    [self headView];
    
    
}
-(void )headView{
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    [self.view addSubview:_headView];
    _headView.backgroundColor = [UIColor whiteColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    imgView.image = [UIImage imageNamed:@"style_icon02"];
    [_headView addSubview:imgView];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(30, 7, 100, 20)];
    lbl.text = @"风格选择";
    lbl.textColor = [UIColor darkGrayColor];
    lbl.font = AppFont;
    [_headView addSubview:lbl];
    
    
    _itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width , 100)];
    _itemView.delegate = self;
    _itemView.itemHeith = 25;
    _itemView.itemArray = @[@"的萨芬",@"撒旦飞洒地方",@"阿斯顿",@"撒地方",@"阿斯顿发送到",@"阿斯蒂芬斯蒂芬",@"撒地方",@"撒地方都是"];
    
    [_headView addSubview:_itemView];
    _itemView.backgroundColor = [UIColor whiteColor];
    
//    __weak typeof(ItemView) *weakItem = _itemView;
//    __weak typeof(UIView) *weakview = _headView;
//    __weak typeof(UITableView) * weakTableView = _tableView;
//
//    [_itemView ItemViewWithBlock:^(id obj) {
//        CGFloat heith = [obj integerValue];
//        weakItem.frame = CGRectMake(CGRectGetMinX(weakItem.frame), CGRectGetMinY(weakItem.frame), CGRectGetWidth(weakItem.frame), heith + 10);
//         weakview.frame = CGRectMake(CGRectGetMinX(weakview.frame), CGRectGetMinY(weakview.frame), CGRectGetWidth(weakview.frame), heith + 10 + 30);
//        weakTableView.tableHeaderView =weakview;// [self headView];
//
//    }];
    
    
    
}
#pragma mark-_itemView代理
-(void)itemH:(CGFloat)itemh
{
    _itemView.frame = CGRectMake(CGRectGetMinX(_itemView.frame), CGRectGetMinY(_itemView.frame), CGRectGetWidth(_itemView.frame), itemh + 10);
    _headView.frame = CGRectMake(CGRectGetMinX(_headView.frame), CGRectGetMinY(_headView.frame), CGRectGetWidth(_headView.frame), itemh + 10 + 30);
    _tableView.tableHeaderView =_headView;// [self headView];
 
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat x = 5;
    CGFloat offx = 5;
    CGFloat y = 40;
    CGFloat width = (Main_Screen_Width - 4 * 5)/3;
    CGFloat height = width;
    for (int i = 0; i < 6; i ++){
        
        int row=i/3;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%3;//列号
        
        x=offx+(offx+width)*loc ;
        y=offx+(offx+height)*row;

    }

    
    return y+height + 2 * 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"mcq";
    Fabu3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[Fabu3TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell prepareUI:nil];
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
