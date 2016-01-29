//
//  tuijianViewController.m
//  SocialMall
//
//  Created by MC on 15/12/23.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "tuijianViewController.h"
#import "faxianCollectionViewCell.h"
@interface tuijianViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
   // JT3DScrollView *_scrollView;
    
    
    
    
    UICollectionView *_collectionView;


}

@end

@implementation tuijianViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
         self.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64 - 49);
   // self.view.backgroundColor = [UIColor yellowColor];
    [self prepareUI];
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
    
    [_collectionView registerClass:[faxianCollectionViewCell class] forCellWithReuseIdentifier:@"mc"];
    
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_collectionView];
  
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //collectionView有多少的section
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
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
    [cell prepareUI];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectFXXQObjNotification" object:@""];
}



/*
-(void)prepareUI{
    _scrollView = [[JT3DScrollView alloc]initWithFrame:CGRectMake(40, 64, Main_Screen_Width - 80, Main_Screen_Height - 64-1)];
    _scrollView.effect = JT3DScrollViewEffectDepth;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    for (int i = 0; i < 20; i ++) {
        [self createCardWithColor:i];
    }

}
- (void)createCardWithColor:(NSInteger)index
{
    CGFloat width = CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    
    CGFloat x = _scrollView.subviews.count * width;
    
    
    
    
    
//    // contr = [[zuopinDataViewController alloc] initFrame:CGRectMake(x, 0, width, height)];
//    zuopinDataView * zuoView = [[zuopinDataView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
//    ViewRadius(zuoView, 10);
//    homeYJModel * model = _dataArray[index];
//    zuoView.indexId = index;
//    zuoView.classifyDic = self.classifyDic;
//    zuoView.home_model = model;
//    zuoView.deleGate = self;
//    
//    [_viewArray addObject:zuoView];
//    if (index == _index ) {
//        if ( model.photos) {
//            
//            //  NSDictionary * dicimg = model.photos[0];
//            __weak typeof(UIImageView*)bg_imgView = _bgimgView;
//            UIImageView * imgViewmc = [[UIImageView alloc]init];
//            YJphotoModel * photoModel = model.YJphotos[0];
//            [imgViewmc sd_setImageWithURL:[NSURL URLWithString:photoModel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                [bg_imgView setImageToBlur:imgViewmc.image completionBlock:^{
//                    
//                }];
//                
//                
//            }];
//        }
//        else
//        {
//            // _bgimgView.image = [self blurryImage:[UIImage imageNamed:@"login_bg_720"]  withBlurLevel:44];
//            [_bgimgView setImageToBlur:[UIImage imageNamed:@"login_bg_720"] completionBlock:^{
//                
//            }];
//        }
//        [zuoView loadData:YES];
//    }
//    
//    // contr.view.backgroundColor = [UIColor yellowColor];//
//    [_scrollView addSubview:zuoView];
    _scrollView.contentSize = CGSizeMake(x + width, height);
}
*/

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
