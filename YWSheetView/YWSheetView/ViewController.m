//
//  ViewController.m
//  YWSheetView
//
//  Created by yellow on 2019/8/24.
//  Copyright © 2019 YW. All rights reserved.
//

#import "ViewController.h"
#import "YWSheetView.h"

@interface ViewController ()<YWSheetViewDelegate>

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 150, 200, 100);
    [btn setTitle:@"点我弹出sheetView" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)btnClick{
    
    YWSheetView *sheet = [[YWSheetView alloc] init];
    sheet.delegate = self;
    sheet.stringArray = @[reportMoment_str,seeHomePage_str,chat_str];
    [sheet show];
    
    //可以设置你想要的颜色
    sheet.tintColor = YWColor(200, 200, 250);
    sheet.cancelTintColor = YWColor(180, 180, 250);
    sheet.textColor = YWColor(50, 50, 50);
    sheet.cancelTextColor = YWColor(10, 10, 10);
    
}


//sheetViewDelegate
-(void)sheetView:(YWSheetView *)sheetView didClickButtonWithIndex:(NSInteger)index title:(nonnull NSString *)title{
    
    YWLog(@"%@",title);
    
    if ([title isEqualToString:seeHomePage_str]) {
        
    }
    else if ([title isEqualToString:concern_str]){
        
    }
    else if ([title isEqualToString:cancelConcern_str]){
        
    }
    else if ([title isEqualToString:chat_str]){
        
    }
    else if ([title isEqualToString:sayHi_str]){
        
    }
    else if ([title isEqualToString:reportMoment_str]){
        
        
    }
}


@end
