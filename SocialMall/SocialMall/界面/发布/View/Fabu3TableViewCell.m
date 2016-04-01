//
//  Fabu3TableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/26.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "Fabu3TableViewCell.h"
#import "addMesModel.h"

@interface Fabu3TableViewCell ()<UIScrollViewDelegate>{
    
    
    addMesModel * _goodsModel;
    UIPageControl * pageCtl;
}

@end

@implementation Fabu3TableViewCell
-(void)prepareUI:(NSMutableArray*)photoArray FenggeArray:(NSMutableArray*)fenggeArray{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview ];
    }
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10,0, 100, 40)];
    lbl.text = @"已购买";
    lbl.font = AppFont;
    lbl.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:lbl];
    //40
    BOOL ischao = NO;
    if (photoArray.count > 6) {
       ischao = YES;
    }
    else
    {
        ischao = NO;
 
    }
    
    
    
    
    
    if (!ischao) {
    CGFloat x = 5;
    CGFloat offx = 5;
    CGFloat y = 40;
    CGFloat width = (Main_Screen_Width - 4 * 5)/3;
    CGFloat height = width;
    for (int i = 0; i < photoArray.count; i ++){
        
        

        addMesModel * model = photoArray[i];
        _goodsModel = model;
        
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgview.contentMode = UIViewContentModeScaleAspectFit;
        [imgview sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:[UIImage imageNamed:@"releaes_default-photo"]];
       
       [self.contentView addSubview:imgview];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(imgview.frame.size.width - 5 - 20, 5, 20, 20)];
        [btn setImage:[UIImage imageNamed:@"check-box_normal"] forState:UIControlStateNormal];
        ViewRadius(btn, 10);
        [btn setImage:[UIImage imageNamed:@"check-box_pressed"] forState:UIControlStateSelected];
        if ([fenggeArray containsObject:model]) {
            btn.selected = YES;
        }
        else
        {
            btn.selected = NO;

        }
        [imgview addSubview:btn];
        imgview.userInteractionEnabled = YES;
        btn.tag = 500+i;
        [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        x += width + offx;
        if (i ==2) {
            y += height + offx;
            x = offx;
        }
        
        
    }
        
        //y + h + 5;
        
    
    }
    else
    {
        
        NSInteger pagenum =  photoArray.count / 6;
        NSInteger countnum = photoArray.count % 6;
        NSLog(@"%d,%d,%d",photoArray.count,pagenum,countnum);
        CGFloat width = (Main_Screen_Width - 4 * 5)/3;

        UIScrollView * _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, Main_Screen_Width, width * 2 + 5)];
        _ScrollView.contentSize = CGSizeMake(Main_Screen_Width * pagenum, 0);
        _ScrollView.delegate = self;
        _ScrollView.pagingEnabled = YES;
        [self.contentView addSubview:_ScrollView];
        

        CGFloat x = 5;
        CGFloat offx = 5;
        CGFloat y = 5;
        CGFloat height = width;
 
        CGFloat widthOffx= 0;

        NSInteger indexCount = 0;
        for (int a = 0; a < pagenum; a++) {
            
        
        for (int i = 0; i < 2; i ++){
            
            
            for (int j = 0;j < 3;j++) {
                
                addMesModel * model = photoArray[indexCount];

                
                UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
                imgview.contentMode = UIViewContentModeScaleAspectFit;
                [imgview sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:[UIImage imageNamed:@"releaes_default-photo"]];
                
                [_ScrollView addSubview:imgview];
                UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(imgview.frame.size.width - 5 - 20, 5, 20, 20)];
                [btn setImage:[UIImage imageNamed:@"check-box_normal"] forState:UIControlStateNormal];
                ViewRadius(btn, 10);
                [btn setImage:[UIImage imageNamed:@"check-box_pressed"] forState:UIControlStateSelected];
                if ([fenggeArray containsObject:model]) {
                    btn.selected = YES;
                }
                else
                {
                    btn.selected = NO;
                    
                }
                [imgview addSubview:btn];
                imgview.userInteractionEnabled = YES;
                btn.tag = 500+indexCount;
                [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
//                UILabel * l = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
//                l.text = [NSString stringWithFormat:@"%d",indexCount];
//                l.textColor = [UIColor blackColor];
//                [_ScrollView addSubview:l];

                
  
                indexCount ++;
                x +=width + offx;
                
                
            
            }
           x = widthOffx + offx;
            y += width+ 5;
            
        }
            widthOffx = Main_Screen_Width + a *Main_Screen_Width;
            x = widthOffx + offx;
            y = 5;
            
        }
        
        
        y = 40 + _ScrollView.frame.size.height;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, y, Main_Screen_Width, 30)];
        view.backgroundColor = [UIColor whiteColor];
        pageCtl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
        //设置共有多少页
        pageCtl.numberOfPages = pagenum;
        //设置当前页
        pageCtl.currentPage = 0;
        //设置指示点的颜色
        pageCtl.pageIndicatorTintColor = [UIColor lightGrayColor];
        //设置当前页指示点的颜色
        pageCtl.currentPageIndicatorTintColor = [UIColor grayColor];
        [view addSubview:pageCtl];
        [self.contentView addSubview:view];
        

        
    }
    
    
    
    
//    NSString * ss = @"没有你的搭配，点击添加";
//  CGFloat w =  [MCIucencyView heightforString:ss andHeight:40 fontSize:13];
//    CGFloat ix = Main_Screen_Width - 25 - 20;//Main_Screen_Width/ 2 - w / 2 - 5 - 25;
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
    
    
//    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(ix, 5, 40, 40)];
//    [btn2 setImage:[UIImage imageNamed:@"add_icon"] forState:0];
//    [btn2 addTarget:self action:@selector(actionBtn2:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.contentView addSubview:btn2];
    
    
    //y+height
    
    
    
}
-(void)actionBtn2:(UIButton*)btn{
    
    [_delagate actionAdd];
    
}
-(void)actionBtn:(UIButton*)btn{
    
    if (btn.selected) {
        btn.selected = NO;
    }
    else
    {
        btn.selected = YES;
 
    }
    
    
//    for (int i = 0; i < 6; i ++) {
//        UIButton * btn2 = (UIButton*)[self viewWithTag:500 + i];
//        btn2.selected = NO;
//        btn2.backgroundColor = [UIColor whiteColor];
//    }
//    btn.selected = YES;
    NSLog(@"%d",btn.tag - 500);
    
    [_delagate selegoods:btn.tag - 500 Issele:btn.selected];
    
    

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //当加速结束后,在停止的位置上,找到偏移量的x,计算页码
    NSInteger index = scrollView.contentOffset.x / Main_Screen_Width;
    pageCtl.currentPage = index;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
