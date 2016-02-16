//
//  zuixinViewController.m
//  SocialMall
//
//  Created by MC on 15/12/23.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuixinViewController.h"
#import "faxianCollectionViewCell.h"

@interface zuixinViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;
    NSInteger pageNum;

}

@end

@implementation zuixinViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _dataArray = [NSMutableArray array];

        pageNum = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(Main_Screen_Width * 2, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64 - 49);
    [self prepareUI];
    //self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat y = 0;
    CGFloat x = 0;
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, x, y, x);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.view.frame.size.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;

    [_collectionView registerClass:[faxianCollectionViewCell class] forCellWithReuseIdentifier:@"mc"];
    _collectionView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(actionheadRefresh)];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(actionFooer)];
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_collectionView];
    
    
}
-(void)actionheadRefresh{
    [_dataArray removeAllObjects];
    pageNum = 0;
    [self load_Data:NO];
    
    
}
-(void)actionFooer{
    [_dataArray removeAllObjects];

    pageNum ++;
    [self load_Data:NO];
    
    
    
}

-(void)load_Data:(BOOL)Refresh{
    NSDictionary * Parameterdic = @{
                                    @"page":@(0)
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"Msg/unfriendShowNewMessage" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *  messageList = resultDic[@"data"][@"messageList"];
        for (NSDictionary* dic in messageList) {
            
            faXianModel * model = [faXianModel mj_objectWithKeyValues:dic];
            [_dataArray addObject:model];
        }
        
        [_collectionView reloadData];
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];

    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];

        NSLog(@"失败");
        
    }];
    
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //collectionView有多少的section
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //item
    return CGSizeMake((Main_Screen_Width-10)/3, (Main_Screen_Width-10)/3);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    faxianCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mc" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[faxianCollectionViewCell alloc]init];
        
    }
    //cell.contentView.backgroundColor = [UIColor blackColor];
    if (_dataArray.count > indexPath.row) {
        [cell prepareUI:_dataArray[indexPath.row]];
        
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count > indexPath.row) {
        faXianModel * model = _dataArray[indexPath.row];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectFXXQObjNotification" object:model];
        
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
