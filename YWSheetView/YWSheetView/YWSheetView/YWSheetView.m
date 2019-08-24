//
//  YWSheetView.m
//  Chinese
//
//  Created by yellow on 2019/7/8.
//  Copyright © 2019 YSLC. All rights reserved.
//

#import "YWSheetView.h"

#import "Masonry.h"

#define interval 4
#define btnHeight 50

@interface YWSheetView ()

@property(nonatomic,weak)UIButton *blackBtn;

@property(nonatomic,weak)UIView *btnBgView;

@end


@implementation YWSheetView


-(void)setStringArray:(NSArray *)stringArray{
    
    _stringArray = stringArray;
    
    //所有东西在这里创建
    
    //大小占整个屏幕，add在window上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    
    
    self.frame = CGRectMake(0, 0, Wi, He);
    
    
    //黑色遮罩
    UIButton *blackBtn = [[UIButton alloc] init];
    [self addSubview:blackBtn];
    
    
    
    blackBtn.frame = CGRectMake(0, 0, Wi, He);
    
    blackBtn.backgroundColor = YWColorRGBA(0, 0, 0, 0.5);
    
    blackBtn.alpha = 0;
    [blackBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    self.blackBtn = blackBtn;
    
// 所有按钮后面创建有个view，移动这个view的transform就可以了
    UIView *btnBgView = [[UIView alloc] init];
    [self addSubview:btnBgView];
    
    CGFloat height = btnHeight + interval + btnHeight * stringArray.count;
    
    [btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(btnBgView.superview).with.offset(0);
        make.right.equalTo(btnBgView.superview).with.offset(0);
        make.bottom.equalTo(btnBgView.superview).with.offset(0);
        make.height.mas_equalTo(height);
    }];
    
    self.btnBgView = btnBgView;
    
    //创建取消按钮，tag值为-1，点击的代理方法的index就是tag
    UIButton *cancelBtn = [[UIButton alloc] init];
    [btnBgView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.superview).with.offset(0);
        make.right.equalTo(cancelBtn.superview).with.offset(0);
        make.bottom.equalTo(cancelBtn.superview).with.offset(0);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelBtn.backgroundColor = YWColor(40, 40, 40);
    cancelBtn.tag = -1;
    
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    
    //根据数组创建按钮
    for (NSInteger i = 0;  i < stringArray.count; i++ ) {
        
        UIButton *chooseBtn = [[UIButton alloc] init];
        [btnBgView addSubview:chooseBtn];
        [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            CGFloat bottom = btnHeight + interval + btnHeight * i;
            
            make.left.equalTo(chooseBtn.superview).with.offset(0);
           
            make.right.equalTo(chooseBtn.superview).with.offset(0);
             make.bottom.equalTo(chooseBtn.superview).with.offset(-bottom);
            
            make.height.mas_equalTo(btnHeight);
        }];
        
        
        [chooseBtn setTitle:stringArray[i] forState:UIControlStateNormal];
        [chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        chooseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        chooseBtn.backgroundColor = YWColor(40, 40, 40);
        chooseBtn.tag = i;
        
        [chooseBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
        btnBgView.transform = CGAffineTransformMakeTranslation(0,height);
    
}

-(void)setTintColor:(UIColor *)tintColor{
    
    _tintColor = tintColor;
    
    for (UIView *view in self.btnBgView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            
            if (btn.tag != -1) {
                btn.backgroundColor = tintColor;
            }
            
        }
    }
    
}

-(void)setTextColor:(UIColor *)textColor{
    
    _textColor = textColor;
    
    for (UIView *view in self.btnBgView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            
            if (btn.tag != -1) {
                [btn setTitleColor:textColor forState:UIControlStateNormal];
            }
            
        }
    }
    
}

-(void)setCancelTintColor:(UIColor *)cancelTintColor{
    
    _cancelTintColor = cancelTintColor;
    
    for (UIView *view in self.btnBgView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            
            if (btn.tag == -1) {
                btn.backgroundColor = cancelTintColor;
            }
            
        }
    }
    
    
}

-(void)setCancelTextColor:(UIColor *)cancelTextColor{
    
    _cancelTextColor = cancelTextColor;
    
    for (UIView *view in self.btnBgView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            
            if (btn.tag == -1) {
                [btn setTitleColor:cancelTextColor forState:UIControlStateNormal];
            }
            
        }
    }
    
}


-(void)show{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.blackBtn.alpha = 1;
        
        self.btnBgView.transform = CGAffineTransformIdentity;
    }];
    
}

-(void)cancel{
  
    CGFloat height = btnHeight + interval + btnHeight * self.stringArray.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.blackBtn.alpha = 0;
        
        self.btnBgView.transform = CGAffineTransformMakeTranslation(0,height);
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

-(void)buttonClick:(UIButton *)button{
    
    NSInteger index = button.tag;
    
    if ([self.delegate respondsToSelector:@selector(sheetView:didClickButtonWithIndex:title:)]) {
        [self.delegate sheetView:self didClickButtonWithIndex:index title:button.titleLabel.text];
    }
    
    
    [self cancel];
    
}





@end
