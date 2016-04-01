//
//  pinpaiViewController.m
//  SocialMall
//
//  Created by MC on 16/1/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "pinpaiViewController.h"
#import "ItemView.h"
#import "faxianCollectionViewCell.h"
#import "KeywordModel.h"
#import "faXianModel.h"

@interface pinpaiViewController ()<ItemViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    UIView*_headView;
    ItemView*_itemView;

    
    
    UIView *_bgView;
    
    UIButton * _renduBtn;
    UIButton * _timeBtn;
    
    
    NSMutableArray *_keywordArray;
    NSMutableArray *_dataarray;

    UICollectionView *_collectionView;
    
    NSInteger _page;
    NSInteger _sort;
    NSString *_seachStr;
    BOOL _isnoData;

}

@end

@implementation pinpaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    _sort = 0;
    _keywordArray = [NSMutableArray array];
    _dataarray = [NSMutableArray array];

        self.view.frame = CGRectMake(Main_Screen_Width * 1, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //输入框搜索
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectPPObj:) name:@"didSelectPPObjNotification" object:nil];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)didSelectPPObj:(NSNotification*)Notification{
    _headView.hidden = YES;
    _bgView.hidden = NO;
    [_dataarray removeAllObjects];
    _page = 0;
    [self searchsearch:YES Seachstr:Notification.object];
    
    
    
}

-(void)prepareUI{
    
    
    
    
    
    
    [self searchTagFG:YES];
    
//    [self nosearchView];
    [self hasSearchView];

}
-(void)hasSearchView{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width , Main_Screen_Height - 64 - 44)];
    _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _bgView.hidden = YES;
    [self.view addSubview:_bgView];
    
    _renduBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2 - 10 - 70, 10, 70, 30)];
    [_renduBtn setTitleColor:UIColorFromRGB(0x29477d) forState:UIControlStateNormal];
    [_renduBtn setTitleColor:UIColorFromRGB(0x29477d) forState:UIControlStateSelected];
    ViewRadius(_renduBtn, 5);
    [_renduBtn setTitle:@"热度" forState:0];
    _renduBtn.layer.borderColor = UIColorFromRGB(0x29477d).CGColor;
    
    _renduBtn.layer.borderWidth = .5;
    _renduBtn.titleLabel.font=  AppFont;
    [_renduBtn setImage:[UIImage imageNamed:@"热度_没选中"] forState:UIControlStateNormal];
    [_renduBtn setImage:[UIImage imageNamed:@"热度_选中"] forState:UIControlStateSelected];
    _renduBtn.selected = YES;

    _renduBtn.backgroundColor = RGBCOLOR(239, 245, 255);
    [_renduBtn addTarget:self action:@selector(rentimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_renduBtn];
    
    
    
    
    _timeBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2 + 10 , 10, 70, 30)];
    [_timeBtn setTitleColor:UIColorFromRGB(0x29477d) forState:UIControlStateNormal];
    [_timeBtn setTitleColor:UIColorFromRGB(0x29477d) forState:UIControlStateSelected];
    ViewRadius(_timeBtn, 5);
    [_timeBtn setTitle:@"时间" forState:0];
    [_timeBtn setImage:[UIImage imageNamed:@"travels_icon_time"] forState:UIControlStateNormal];
    [_timeBtn setImage:[UIImage imageNamed:@"时间_选中"] forState:UIControlStateSelected];
    _timeBtn.titleLabel.font=  AppFont;
    _timeBtn.backgroundColor = [UIColor whiteColor];//RGBCOLOR(239, 245, 255);
    [_bgView addSubview:_timeBtn];
    
    [_timeBtn addTarget:self action:@selector(rentimeBtn:) forControlEvents:UIControlEventTouchUpInside];

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat y = 0;
    CGFloat x = 0;
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, x, y, x);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20 + 30, Main_Screen_Width, _bgView.frame.size.height - 50) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[faxianCollectionViewCell class] forCellWithReuseIdentifier:@"mc"];
    
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_bgView addSubview:_collectionView];
    
    _collectionView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(actionheadRefresh)];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(actionFooer)];
    
    
    
    
    
    
    
}
-(void)actionheadRefresh{
    [_dataarray removeAllObjects];
    _page = 0;
    [self searchsearch:YES Seachstr:_seachStr];
    
    
}
-(void)actionFooer{
    _page ++;
    [self searchsearch:YES Seachstr:_seachStr];

    
    
    
}

