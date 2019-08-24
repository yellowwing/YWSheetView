//
//  YWSheetView.h
//  Chinese
//
//  Created by yellow on 2019/7/8.
//  Copyright © 2019 YSLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//代理方法
@class YWSheetView;


@protocol YWSheetViewDelegate <NSObject>

@optional

-(void)sheetView:(YWSheetView *)sheetView didClickButtonWithIndex:(NSInteger)index title:(NSString *)title;



@end
@interface YWSheetView : UIView

@property (nonatomic,strong)NSArray* stringArray;

@property (nonatomic,weak) id<YWSheetViewDelegate> delegate;

-(void)show;
-(void)cancel;


@property (nonatomic,strong)UIColor* tintColor;

@property (nonatomic,strong)UIColor* textColor;

@property (nonatomic,strong)UIColor* cancelTintColor;

@property (nonatomic,strong)UIColor* cancelTextColor;


@end

NS_ASSUME_NONNULL_END
