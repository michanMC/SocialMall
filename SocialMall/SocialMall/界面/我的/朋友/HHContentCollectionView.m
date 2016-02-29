//
//  HHContentCollectionView.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import "HHContentCollectionView.h"
#import "HHCollectionViewCell.h"
#import "faXianModel.h"
#import "XQViewController.h"
@interface HHContentCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    
    
}

@end

@implementation HHContentCollectionView

static NSString *collectionViewCellIdentifier = @"collectionViewCell";

+ (HHContentCollectionView *)contentCollectionViewKey:(NSString*)keystr{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
//    layout.minimumInteritemSpacing = 0;
//    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    //layout.itemSize = CGSizeMake(100, 100);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    HHContentCollectionView *collectionView = [[HHContentCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = collectionView;
    collectionView.delegate = collectionView;
    
    [collectionView registerClass:[HHCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    collectionView.keyStr = keystr;
    collectionView.requestManager = [NetworkManager instanceManager];
    collectionView.requestManager.needSeesion = YES;
    collectionView.zanguoArray = [NSMutableArray array];
    collectionView.zhanshiArray = [NSMutableArray array];

    return collectionView;
}
-(void)loadData:(NSString*)user_id{
    if (!user_id) {
        return;
        
        
    }

    if ([_keyStr isEqualToString:@"1"]) {//赞过
        NSDictionary * Parameterdic = @{
                                        @"userId":user_id
                                        };
        
        NSString * urlstr;
            urlstr = @"Msg/messageLiked";
            
       // [self showLoading:Refresh AndText:nil];
        
        
        [self.requestManager requestWebWithGETParaWith:urlstr Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
            NSLog(@"成功");
            NSLog(@"返回==%@",resultDic);
            NSArray *messageList = resultDic[@"data"][@"messageList"];
            for (NSDictionary * dic in messageList) {
                faXianModel * model = [faXianModel mj_objectWithKeyValues:dic];
                for (NSDictionary * dic1 in dic[@"like_list"]) {
                    [model addlike_listDic:dic1];
                    
                }

                [_zanguoArray addObject:model];
                
            }
            [self reloadData];

//
//            
//            
//            [_tableView reloadData];
        } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
//            [self hideHud];
//            [self showAllTextDialog:description];
//            
            NSLog(@"失败");
            
        }];
     }
    else
    {
       // self.backgroundColor = [UIColor yellowColor];
        NSDictionary * Parameterdic = @{
                                        @"userId":user_id
                                        };
        
        NSString * urlstr;
        urlstr = @"Msg/showMessage";
        
        // [self showLoading:Refresh AndText:nil];
        
        
        [self.requestManager requestWebWithGETParaWith:urlstr Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
            NSLog(@"成功");
            NSLog(@"返回1==%@",resultDic);
            NSArray *messageList = resultDic[@"data"][@"messageList"];
                        for (NSDictionary * dic in messageList) {
                            zhanshiModel * model = [zhanshiModel mj_objectWithKeyValues:dic];
                            [_zhanshiArray addObject:model];
                        }
            //
            //
            //
            //            [_tableView reloadData];
        } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
            //            [self hideHud];
            //            [self showAllTextDialog:description];
            //            
            NSLog(@"失败");
            
        }];

    }
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Main_Screen_Width, 10);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_keyStr isEqualToString:@"1"]) {
        
        return _zanguoArray.count;
    }
    else
    {
        return _zhanshiArray.count;
            }
    return 20;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //item
    
    return CGSizeMake(Main_Screen_Width /3, (Main_Screen_Width) /3 + 90);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[HHCollectionViewCell alloc]init];
        
    }
    if ([_keyStr isEqualToString:@"1"]) {
        if (_zanguoArray.count > indexPath.row) {
            zhanshiModel * model = _zanguoArray[indexPath.row];
            [cell prepareUI:model];

        }
    }
    if ([_keyStr isEqualToString:@"2"]) {
        if (_zhanshiArray.count > indexPath.row) {
            zhanshiModel * model = _zhanshiArray[indexPath.row];
            [cell prepareUI:model];
            
        }
    }

    return cell;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    zhanshiModel * model ;
    
    if ([_keyStr isEqualToString:@"1"]) {
        if (_zanguoArray.count > indexPath.row) {
           model = _zanguoArray[indexPath.row];
            
        }
    }
    if ([_keyStr isEqualToString:@"2"]) {
        if (_zhanshiArray.count > indexPath.row) {
             model = _zhanshiArray[indexPath.row];
            
        }
    }
    NSDictionary * dic = [model mj_JSONObject];
    faXianModel * model1 = [faXianModel mj_objectWithKeyValues:dic];
    
    
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectXQObjNotification2" object:model1];
    
    
    
    
}

@end