#pragma mark-获取标签
-(void)searchTagFG:(BOOL)Refresh{
    
    NSDictionary * Parameterdic = @{
                                    @"searchType":@"brand"
                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"System/searchTag" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *  messageList = resultDic[@"data"][@"keyword"];
        for (NSDictionary * dic in messageList) {
            KeywordModel * model = [KeywordModel mj_objectWithKeyValues:dic];
            [_keywordArray addObject:model];
            
        }
        [self nosearchView];
        
        
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
    }];
    
    
    
    
    
    
    
    
}
#pragma mark-获取数据
-(void)searchsearch:(BOOL)Refresh Seachstr:(NSString*)seachstr{
    _seachStr = seachstr;
    NSDictionary * Parameterdic = @{
                                    @"searchType":@"brand",
                                    @"keyword":seachstr?seachstr:@"",
                                    @"page":@(_page),
                                    @"sort":@(_sort)

                                    };
    
    
    [self showLoading:Refresh AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"System/search" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *  messageList = resultDic[@"data"][@"returnList"];
        for (NSDictionary * dic in messageList) {
            faXianModel * model = [faXianModel mj_objectWithKeyValues:dic];
            [_dataarray addObject:model];
            
        }
        if (_dataarray.count==0 || !_dataarray) {
            _isnoData = YES;
        }
        else
        {
            _isnoData = NO;
            
        }

        
        
        
        [_collectionView reloadData ];
        
        
        
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];

        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
        _isnoData = YES;
        [_collectionView reloadData ];
        
    }];
    
    
}

-(void)nosearchView{
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 20)];
    lbl.text = @"推荐";
    lbl.textColor = [UIColor darkGrayColor];
    lbl.font = AppFont;
    [_headView addSubview:lbl];
    
    
    _itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width , 100) Skeystr:@"1"];
    _itemView.delegate = self;
    _itemView.seleColor = [UIColor whiteColor];
    _itemView.itemHeith = 25;
    NSMutableArray * arr = [NSMutableArray array];
    for (KeywordModel * model in _keywordArray) {
        [arr addObject:model.tag];
        
    }

    _itemView.itemArray =arr;// @[@"的萨芬",@"撒旦飞洒地方",@"阿斯顿",@"撒地方",@"阿斯顿发送到",@"阿斯蒂芬斯蒂芬",@"撒地方",@"撒地方都是"];
    
    [_headView addSubview:_itemView];
    _itemView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
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
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //collectionView有多少的section
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_isnoData) {
        return 1;
    }
    else

    return _dataarray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isnoData) {
        return CGSizeMake(Main_Screen_Width, Main_Screen_Height - 64 - 44 - 44);
    }
    else

    //item
    return CGSizeMake((Main_Screen_Width-10)/3, (Main_Screen_Width-10)/3);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (_isnoData) {
        
        faxianCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mc" forIndexPath:indexPath];
        if (!cell)
        {
            cell = [[faxianCollectionViewCell alloc]init];
            
        }
        
        [cell prepareUI2];
        
        
        return cell;
        
        
    }
    else{

    faxianCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mc" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[faxianCollectionViewCell alloc]init];
        
    }
    //cell.contentView.backgroundColor = [UIColor blackColor];
    if (_dataarray.count > indexPath.row) {
        faXianModel * model = _dataarray[indexPath.row];
        [cell prepareUI:model];
        
    }
    return cell;
    }
    return [[UICollectionViewCell alloc]init];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isnoData) {
        
        return;
        
    }

    if (_dataarray.count > indexPath.row) {
        faXianModel * model = _dataarray[indexPath.row];
        
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectFsearchXXQObjNotification" object:model];
        
        
    }

    

}


#pragma mark-_itemView代理
-(void)itemH:(CGFloat)itemh
{
    _itemView.frame = CGRectMake(CGRectGetMinX(_itemView.frame), CGRectGetMinY(_itemView.frame), CGRectGetWidth(_itemView.frame), itemh + 10);
    _headView.frame = CGRectMake(CGRectGetMinX(_headView.frame), CGRectGetMinY(_headView.frame), CGRectGetWidth(_headView.frame), itemh + 10 + 30);
    
}
-(void)seleIndex:(NSInteger)index
{
    //_itemView.itemArray[index];
    NSString * ss = _itemView.itemArray[index];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectTextFieldObjNotification" object:ss];
    _headView.hidden = YES;
    _bgView.hidden = NO;

    [self searchsearch:YES Seachstr:ss];

}
-(void)rentimeBtn:(UIButton*)btn{
    btn.selected = YES;
    [self seleBtn:btn];
    [self seleBtn:btn];
    if (btn== _renduBtn) {
        _timeBtn.selected = NO;
        [self NormalBtn:_timeBtn];
        _sort = 0;
        
        [_dataarray removeAllObjects];
        _page = 0;
        [self searchsearch:NO Seachstr:_seachStr];

    }
    if (btn== _timeBtn  ) {
        _renduBtn.selected = NO;
        [self NormalBtn:_renduBtn];
        _sort = 1;
        [_dataarray removeAllObjects];
        _page = 0;
        [self searchsearch:NO Seachstr:_seachStr];

        
    }
    
    
    
    
}
-(void)seleBtn:(UIButton*)btn{
    
    btn.layer.borderColor = UIColorFromRGB(0x29477d).CGColor;
    btn.layer.borderWidth = .5;
    
    btn.backgroundColor = RGBCOLOR(239, 245, 255);
    
}
-(void)NormalBtn:(UIButton*)btn{
    
    btn.layer.borderColor = [UIColor whiteColor].CGColor;//UIColorFromRGB(0x29477d).CGColor;
    btn.layer.borderWidth = 0;
    
    btn.backgroundColor = [UIColor whiteColor];//RGBCOLOR(239, 245, 255);
    
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
