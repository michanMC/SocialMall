//
//  MCXQViewController.m
//  SocialMall
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCXQViewController.h"
#import "MatchListModel.h"
#import "CommentModel.h"
#import "QX1TableViewCell.h"
#import "QX2TableViewCell.h"
#import "QX3TableViewCell.h"
#import "QX4TableViewCell.h"
#import "QX5TableViewCell.h"
#import "zuopinDataView1.h"

@interface MCXQViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    faXianModel * _XQModel;
    NSMutableArray * _MatchListArray;
    NSMutableArray * _CommentArray;

    NSInteger pagenum;

    
    
}

@end

@implementation MCXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    pagenum = 0;
    _CommentArray = [NSMutableArray array];
    _MatchListArray = [NSMutableArray array];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self load_Data:YES];
    
    // Do any additional setup after loading the view.
}
#pragma mark-获取数据
-(void)load_Data:(BOOL)Refresh{
    if (!_faxianModel.id && !_faxianModel.msg_id) {
        [self showAllTextDialog:@"无效ID"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ?  _faxianModel.id :_faxianModel.msg_id
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    [self.requestManager requestWebWithGETParaWith:@"Msg/showMessageDetail" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        // [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSDictionary * messageList = resultDic[@"data"][@"messageList"];
        _XQModel =  [faXianModel mj_objectWithKeyValues:messageList];
        for (NSDictionary * dic in messageList[@"like_list"]) {
            [_XQModel addlike_listDic:dic];
            
        }
        [self showMessageComment:NO];
        
        
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
    }];
    
}
#pragma mark-检查是否关注
-(void)checkFans:(BOOL)Refresh{
    if (!_faxianModel.user_id &&!_faxianModel.msg_id) {
        if (!_XQModel.user_id){
            [self isLiked:NO];
            return;
            
        }
        else
        {
            _faxianModel.user_id = _XQModel.user_id;
        }
    }
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * userid = [defaults objectForKey:@"userId"];
    NSDictionary * Parameterdic = @{
                                    @"toId":_faxianModel.user_id ?_faxianModel.user_id: _faxianModel.msg_id,
                                    @"fromId":userid?userid:@""
                                    
                                    };
    //    toId = "45",
    //    fromId = "4",
    //    toId = "36",
    //    fromId = "4",
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/checkFans" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        //[self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSDictionary * messageList = resultDic[@"data"];
        _XQModel.isFans = [messageList[@"isFans"] boolValue];
        [self isLiked:NO];
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
         [self showAllTextDialog:description];
//        [_firstViewTableView reloadData];
//        [_secondViewTableView reloadData];
//        
        NSLog(@"失败");
        
    }];
    
}

