//
//  zuopinDataView.m
//  SocialMall
//
//  Created by MC on 16/1/6.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "zuopinDataView.h"
#import "zuopinDataView1.h"
#import "zuopinDataView5.h"

#import "zuopinDataView2Cell.h"
#import "zuopinDataView3Cell.h"
#import "zuopinDataView4Cell.h"
#import "jubao_View.h"
#import "TYAlertView.h"
#import "UIView+TYAlertView.h"
#import "CLAnimationView.h"

@interface zuopinDataView ()<UITableViewDataSource,UITableViewDelegate,zuopinDataView3CellDelegate>{
    CGRect _viewFrame;
    jubao_View *shareView;
    NSString * nickname;
    NSString * headimgurl;

}

@end


@implementation zuopinDataView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewFrame = frame;

        
    }
    
    return self;
}
-(void)prepareUI:(faXianModel*)model{
    _homeModel = model;
    nickname = @"";
    headimgurl = @"";
   self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _viewFrame.size.width, _viewFrame.size.height ) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.bounces = NO;
    _tableView.delegate= self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self addSubview:_tableView];
    
  
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 64;
    }
    if (indexPath.row == 1) {
        return _viewFrame.size.width + 30;
    }
    
    return 35;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid1 = @"zuopinDataView1";
    static NSString *cellid2 = @"zuopinDataView2Cell";
    static NSString *cellid3 = @"zuopinDataView3Cell";
    static NSString *cellid4 = @"zuopinDataView4Cell";
    static NSString *cellid5 = @"zuopinDataView5";

    if (indexPath.row == 0) {
        zuopinDataView5 * cell = [tableView dequeueReusableCellWithIdentifier:cellid5];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellid5 owner:self options:nil]lastObject];
        }
        cell.headBtn.tag = 90000;
        ViewRadius(cell.headBtn, 20);
        [cell.headBtn addTarget:self action:@selector(actionHeadbtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.headBtn sd_setImageWithURL:[NSURL URLWithString:_homeModel.headimgurl] forState:0 placeholderImage:[UIImage imageNamed:@"Avatar_76"]];
        cell.nameLbl.text = _homeModel.nickname;
        cell.timeLbl.text = [CommonUtil daysAgoAgainst:[_homeModel.add_time longLongValue]];
//        cell.guanzhuBtn.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 1) {
        zuopinDataView2Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellid2 owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_homeModel.image] placeholderImage:[UIImage imageNamed:@"home_default-photo"]];
        cell.titleLbl.text = _homeModel.content;
        cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imgView.clipsToBounds = YES; // 裁剪边缘

        
        return cell;
    }
    if (indexPath.row == 2) {
        zuopinDataView3Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
        if (!cell) {
            cell = [[zuopinDataView3Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            
        }
        
        [cell prepareUI:_homeModel];
        cell.deleGate =self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
  
    }
    if (indexPath.row == 3) {
        zuopinDataView4Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellid4];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellid4 owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.gengdouBtn addTarget:self action:@selector(actionpinglun:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jubaoBtn addTarget:self action:@selector(actionjubao) forControlEvents:UIControlEventTouchUpInside];
        [cell.zhuanfaBtn addTarget:self action:@selector(ActionAhuanfa) forControlEvents:UIControlEventTouchUpInside];
        cell.bgView.tag = 500;
        
        cell.pinlunLbl.text = _homeModel.comments;
        cell.zanLbl.text = [NSString stringWithFormat:@"%zd",_homeModel.like_listArray.count];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString * userid = [defaults objectForKey:@"userId"];
        BOOL iszan = NO;
        for (like_list * modellist in _homeModel.like_listArray) {
            if ([modellist.user_id isEqualToString:userid]) {
                iszan = YES;
            }
        }
        if (iszan) {
            [cell.zanBtn setImage:[UIImage imageNamed:@"喜欢_选中"] forState:UIControlStateNormal];
            _homeModel.islike = YES;

            
        }
        else
        {
            [cell.zanBtn setImage:[UIImage imageNamed:@"favorite_icon_normal"] forState:UIControlStateNormal];
            _homeModel.islike = NO;

        }
        
        [cell.zanBtn addTarget:self action:@selector(ActionDianzan) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }

    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 || indexPath.row == 2)
        if (_homeModel) {
            zuopinDataView * view = self;
            view.tag = 88888;
            NSDictionary * dic =@{
                                 @"view":view,
                                 @"homeModel":_homeModel
                                 };
            
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectXQObjNotification" object:dic];
        }
    
}
#pragma mark-点赞
-(void)actiondianzanBtn{
    
    
    
    
    
    
    
    
}
#pragma mark-点赞请求
-(void)ActionDianzan{
    if (!_homeModel.id &&!_homeModel.msg_id) {
        return;
    }
//    if (!self.isgion) {
//        [self showAllTextDialog:@"没登录"];
//        return;
//    }
    
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_homeModel.id ? _homeModel.id : _homeModel.msg_id
                                    };
    

    [_delegate showLoading:YES AndText:nil];
    
    [_delegate.requestManager requestWebWithParaWithURL:@"Msg/messageLike" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [_delegate hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        //[self showAllTextDialog:@"点赞成功"];
        if (_homeModel.islike) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            NSString * userid = [defaults objectForKey:@"userId"];
            
            for (like_list * modellist in _homeModel.like_listArray) {
                if ([modellist.user_id isEqualToString:userid]) {
                    nickname = modellist.nickname;
                    headimgurl = modellist.headimgurl;

                    [_homeModel.like_listArray removeObject:modellist];
                }
            }

            
        }
        else{
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            NSString * userid = [defaults objectForKey:@"userId"];
            
            if (!nickname.length) {
                nickname = [defaults objectForKey:@"nickname"];
            }
            if (!headimgurl.length) {
                headimgurl = [defaults objectForKey:@"headimgurl"];
            }
            NSDictionary *dic = @{
                                  @"user_id":userid,
                                  @"nickname":nickname,
                                  @"headimgurl":headimgurl
                                  };
            
            like_list * modellist2 = [like_list mj_objectWithKeyValues:dic];
            
            
            [_homeModel.like_listArray addObject:modellist2];
//            for (like_list * modellist in _homeModel.like_listArray) {
//                if ([modellist.user_id isEqualToString:userid]) {
//                    [_homeModel.like_listArray removeObject:modellist];
//                }
//            }

            
        }
        
        
        [_tableView reloadData];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [_delegate hideHud];
        [_delegate showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
}

#pragma mark-举报
-(void)actionjubao{
    UIView * view = (UIView *)[self viewWithTag:500];
        view.hidden = YES;
    

     shareView= [jubao_View createViewFromNib];
    shareView.tag = 1200;
    ViewRadius(shareView.bgView2, 40);
    
    [shareView.btn addTarget:self action:@selector(actionjubaoBtn) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary * Parameterdic = @{
                                    @"msg_id":_homeModel.msg_id
                                    };
    
    
    [_delegate showLoading:YES AndText:nil];
    
    
    [_delegate.requestManager requestWebWithGETParaWith:@"Msg/reportMessage" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [_delegate hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        [shareView showInWindow];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [_delegate hideHud];
        [_delegate showAllTextDialog:description];
        
        NSLog(@"失败");
        
    }];

    

}
-(void)actionjubaoBtn{
    
    [shareView hideView];
    

}
#pragma mark-转发
-(void)ActionAhuanfa{
    UIView * view = (UIView *)[self viewWithTag:500];
    view.hidden = YES;
    CLAnimationView *animationView = [[CLAnimationView alloc]initWithTitleArray:@[@"朋友圈",@"微信好友"] picarray:@[@"share_friends",@"share_wechat"]];
    __weak BaseViewController *weakSelf = _delegate;

    [animationView selectedWithIndex:^(NSInteger index) {
        NSLog(@"你选择的index ＝＝ %ld",(long)index);
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
      //  NSString * url = [NSString stringWithFormat:@"111"];
         NSString * url = [NSString stringWithFormat:@"%@Msg/html5?id=%@",AppURL,_homeModel.id ? _homeModel.id : _homeModel.msg_id];
        
        
        [dic setObject:url forKey:@"url"];
        [dic setObject:_homeModel.content forKey:@"title"];
        [dic setObject:_homeModel.style_name forKey:@"titlesub"];
        
        
        if (index == 1) {
                [weakSelf actionFenxian:SSDKPlatformSubTypeWechatTimeline PopToRoot:NO SsDic:dic];
            
        }
        else
        {
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatSession PopToRoot:NO SsDic:dic];
        }
        
        
        
    }];
    [animationView CLBtnBlock:^(UIButton *btn) {
        NSLog(@"你点了选择/取消按钮");
    }];
    [animationView show];

}
#pragma mark-赞个人信息
-(void)actionZanBtn:(BOOL)isAll likelist:(like_list *)model
{
    
    
    if (isAll) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectgerenDataObjNotification" object:@"1"];
    }
    else
    {
        if (model) {
            
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectgerenDataObjNotification" object:model];
        }
    }
}
#pragma mark-个人信息
-(void)actionHeadbtn:(UIButton*)btn{
    
    if (btn.tag == 90000) {//作者
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectgerenDataObjNotification" object:_homeModel];
        
 
    }
    
}
#pragma mark-更多
-(void)actionpinglun:(UIButton*)btn{
    
    UIView * view = (UIView *)[self viewWithTag:500];
    if (view.hidden) {
        view.hidden = NO;
    }
    else
    {
         view.hidden = YES;
    }
        
                     
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
