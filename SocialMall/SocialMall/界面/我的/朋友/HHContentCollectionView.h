//
//  HHContentCollectionView.h
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHContentCollectionView : UICollectionView
@property(nonatomic,copy) NSString * keyStr;//1:赞过 2：展示

+ (HHContentCollectionView *)contentCollectionViewKey:(NSString*)keystr;
-(void)loadData;

@end
