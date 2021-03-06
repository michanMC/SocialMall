//
//  Fabu3ViewController.m
//  SocialMall
//
//  Created by MC on 15/12/25.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "Fabu3ViewController.h"
#import "Fabu4ViewController.h"
#import "Fabu5ViewController.h"
#import "ItemView.h"
#import "Fabu3TableViewCell.h"
#import "Fabu7TableViewCell.h"

#import "liebiaoTableViewCell.h"
#import "KeywordModel.h"
#import "addMesModel.h"
@interface Fabu3ViewController ()<UITableViewDataSource,UITableViewDelegate,fabu4Viewdelegate,ItemViewDelegate,Fabu3ViewDelegate,UITextFieldDelegate>
{
    
    UITableView *_tableView;
    UIView*_headView;
    ItemView*_itemView;
    NSInteger _xuanzheIndedx;
    NSMutableArray * _keywordArray;
    NSMutableArray * _purchasedGoodsArray;
    NSMutableArray *_fengeArray;
    KeywordModel * selemodel;
    addMesModel * goods_modle;
    
    NSMutableArray * _goodsArray;
    
    
    
    NSString *_spnameStr;
    NSString * _pipaiStr;
    NSString * _qitaStr;

    
    
}
@property(nonatomic,strong)NSMutableDictionary *dataDic;

@end

@implementation Fabu3ViewController
-(void)loadData{
    [_tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _keywordArray = [NSMutableArray array];
    _purchasedGoodsArray = [NSMutableArray array];
    _goodsArray = [NSMutableArray array];
    _fengeArray = [NSMutableArray array];
    _dataDic = [NSMutableDictionary dictionary];
    self.title = @"搭配列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonBaocun)];

    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _xuanzheIndedx = -1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];
    [self loadData:NO];
    
}
#pragma mark-获取风格
-(void)loadData:(BOOL)Refresh{
    [self showLoading:Refresh AndText:nil];
    
    
[self.requestManager requestWebWithParaWithURL:@"Msg/styleList" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
    
    [self hideHud];
    NSLog(@"成功");
    NSLog(@"返回==%@",resultDic);
    
    NSArray *  messageList = resultDic[@"data"][@"styleList"];
    for (NSDictionary * dic in messageList) {
        KeywordModel * model = [KeywordModel mj_objectWithKeyValues:dic];
        [_keywordArray addObject:model];
        
    }

//[self headView];
//
[self loadData2:YES];
    
} Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
    [self hideHud];
    [self showAllTextDialog:description];

}];
    
    
}
-(void)seleIndex:(NSInteger)index
{
  selemodel  = _keywordArray[index];
    
    
}
#pragma mark-获取已购买
-(void)loadData2:(BOOL)Refresh{
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithParaWithURL:@"Msg/purchasedGoods" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        NSArray *  messageList = resultDic[@"data"][@"goodsData"];
        for (NSDictionary * dic in messageList) {
            addMesModel * model = [addMesModel mj_objectWithKeyValues:dic];
            [_purchasedGoodsArray addObject:model];
            
        }
        [self headView];
        [_tableView reloadData];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
    }];
    
    
}

