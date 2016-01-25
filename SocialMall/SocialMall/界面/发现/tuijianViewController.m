//
//  tuijianViewController.m
//  SocialMall
//
//  Created by MC on 15/12/23.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "tuijianViewController.h"

@interface tuijianViewController ()
{
    JT3DScrollView *_scrollView;

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
         self.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64);
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
}
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
