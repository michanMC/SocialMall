


//
//  ItemView.m
//  oc
//
//  Created by lyl on 15/11/24.
//  Copyright © 2015年 miruo. All rights reserved.
//

#import "ItemView.h"

@interface ItemView()

@property (nonatomic,assign) CGFloat viewHeight;/**< item的高度 >*/


@end





@implementation ItemView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    if (!_itemHeith) {
        _itemHeith = 30;
    }
    if (_itemArray.count > 0) {
        UIView *befourView = nil;
        for (NSInteger i = 0; i < _itemArray.count; i ++) {
            UIButton *itemLabel = [[UIButton alloc] init];
           // itemLabel.textAlignment = NSTextAlignmentCenter;
            [itemLabel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [itemLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            itemLabel.backgroundColor = [UIColor whiteColor];
            ViewRadius(itemLabel, 25/2);
           // itemLabel.textColor = [UIColor grayColor];
            //itemLabel.backgroundColor = [UIColor whiteColor];
            itemLabel.titleLabel.font = [UIFont systemFontOfSize:14];
            [itemLabel setTitle:_itemArray[i] forState:0];
            //itemLabel.text = _itemArray[i];
            itemLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
            itemLabel.layer.borderWidth =0.5;
            itemLabel.tag = i + 700;
            [itemLabel addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:itemLabel];
            CGFloat itemWidth = [itemLabel.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
            if (befourView) {
                CGFloat maxWidht = CGRectGetMaxX(befourView.frame);
                if ((maxWidht + itemWidth * 1.2 + 15 + 10) > viewWidth) {/**< 该换行了 >*/
                    itemLabel.frame = CGRectMake(10, CGRectGetMaxY(befourView.frame) + 10, itemWidth * 1.2, _itemHeith);
                }else {
                    itemLabel.frame = CGRectMake(CGRectGetMaxX(befourView.frame) + 15, CGRectGetMinY(befourView.frame), itemWidth * 1.2, _itemHeith);
                }
            }else {
                itemLabel.frame = CGRectMake(10, 10, itemWidth * 1.2, _itemHeith);
            }
            befourView = itemLabel;
        }
        
        self.viewHeight = CGRectGetMaxY(befourView.frame) + 10;
    }
}
//- (CGFloat)getItemViewHeight {
//    return _viewHeight;
//}


//- (void)setItemArray:(NSArray *)itemArray {
//    if (_itemArray != itemArray) {
//        _itemArray = itemArray;
//        for (NSInteger i = 0; i < _itemArray.count; i ++) {
//            
//            
//        }
//    }
//}

-(void)actionBtn:(UIButton*)btn{
    for (int i = 0; i < _itemArray.count; i ++) {
        UIButton * btn2 = (UIButton*)[self viewWithTag:700 + i];
        btn2.selected = NO;
        btn2.backgroundColor = [UIColor whiteColor];
    }
    btn.selected = YES;
    btn.backgroundColor = AppCOLOR;
    NSLog(@"%d",btn.tag - 700);
}

- (void)ItemViewWithBlock:(ItemViewBlock)block {
    self.block = block;
}

- (void)setViewHeight:(CGFloat)viewHeight {
    if (_viewHeight != viewHeight) {
        _viewHeight = viewHeight;
        
        [_delegate itemH:_viewHeight];
        
//        if (self.block) {
//            self.block([NSNumber numberWithFloat:_viewHeight]);
//        }
    }
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
