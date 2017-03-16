//
//  LongPressView.h
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/27.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LongPressView : UIView

@property (nonatomic, strong) UIView *tipView;

@property (nonatomic, strong) NSString *iconImageName;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *tipString;
-(void)layoutViews;
@end
