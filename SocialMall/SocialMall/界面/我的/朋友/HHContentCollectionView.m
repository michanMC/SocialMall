//
//  HHContentCollectionView.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import "HHContentCollectionView.h"
#import "HHCollectionViewCell.h"
@interface HHContentCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation HHContentCollectionView

static NSString *collectionViewCellIdentifier = @"collectionViewCell";

+ (HHContentCollectionView *)contentCollectionView {
    
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
    
    return collectionView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Main_Screen_Width, 10);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //item
    
    return CGSizeMake(Main_Screen_Width /2, (Main_Screen_Width) /2 + 100);
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
    [cell prepareUI];
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
