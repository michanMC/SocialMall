//
//  zuopinDataView3Cell.m
//  SocialMall
//
//  Created by MC on 16/1/25.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "zuopinDataView3Cell.h"

@implementation zuopinDataView3Cell

- (void)awakeFromNib {
    // Initialization code
}
-(void)prepareUI{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSArray * arr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    CGFloat offX = 9;
    CGFloat x = offX;
    CGFloat width = ((Main_Screen_Width - 40)-9 * 9) / 8;
    NSInteger MaxCount = 8;

    if (_isQX) {
       width = ((Main_Screen_Width )-11 * 9) / 10;
        arr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
        MaxCount = 10;
        
    }
    CGFloat height = width;
    CGFloat y = (self.contentView.frame.size.height - width) / 2;
    if (arr.count > MaxCount) {//多的时候

        
        for (int i = 0; i < MaxCount; i ++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, height, width)];
            btn.tag = 300+ i;
            if (i == MaxCount - 1) {
                btn.tag = 400;
                if (_isQX) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"组-2"] forState:0];
                }
                else
                {
                btn.backgroundColor = [UIColor lightGrayColor];
                
                [btn setTitle:[NSString stringWithFormat:@"%ld",arr.count] forState:0];
                [btn setTitleColor:[UIColor whiteColor] forState:0];
                btn.titleLabel.font = [UIFont systemFontOfSize:12];
                ViewRadius(btn, width/2);
                }
                
            }
            else
            {
                [btn setImage:[UIImage imageNamed:@"Avatar_42"] forState:0];
 
            }
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            x += width +offX;
            
        }
    
    }
    else
    {
        x = Main_Screen_Width - 40 - offX - width;
        if (_isQX) {
            x = Main_Screen_Width  - offX - width;
   
        }
        for (int i = 0; i < arr.count; i ++) {
            
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, height, width)];
            btn.tag = 300+ i;
                [btn setImage:[UIImage imageNamed:@"Avatar_42"] forState:0];
            
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            x -= (width +offX);
            
        }
        

    }
    

}
-(void)actionBtn:(UIButton*)btn{
    if (_deleGate) {
        
    if (btn.tag == 400) {
        [_deleGate actionZanBtn:YES];
    }
    else
    {
      [_deleGate actionZanBtn:NO];
    }
    
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
