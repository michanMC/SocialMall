//
//  Fabu3TableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/26.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "Fabu3TableViewCell.h"
#import "goodsDataModel.h"

@interface Fabu3TableViewCell (){
    
    
    goodsDataModel * _goodsModel;
}

@end

@implementation Fabu3TableViewCell
-(void)prepareUI:(NSMutableArray*)photoArray{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview ];
    }
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10,0, 100, 40)];
    lbl.text = @"已购买";
    lbl.font = AppFont;
    lbl.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:lbl];
    
    
    CGFloat x = 5;
    CGFloat offx = 5;
    CGFloat y = 40;
    CGFloat width = (Main_Screen_Width - 4 * 5)/3;
    CGFloat height = width;
    for (int i = 0; i < photoArray.count; i ++){
        
        int row=i/3;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%3;//列号
        goodsDataModel * model = photoArray[i];
        _goodsModel = model;
        x=offx+(offx+width)*loc ;
        y=offx+(offx+height)*row + 40;
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgview.contentMode = UIViewContentModeScaleAspectFit;
        [imgview sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:[UIImage imageNamed:@"releaes_default-photo"]];
       
       [self.contentView addSubview:imgview];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(imgview.frame.size.width - 5 - 20, 5, 20, 20)];
        [btn setImage:[UIImage imageNamed:@"check-box_normal"] forState:UIControlStateNormal];
        ViewRadius(btn, 10);
        [btn setImage:[UIImage imageNamed:@"check-box_pressed"] forState:UIControlStateSelected];
        
        [imgview addSubview:btn];
        imgview.userInteractionEnabled = YES;
        btn.tag = 500+i;
        [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    NSString * ss = @"没有你的搭配，点击添加";
  CGFloat w =  [MCIucencyView heightforString:ss andHeight:40 fontSize:13];
    CGFloat ix = Main_Screen_Width - 25 - 20;//Main_Screen_Width/ 2 - w / 2 - 5 - 25;
   // UIImageView * iimg = [[UIImageView alloc]initWithFrame:CGRectMake(ix, y+height + (40 - 25)/2 , 25, 25)];
//    UIImageView * iimg = [[UIImageView alloc]initWithFrame:CGRectMake(ix, 10 , 25, 25)];
//
//    iimg.image = [UIImage imageNamed:@"add_icon"];
//    [self.contentView addSubview:iimg];
//    UILabel * lbl2 = [[UILabel alloc]initWithFrame:CGRectMake((Main_Screen_Width - w ) / 2, y+height, w, 40)];
//    lbl2.text = ss;
//    lbl2.textColor = [UIColor grayColor];
//    lbl2.font = [UIFont systemFontOfSize:13];
//    [self.contentView addSubview:lbl2];
    
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(ix, 5, 40, 40)];
    [btn2 setImage:[UIImage imageNamed:@"add_icon"] forState:0];
    [btn2 addTarget:self action:@selector(actionBtn2:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:btn2];
    
    
    //y+height
    
    
    
}
-(void)actionBtn2:(UIButton*)btn{
    
    [_delagate actionAdd];
    
}
-(void)actionBtn:(UIButton*)btn{
    
    
    for (int i = 0; i < 6; i ++) {
        UIButton * btn2 = (UIButton*)[self viewWithTag:500 + i];
        btn2.selected = NO;
        btn2.backgroundColor = [UIColor whiteColor];
    }
    btn.selected = YES;
    NSLog(@"%d",btn.tag - 500);

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