-(void )headView{
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    [self.view addSubview:_headView];
    _headView.backgroundColor = [UIColor whiteColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    imgView.image = [UIImage imageNamed:@"风格选择"];
    [_headView addSubview:imgView];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(30, 7, 100, 20)];
    lbl.text = @"风格选择";
    lbl.textColor = [UIColor darkGrayColor];
    lbl.font = AppFont;
    [_headView addSubview:lbl];
    
    
    _itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width , 100)];
    _itemView.delegate = self;
    _itemView.itemHeith = 25;
    NSMutableArray * arr = [NSMutableArray array];
    for (KeywordModel * model in _keywordArray) {
        [arr addObject:model.name];
        
    }

    _itemView.itemArray = arr;//@[@"的萨芬",@"撒旦飞洒地方",@"阿斯顿",@"撒地方",@"阿斯顿发送到",@"阿斯蒂芬斯蒂芬",@"撒地方",@"撒地方都是"];
    
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
#pragma mark-保存
-(void)rightBarButtonBaocun{
    
    if (!selemodel) {
        [self showAllTextDialog:@"请选择风格"];return;
    }
   
    
    if (![_goodsArray count] && !_fengeArray.count) {
        
        // [self showAllTextDialog:@"请选择或添加商品"];return;
    }
    

    
    fabu5ViewController * ctl = [[fabu5ViewController alloc]init];
    ctl.deleGateView = self;
    ctl.fengeModel = selemodel;
   // ctl.goodsModel =
    ctl.addMesArray  = _fengeArray;
   // ctl.goodsArray  = _goodsArray;

     [_dataDic setObject:_image forKey:@"img"];
    
    [_dataDic setObject:_titleStr forKey:@"title"];
   // [_dataDic setObject:goods_id forKey:@"goods_id"];

    ctl.dataDic = _dataDic;
    [self pushNewViewController:ctl];
    
    
    
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
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1)
    return 1;
    if (section == 2) {
        NSInteger count= 0;
        for (addMesModel * modle in _fengeArray) {
            if (!modle.goods_id) {
                count++;
            }
        }
        return count;

    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 191;
    }
    if (indexPath.section == 1) {
        if (!_purchasedGoodsArray.count) {
            return 44;
        }

        BOOL ischao = NO;
        if (_purchasedGoodsArray.count > 6) {
             ischao = YES;
        }
        else
        {
            ischao = NO;
            
        }
        if (!ischao) {
            CGFloat x = 5;
            CGFloat offx = 5;
            CGFloat y = 40;
            CGFloat width = (Main_Screen_Width - 4 * 5)/3;
            CGFloat height = width;
            for (int i = 0; i < _purchasedGoodsArray.count; i ++){
                
                

                
                x += width + offx;
                if (i ==2) {
                    y += height + offx;
                    x = offx;
                }
                
                
            }
            return  y + 40 + 5;
            //y + h + 5;
            
            
        }
        else
        {
            
            NSInteger pagenum =  _purchasedGoodsArray.count / 6;
            NSInteger countnum = _purchasedGoodsArray.count % 6;
            CGFloat width = (Main_Screen_Width - 4 * 5)/3;
            
            CGFloat x = 5;
            CGFloat offx = 5;
            CGFloat y = 5;
            CGFloat height = width;
            
            CGFloat widthOffx= 0;
            
            NSInteger indexCount = 0;
            for (int a = 0; a < pagenum; a++) {
                
                
                for (int i = 0; i < 2; i ++){
                    
                    
                    for (int j = 0;j < 3;j++) {
                        
                        
                        indexCount ++;
                        x +=width + offx;
                        
                        
                        
                    }
                    x = widthOffx + offx;
                    y += width+ 5;
                    
                }
                widthOffx = Main_Screen_Width + a *Main_Screen_Width;
                x = widthOffx + offx;
                y = 5;
                
            }
            
            
            return  40 + width*2 + 5 + 30;
            
        }
        

        
        
        
        
//    CGFloat x = 5;
//    CGFloat offx = 5;
//    CGFloat y = 40;
//    CGFloat width = (Main_Screen_Width - 4 * 5)/3;
//    CGFloat height = width;
//    for (int i = 0; i < _purchasedGoodsArray.count; i ++){
//        
//        int row=i/3;//行号
//        //1/3=0,2/3=0,3/3=1;
//        int loc=i%3;//列号
//        
//        x=offx+(offx+width)*loc ;
//        y=offx+(offx+height)*row;
//
//    }
//        if (!_purchasedGoodsArray.count) {
//            return 44;
//        }
//    
//    return y+height + 1 * 40+10;
    }
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        static NSString * cellid0 = @"Fabu7TableViewCell";
        Fabu7TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid0];

            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"Fabu7TableViewCell" owner:self options:nil]lastObject];
    
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textFil1.delegate =self;
        cell.textFil2.delegate =self;
        cell.textFil3.delegate =self;
        cell.textFil1.tag = 8880;
        cell.textFil2.tag = 8881;
        cell.textFil3.tag = 8882;
        cell.textFil1.text = _spnameStr;
        cell.textFil2.text = _pipaiStr;
        cell.textFil3.text = _qitaStr;

        [cell.addBtn addTarget:self action:@selector(ActionAddBtn) forControlEvents:UIControlEventTouchUpInside];
        
        

        
    
        return cell;
        
    }
    
    
    if (indexPath.section == 1) {
    static NSString * cellid = @"mcq";
    Fabu3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[Fabu3TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.delagate =self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell prepareUI:_purchasedGoodsArray FenggeArray:_fengeArray];
    return cell;
    }
    else  if (indexPath.section == 2)
    {
        static NSString * cellid2 = @"mcm";
        liebiaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[liebiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         NSMutableArray * array = [NSMutableArray array];
        for (addMesModel * modle in _fengeArray) {
            if (!modle.goods_id) {
                [array addObject:modle];
            }
        }

        if (array.count > indexPath.row) {
           
            
            addMesModel * model = array[indexPath.row];
        
        
            cell.nameStr = model.goods_name;//@"xxxxxxxxx";
            cell.mashuStr = [NSString stringWithFormat:@"%@ %@",model.brand_name,model.model];//@"GAP";
        cell.deleBtn.tag = 800 + indexPath.row;
        [cell.deleBtn addTarget:self action:@selector(ACtionDeleBtn:) forControlEvents:UIControlEventTouchUpInside];
//        if (indexPath.row == _xuanzheIndedx) {
//            cell.bgView.backgroundColor = [UIColor lightGrayColor];
//        }
//        else
//        {
//            cell.bgView.backgroundColor = [UIColor whiteColor];
// 
//        }
        }
    
        return cell;
    
    }
    return  [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
//        _xuanzheIndedx = indexPath.row;
//        //一个section刷新
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    NSInteger tag = textField.tag;
    if (tag == 8880) {
        _spnameStr = textField.text;
    }
    if (tag == 8881) {
        _pipaiStr = textField.text;
    }
    if (tag == 8882) {
        _qitaStr = textField.text;
    }


}
-(void)ActionAddBtn{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:8880];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:8881];
    UITextField * text3 = (UITextField*)[self.view viewWithTag:8882];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];

    
    if (!_spnameStr||!_spnameStr.length) {
        return;
    }
    NSLog(@"%@",_spnameStr);
    NSLog(@"%@",_pipaiStr);
    NSLog(@"%@",_qitaStr);

    
    NSDictionary * dic =@{
                          @"goods_name":_spnameStr,
                          
                          @"brand_name":_pipaiStr?_pipaiStr:@"",
                          
                          @"model":_qitaStr?_qitaStr:@"",
                          
                          };

    
    addMesModel * modle = [addMesModel mj_objectWithKeyValues:dic];
    [_fengeArray addObject:modle];
    _spnameStr = @"";
    _pipaiStr = @"";
    _qitaStr = @"";

    [_tableView reloadData];
    [_tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
   // 这个是选择哪一行的cell，让该行的cell滑到tableView的最底端
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
   // 这个是指定哪一行的cell，让该行cell滑到tableView的最底端
    
    [self showAllTextDialog:@"添加成功"];
    
    
}

