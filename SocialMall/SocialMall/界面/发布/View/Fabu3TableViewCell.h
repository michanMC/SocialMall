//
//  Fabu3TableViewCell.h
//  SocialMall
//
//  Created by MC on 15/12/26.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Fabu3ViewDelegate <NSObject>

-(void)actionAdd;
-(void)selegoods:(NSInteger)index Issele:(BOOL)issele;

@end

@interface Fabu3TableViewCell : UITableViewCell
-(void)prepareUI:(NSMutableArray*)photoArray FenggeArray:(NSMutableArray*)fenggeArray;
@property(weak,nonatomic)id<Fabu3ViewDelegate>delagate;

@end
