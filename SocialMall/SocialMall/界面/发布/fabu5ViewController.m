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
    UIImageView * imgView;
    
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
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
    imgView.image = _dataDic[@"img"];
    UIImage *img =_dataDic[@"img"];
    
    
    if (img) {
        CGFloat w = img.size.width;
        CGFloat h = img.size.height;
        
        CGFloat  hhh = Main_Screen_Width * h / w;
        
        view.frame =CGRectMake(0, 0, Main_Screen_Width, hhh);
        imgView .frame= CGRectMake(0, 0, Main_Screen_Width, hhh);
        
    }
    

    [view addSubview:imgView];
//    imgView.contentMode = UIViewContentModeScaleAspectFill;
//    imgView.clipsToBounds = YES; // 裁剪边缘
    
    return view;
    
}
-(void)rightBarButtonFabu{
    NSMutableArray * addarray = [NSMutableArray array];
    if (!_fengeModel) {
        [self showAllTextDialog:@"请选择风格"];return;
    }
    if (!_addMesArray.count && !_goodsArray.count) {
        //[self showAllTextDialog:@"请添加商品"];return;
    }
    else
    {
        for (addMesModel * model in _addMesArray) {
            NSDictionary * dic = [model mj_JSONObject];
            [addarray addObject:dic];
        }
//        for (addMesModel * model in _goodsArray) {
//            NSDictionary * dic = [model mj_JSONObject];
//            [addarray addObject:dic];
//        }

    }

    NSLog(@">>>%@",_fengeModel.id);
    UIImage *img =imgView.image;

    NSData *imageData = UIImageJPEGRepresentation(img, 1);
  //  NSData *imageData = UIImagePNGRepresentation(_dataDic[@"img"]);// png

    
    NSString *base64Image=[imageData base64Encoding];
    NSString *base64ImageStr = [NSString stringWithFormat: @"data:image/jpg;base64,%@",base64Image];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:addarray
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];;
    
    NSString * data2 =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary * Parameterdic = @{
                                    @"image":base64ImageStr,
                                    @"content":_dataDic[@"title"],
                                    @"style_id":@([_fengeModel.id integerValue]),
                                    @"matchJson":data2
                                    
                                    };
    

    [self showLoading:YES AndText:nil];
    
    
    [self.requestManager requestWebWithParaWithURL:@"Msg/addMessage" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"发布成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MCUser * mc = [MCUser sharedInstance];
            self.navigationController.tabBarController.selectedIndex = 1;//mc.tabIndex;
            
        });

        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
    }];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 1;
    return _addMesArray.count + 2;
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
        
        if (indexPath.row == _addMesArray.count + 1) {
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
            
            cell.title2Str = _fengeModel.name;
            return cell;
         }
        
        
        
        if (indexPath.row == _addMesArray.count+1) {
            fabu6TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"fabu6TableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"fabu6TableViewCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell.btn addTarget:self action:@selector(ActionBtn) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
        if (indexPath.row != 0 || indexPath.row != _addMesArray.count+1) {
            static NSString * cellid2 = @"mcm";
            liebiaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[liebiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            }
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
            if (_addMesArray.count > indexPath.row - 1) {
                addMesModel * model = _addMesArray[indexPath.row - 1];
            
                cell.nameStr = model.goods_name;//@"xxxxxxxxx";
                cell.mashuStr = [NSString stringWithFormat:@"%@ %@",model.brand_name?model.brand_name:@"",model.model?model.model:@""];//@"GAP";
            cell.deleBtn.tag = 800 + indexPath.row-1;
            [cell.deleBtn addTarget:self action:@selector(ACtionDeleBtn:) forControlEvents:UIControlEventTouchUpInside];
//            if (indexPath.row == _xuanzheIndedx) {
//                cell.bgView.backgroundColor = [UIColor lightGrayColor];
//            }
//            else
//            {
//                cell.bgView.backgroundColor = [UIColor whiteColor];
//                
            }
            
            return cell;

        }
        
        
        
    }
    return [[UITableViewCell alloc]init];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section != 0) {
//        if (indexPath.row != 0 || indexPath.row != _addMesArray.count+1) {
//            
//
//        _xuanzheIndedx = indexPath.row;
//        //一个section刷新
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//        }
//    }
    
}
-(void)ACtionDeleBtn:(UIButton*)btn{
    
    NSInteger index = btn.tag - 800;
    [_addMesArray removeObjectAtIndex:index];
    [_tableView reloadData];
    [_deleGateView loadData];

    
}

-(void)ActionBtn{
    
    fabu4ViewController * ctl = [[fabu4ViewController alloc]init];
    ctl.delegate = self;
    [self pushNewViewController:ctl];

    
}
-(void)backDic:(NSDictionary *)dic
{
    addMesModel * modle = [addMesModel mj_objectWithKeyValues:dic];
    [_addMesArray addObject:modle];
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