-(void)actionAdd
{
    fabu4ViewController * ctl = [[fabu4ViewController alloc]init];
    ctl.delegate = self;
    [self pushNewViewController:ctl];
}
-(void)selegoods:(NSInteger)index Issele:(BOOL)issele{
    
    
    
    addMesModel * model = _purchasedGoodsArray[index];
    
    goods_modle = model;
    if ([_fengeArray containsObject:goods_modle]) {
        [_fengeArray removeObject:goods_modle];
    }
    else
    {
        [_fengeArray addObject:goods_modle];
    }
    
    
}
-(void)backDic:(NSDictionary *)dic
{
    
    addMesModel * modle = [addMesModel mj_objectWithKeyValues:dic];
    [_fengeArray addObject:modle];
    [_tableView reloadData];
    
}
-(void)ACtionDeleBtn:(UIButton*)btn{
    
    NSMutableArray * array = [NSMutableArray array];
    for (addMesModel * modle in _fengeArray) {
        if (!modle.goods_id) {
            [array addObject:modle];
        }
    }
     NSInteger index = btn.tag - 800;
    addMesModel * modle2 = array[index];
    
    
//    
//    for (int i = 0; i < _fengeArray.count; i++) {
//        addMesModel * model = _fengeArray[i];
//        if (!model.goods_id) {
//            
//        }
//
//    }
    
    [_fengeArray removeObject:modle2];
   
    
   // [_fengeArray removeObjectAtIndex:index];
    [_tableView reloadData];
    
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
