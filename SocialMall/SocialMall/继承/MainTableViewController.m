//
//  MainTableViewController.m
//  Hair
//
//  Created by michan on 15/5/26.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import "MainTableViewController.h"
#import "GuanzhuViewController.h"
//#import "XZMTabbarExtension.h"
#import "FabuViewController.h"
#import "FaxianViewController.h"
#import "MallViewController.h"
#import "MeViewController.h"
#import "MCNavViewController.h"
@interface MainTableViewController ()<MAMapViewDelegate, AMapSearchDelegate>{
    
    BOOL _isdingwei;
    
    
}

@end

@implementation MainTableViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.mapView.delegate = self;
    _mapView.showsUserLocation = YES; //YES 为打开定位，NO为关闭定位
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    
    [self.view addSubview:self.mapView];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization];
    }
}
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation&&!_isdingwei)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude     longitude:userLocation.coordinate.longitude];
        regeo.radius = 10000;
        regeo.requireExtension = YES;
        
        //发起逆地理编码
        [_search AMapReGoecodeSearch: regeo];
        
        
    }
}
//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil&&!_isdingwei)
    {
        _isdingwei = YES;
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *result = [NSString stringWithFormat:@"%@", response.regeocode.addressComponent.city];
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:result forKey:@"city"];
    
        //强制让数据立刻保存
        [defaults synchronize];

        NSLog(@"ReGeo: %@", result);
    }
}
/* 初始化search. */
- (void)initSearch
{
    [AMapSearchServices sharedServices].apiKey = @"ca10d0212114f9e87e5032a64284d9dd";
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
}
#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMapView];
    
    [self initSearch];

    [self setupViews];

    // Do any additional setup after loading the view.
}
- (void)setupViews
{
   
    
    
    MCUser * mc = [MCUser sharedInstance];
    mc.tabIndex = 0;

    GuanzhuViewController *loan = [[GuanzhuViewController alloc]init];
    [self setUpChildController:loan title:@"关注" imageName:@"focus_normal" selectedImageName:@"focus_pressed" Tag:90000];
    
    ////    _contasctsVC = [[ContactsViewController alloc]init];
    //
    FaxianViewController *chatList= [[FaxianViewController alloc] init];
    //    [_chatListVC networkChanged:_connectionState];
    [self setUpChildController:chatList title:@"发现" imageName:@"detection_normal" selectedImageName:@"detection_pressed" Tag:90001];

    
    
    FabuViewController *catact = [[FabuViewController alloc]init];
    [self setUpChildController:catact title:nil imageName:@"add" selectedImageName:@"add" Tag:90002];
    
    
    
    
    MallViewController *mall = [[MallViewController alloc]init];
    [self setUpChildController:mall title:@"商城" imageName:@"mine_normal" selectedImageName:@"mine_pressed" Tag:90003];

    MeViewController *me = [[MeViewController alloc]init];
    
    [self setUpChildController:me title:@"我" imageName:@"mall_normal" selectedImageName:@"mall_pressed" Tag:90004];
    //
     self.selectedIndex = 1;
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 90002) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectFBNotification" object:@""];
        
        
        
        
        
    }
    else
    {
        if (item.tag == 90004) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            
            
            if ([defaults objectForKey:@"sessionId"]) {
                // [self prepareUI2];
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectloadData2Notification" object:@""];
                MCUser * mc = [MCUser sharedInstance];
                mc.tabIndex = item.tag -90000;

            }else
            {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectDLNotification" object:@""];
                
                return;
                
            }
            
        }
        else if(item.tag == 90000){
            
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didRefreshDataObjNotification" object:@""];
        }
      else  if (item.tag == 90003) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            
            
            if ([defaults objectForKey:@"sessionId"]) {
                // [self prepareUI2];
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectloadData2Notification" object:@""];
                MCUser * mc = [MCUser sharedInstance];
                mc.tabIndex = item.tag -90000;
                
            }else
            {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectDLNotificationMall" object:@""];
                
                return;
                
            }
            
        }

        
        MCUser * mc = [MCUser sharedInstance];
        mc.tabIndex = item.tag -90000;
    }
}
- (void)setUpChildController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)image selectedImageName:(NSString *)selectedImage Tag:(NSInteger)tag
{
    controller.title = title;
    // 底部字体颜色
    self.tabBar.tintColor = AppCOLOR;//RGBCOLOR(254, 96, 149);
    //默认的图片
    [controller.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

   // if (title)
    //选择时的图片,将其渲染方式设置为原始的颜色
    [controller.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
   /// controller.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    if (title == nil) {
        controller.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0,-6, 0);
        controller.tabBarItem.tag = 90002;

    }
    else
    {
        controller.tabBarItem.tag = tag;
 
    }
    MCNavViewController *nav = [[MCNavViewController alloc]initWithRootViewController:controller];
   
    [self addChildViewController:nav];
    
    
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
