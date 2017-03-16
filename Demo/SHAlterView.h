//
//  SHAlterView.h
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/25.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHAlterViewType) {
    SHAlterViewTypeSuccess = 0,
    SHAlterViewTypeFailed,
    SHAlterViewTypeDoubt,
    SHAlterViewTypeNone
};

@protocol SHAlertViewDelegate <NSObject>

@optional
-(void)doneButtonClick;

@end

@interface SHAlterView : UIView

@property (nonatomic, assign) id<SHAlertViewDelegate> alertViewDelegate;

@property (nonatomic, strong) NSString *doneTitle;
@property (nonatomic, strong) NSString *cancelTitle;

-(void)showAlterView:(NSString *)title
             message:(NSString *)message
          haveCancel:(BOOL)haveCancel
       alertViewType:(SHAlterViewType)alertType
         andDelegate:(id)delegate
         cancelTitle:(NSString *)cancelTitle
           doneTitle:(NSString *)doneTitle;

-(void)showAlterView:(NSString *)title
             message:(NSString *)message
          haveCancel:(BOOL)haveCancel
       alertViewType:(SHAlterViewType)alertType
         andDelegate:(id)delegate;

-(void)hideAlterView;
@end
