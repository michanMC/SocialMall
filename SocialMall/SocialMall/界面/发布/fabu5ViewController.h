//
//  fabu5ViewController.h
//  SocialMall
//
//  Created by MC on 15/12/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "KeywordModel.h"
#import "goodsDataModel.h"
#import "addMesModel.h"

@interface fabu5ViewController : BaseViewController
@property(nonatomic,strong)NSMutableDictionary *dataDic;
@property(nonatomic,strong)KeywordModel * fengeModel;
@property(nonatomic,strong)goodsDataModel * goodsModel;
@property(nonatomic,strong)addMesModel * addmesModel;
@property (nonatomic,strong)NSMutableArray *addMesArray;
@end