#pragma mark-获取赞
-(void)isLiked:(BOOL)Refresh{
    
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ?  _faxianModel.id :_faxianModel.msg_id
                                    };
    
    
  //  [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/isLiked" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
         [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        if ([resultDic[@"data"][@"isLiked"]boolValue]) {
            
            _XQModel.islike = YES;
        }
        else
        {
            _XQModel.islike = NO;
            
        }
        
        [_tableView reloadData];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
//        [_firstViewTableView reloadData];
//        [_secondViewTableView reloadData];
        
        NSLog(@"失败");
        
    }];
    
}
#pragma mark- 获取搭配列表
-(void)matchList:(BOOL)Refresh{
    
    if (!_faxianModel.id &&!_faxianModel.msg_id) {
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ? _faxianModel.id :_faxianModel.msg_id,
                                    };
    
    
   // [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/matchList" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        //[self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray * array = resultDic[@"data"][@"matchList"];
        if (array.count&&_MatchListArray.count==0) {
            
            for (NSDictionary * dic in array) {
                MatchListModel * model = [MatchListModel mj_objectWithKeyValues:dic];
                [_MatchListArray addObject:model];
            }
        }
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        if ([defaults objectForKey:@"sessionId"]) {
            [self checkFans:NO];//判断是否关注
        }
        else
        {
           // [self hideHud];
            //            [_firstViewTableView reloadData];
            //            [_secondViewTableView reloadData];
            
             [self isLiked:NO];
        }

        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
        
        
    }];
    
    
}
#pragma mark-获取评论
-(void)showMessageComment:(BOOL)Refresh{
    
    if (!_faxianModel.id &&!_faxianModel.msg_id) {
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_faxianModel.id ? _faxianModel.id :_faxianModel.msg_id,
                                    @"page":@(pagenum)
                                    };
    
    
   // [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/showMessageComment" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        //[self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray * array = resultDic[@"data"][@"commentData"];
        if (array.count) {
            [_CommentArray removeAllObjects];
            for (NSDictionary * dic in array) {
                CommentModel * model = [CommentModel mj_objectWithKeyValues:dic];
                [_CommentArray addObject:model];
            }
            
        }
        [self matchList:NO];
//        [_secondViewTableView reloadData];
//        [_secondViewTableView.mj_footer endRefreshing];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
//        [_secondViewTableView.mj_footer endRefreshing];
        
        
    }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    if (indexPath.row == 0) {
        
        return 64;
    }
        if (indexPath.row == 1) {
            
            CGFloat hh;
            __block typeof (CGFloat)hhh = hh;
            
            if (!CGSizeEqualToSize(_XQModel.imageSize, CGSizeZero)) {
                hhh = Main_Screen_Width * _XQModel.imageSize.height / _XQModel.imageSize.width;
                
                
                return hhh;
            }
            
            return Main_Screen_Width;

        }
        if (indexPath.row == 2) {
            //   NSString *titleStr = @"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
            NSString *titleStr = _XQModel.content;
            
            CGFloat h = [MCIucencyView heightForString:titleStr fontSize:14 andWidth:Main_Screen_Width - 20] + 20;
            
            return h;
        }
        if (indexPath.row == 3) {
            return 50;
        }
        if (indexPath.row == 4) {
            return 44;

        }
         return 50;
   
}
    
    
    
    
    
    
    
    
    
    
    
    
    
     return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid1 = @"zuopinDataView1";
    static NSString *cellid2 = @"QX1TableViewCell";
    static NSString *cellid3 = @"QX2TableViewCell";
    static NSString *cellid4 = @"QX3TableViewCell";
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            zuopinDataView1 * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid1 owner:self options:nil]lastObject];
            }
            cell.headImgBtn.tag = 90000;
            [cell.headImgBtn addTarget:self action:@selector(actionHeadbtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.headImgBtn sd_setImageWithURL:[NSURL URLWithString:_XQModel.headimgurl] forState:0 placeholderImage:[UIImage imageNamed:@"Avatar_76"]];
            ViewRadius(cell.headImgBtn, 40/2);
            
            //[cell.headImgBtn sd_setImageWithURL:<#(NSURL *)#> forState:<#(UIControlState)#> placeholderImage:<#(UIImage *)#>]
            cell.nameLbl.text = _XQModel.nickname;
            cell.timeLbl.text =  [CommonUtil daysAgoAgainst:[_XQModel.add_time longLongValue]];//[CommonUtil getStringWithLong:model.createDate Format:@"MM-dd"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.guanzhuBtn addTarget:self action:@selector(ACtionGuanzhu) forControlEvents:UIControlEventTouchUpInside];
            
            if (_XQModel.isFans) {
                [cell.guanzhuBtn setTitle:@"已关注" forState:0];
                cell.guanzhuBtn.backgroundColor = [UIColor whiteColor];
                [cell.guanzhuBtn setTitleColor:UIColorFromRGB(0x29477d) forState:0 ];
                
                
            }
            
            else
            {
                [cell.guanzhuBtn setTitle:@"关注" forState:0];
                cell.guanzhuBtn.backgroundColor = AppCOLOR;
                [cell.guanzhuBtn setTitleColor:[UIColor whiteColor] forState:0 ];
            }
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            NSString * userid = [defaults objectForKey:@"userId"];
            if ([_XQModel.user_id isEqualToString:userid]) {
                cell.guanzhuBtn.hidden = YES;
            }
            else
            {
                cell.guanzhuBtn.hidden = NO;
                
            }
            
            return cell;
            
        }
        if (indexPath.row == 1) {
            QX1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid2 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *imgUrlString = _XQModel.image;

            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:[UIImage imageNamed:@"home_default-photo"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    if (!CGSizeEqualToSize(_XQModel.imageSize, image.size)) {
                        
                        _XQModel.imageSize = image.size;
                        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                        
                        //[_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }];
            
            
            cell.contentView.backgroundColor = [UIColor yellowColor];

            return cell;
        }
        
        if (indexPath.row == 2) {
            QX2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
            if (!cell) {
                cell = [[QX2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleStr = _XQModel.content;//@"iPhone7将会是苹果今年重磅推出的一款新机，而最近有关苹果iPhone7的各种曝光消息层出不穷，但是大多都是网友臆想出来或者是概念设计。而最新一款iPhone7概念设计曝光，也让大家再次惊艳到了。";
            return cell;
        }
        if (indexPath.row == 3) {
            QX3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid4];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid4 owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString * str = [NSString stringWithFormat:@"喜欢%@",_XQModel.like?_XQModel.like:@""];
            cell.xihuanBTn.layer.borderWidth = 1;
            cell.xihuanBTn.layer.borderColor = UIColorFromRGB(0x29477d).CGColor;
            [cell.xihuanBTn setTitleColor:UIColorFromRGB(0x29477d) forState:0];
            [cell.xihuanBTn setTitle:str forState:0];
            ViewRadius(cell.xihuanBTn, 5);
            if (_XQModel.islike) {
                cell.xihuanBTn.tintColor = AppCOLOR;
                
                [cell.xihuanBTn setImage:[UIImage imageNamed:@"favorite_icon_pressed"] forState:0];
            }
            else
            {
                cell.xihuanBTn.tintColor = [UIColor lightGrayColor];
                
                [cell.xihuanBTn setImage:[UIImage imageNamed:@"favorite_icon_normal"] forState:0];
                
            }
            
            cell.bgView.tag = 600;
            
            
            
            [cell.xihuanBTn addTarget:self action:@selector(ActionDianzan) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }

        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    return [[UITableViewCell alloc]init];
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
