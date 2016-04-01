//
//  faxianCollectionViewCell.h
//  SocialMall
//
//  Created by MC on 16/1/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "faXianModel.h"
@interface faxianCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView * imgView;
-(void)prepareUI:(faXianModel*)model;
-(void)prepareUI2;

@end
