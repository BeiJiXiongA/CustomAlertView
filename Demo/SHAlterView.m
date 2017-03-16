//
//  SHAlterView.m
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/25.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import "SHAlterView.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define TEMPH  240

@implementation SHAlterView
{
    UIView *popView;
    UILabel *titleLabel;
    UIImageView *iconImageView;
    UILabel *messageLabel;
    UIButton *cancelButton;
    UIButton *doneButton;
    UIView *midLineView;
    UIView *lineView;
    CGRect originFrame;
    NSString *titleString;
    NSString *messageString;
    SHAlterViewType alertViewType;
    BOOL haveCancelButton;
}

-(void)showAlterView:(NSString *)title
             message:(NSString *)message
          haveCancel:(BOOL)haveCancel
       alertViewType:(SHAlterViewType)alertType
         andDelegate:(id)delegate
         cancelTitle:(NSString *)cancelTitle
           doneTitle:(NSString *)doneTitle
{
    self.cancelTitle = cancelTitle;
    self.doneTitle = doneTitle;
    [self showAlterView:title message:message haveCancel:haveCancel alertViewType:alertType andDelegate:delegate];
}

-(void)loginfo
{
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName =property_getName(propertyList[i]);
        NSLog(@"property----=%@", [NSString stringWithUTF8String:propertyName]);
    }
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Method method =methodList[i];
        NSLog(@"method----="">%@", NSStringFromSelector(method_getName(method)));
    }
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar =ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"ivar----="">%@", [NSString stringWithUTF8String:ivarName]);
    }
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName =protocol_getName(myProtocal);
        NSLog(@"protocol----="">%@", [NSString stringWithUTF8String:protocolName]);
    }
}

-(void)showAlterView:(NSString *)title
             message:(NSString *)message
          haveCancel:(BOOL)haveCancel
       alertViewType:(SHAlterViewType)alertType
         andDelegate:(id)delegate
{
    [self loginfo];
    if (delegate) {
        self.alertViewDelegate = delegate;
    }
    titleString = title;
    alertViewType = alertType;
    haveCancelButton = haveCancel;
    messageString = message;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.frame = CGRectMake(0, 0, 10000, 10000);
    
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAlterView)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:hideTap];
    
    popView = [[UIView alloc] init];
    popView.frame = CGRectMake(43, SCREEN_HEIGHT/2-TEMPH/2, SCREEN_WIDTH-86, TEMPH);
    popView.backgroundColor = [UIColor whiteColor];
    popView.layer.cornerRadius = 5;
    [self addSubview:popView];
    
    originFrame = CGRectZero;
    if (title && [title length]>0) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 15, CGRectGetWidth(popView.frame)-20, 25);
        titleLabel.text = title;
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor darkGrayColor];
        [popView addSubview:titleLabel];
        originFrame = titleLabel.frame;
        
        CGRect popViewFrame = popView.frame;
        popViewFrame.size.height = TEMPH - 60;
        popViewFrame.origin.y = SCREEN_HEIGHT/2-popViewFrame.size.height/2;
        popView.frame = popViewFrame;
    }else if(alertType != SHAlterViewTypeNone){
        NSString *iconName = @"doubt";
        if (alertType == SHAlterViewTypeFailed) {
            iconName = @"failure";
        }else if(alertType == SHAlterViewTypeSuccess){
            iconName = @"successful";
        }
        iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(CGRectGetWidth(popView.frame)/2-35, 30, 70, 80);
        iconImageView.backgroundColor = [UIColor whiteColor];
        iconImageView.image = [UIImage imageNamed:iconName];
        [popView addSubview:iconImageView];
        originFrame = iconImageView.frame;
    }else{
        CGRect popViewFrame = popView.frame;
        popViewFrame.size.height = TEMPH - 100;
        popViewFrame.origin.y = SCREEN_HEIGHT/2-popViewFrame.size.height/2;
        popView.frame = popViewFrame;
    }
    
    
    if (message && [message length] > 0) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.frame = CGRectMake(25, CGRectGetMaxY(originFrame)+20, CGRectGetWidth(popView.frame)-50, 50);
        messageLabel.text = message;
        messageLabel.numberOfLines = 99999;
        messageLabel.textColor = [UIColor grayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [popView addSubview:messageLabel];
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:message];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, message.length)];
        [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0, [message length])];
        messageLabel.attributedText = attributedString;
        
        CGRect stringRect =  [attributedString boundingRectWithSize:CGSizeMake(CGRectGetWidth(popView.frame)-50, 99999) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        NSLog(@"string rect %@",NSStringFromCGRect(stringRect));
    
        CGRect messageLabelFrame = messageLabel.frame;
        messageLabelFrame.size.height = stringRect.size.height;
        messageLabel.frame = messageLabelFrame;
        
        CGRect popViewFrame = popView.frame;
        popViewFrame.size.height = popViewFrame.size.height-(50-CGRectGetHeight(stringRect));
        popViewFrame.origin.y = SCREEN_HEIGHT/2-popViewFrame.size.height/2;
        popView.frame = popViewFrame;
        
    }else{
        CGRect popViewFrame = popView.frame;
        popViewFrame.size.height = popViewFrame.size.height-90;
        popViewFrame.origin.y = SCREEN_HEIGHT/2-popViewFrame.size.height/2;
        popView.frame = popViewFrame;
    }
    
    
    CGRect doneButtonFrame = CGRectMake(0, CGRectGetHeight(popView.frame)-35, CGRectGetWidth(popView.frame), 35);
    CGRect cancelButtonFrame = CGRectZero;
    if (haveCancel) {
        cancelButtonFrame = CGRectMake(0, CGRectGetHeight(popView.frame)-35, CGRectGetWidth(popView.frame)/2, 35);
        doneButtonFrame = CGRectMake(CGRectGetWidth(popView.frame)/2, CGRectGetHeight(popView.frame)-35, CGRectGetWidth(popView.frame)/2, 35);
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.cancelTitle && self.cancelTitle.length > 0) {
            [cancelButton setTitle:self.cancelTitle forState:UIControlStateNormal];
        }else{
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        }
        cancelButton.frame = cancelButtonFrame;
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[self createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [cancelButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(hideAlterView) forControlEvents:UIControlEventTouchUpInside];
        [popView addSubview:cancelButton];
        
        midLineView = [[UIView alloc] init];
        midLineView.frame = CGRectMake(CGRectGetWidth(popView.frame)/2-0.25f, CGRectGetHeight(popView.frame)-35+0.5f, 0.5f, 35);
        midLineView.backgroundColor = [UIColor lightGrayColor];
        [popView addSubview:midLineView];
    }
    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = doneButtonFrame;
    if (self.doneTitle && self.doneTitle.length > 0) {
        [doneButton setTitle:self.doneTitle forState:UIControlStateNormal];
    }else{
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [doneButton addTarget:self action:@selector(doneClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [doneButton setBackgroundImage:[self createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    [doneButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [popView addSubview:doneButton];
    
    lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, CGRectGetHeight(popView.frame)-35.5f, CGRectGetWidth(popView.frame), 0.5f);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [popView addSubview:lineView];
    
    popView.clipsToBounds = YES;
    
    UIViewController *topVC = [self appRootViewController];
    NSLog(@"topVC is %@",NSStringFromClass([topVC class]));
    if (![topVC isKindOfClass:[UIAlertController class]]) {
    
        [topVC.view endEditing:YES];
        [topVC.view addSubview:self];
    }
}

-(void)hideAlterView
{
    [UIView animateWithDuration:0.2f animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    }];
    
    
}

-(void)orientationChanged:(NSNotification *)notification
{
    return ;
    NSLog(@"orientation changed!");
    [UIView animateWithDuration:0.2f animations:^{
        popView.frame = CGRectMake(43, SCREEN_HEIGHT/2-TEMPH/2, SCREEN_WIDTH-86, TEMPH);
        originFrame = CGRectZero;
        if (titleString && [titleString length]>0) {
            titleLabel.frame = CGRectMake(10, 15, CGRectGetWidth(popView.frame)-20, 25);
            originFrame = titleLabel.frame;
            CGRect popViewFrame = popView.frame;
            popViewFrame.size.height = TEMPH - 60;
            popViewFrame.origin.y = SCREEN_HEIGHT/2-popViewFrame.size.height/2;
            popView.frame = popViewFrame;
        }else if(alertViewType != SHAlterViewTypeNone){
            iconImageView.frame = CGRectMake(CGRectGetWidth(popView.frame)/2-35, 30, 70, 80);
            originFrame = iconImageView.frame;
        }else{
            CGRect popViewFrame = popView.frame;
            popViewFrame.size.height = popViewFrame.size.height-90;
            popViewFrame.origin.y = SCREEN_HEIGHT/2-popViewFrame.size.height/2;
            popView.frame = popViewFrame;
        }
        
        if (messageString && [messageString length] > 0) {
            messageLabel.frame = CGRectMake(25, CGRectGetMaxY(originFrame)+20, CGRectGetWidth(popView.frame)-50, messageLabel.frame.size.height);
            if (CGRectGetHeight(messageLabel.frame) < 50) {
                CGRect popViewFrame = popView.frame;
                popViewFrame.size.height = popViewFrame.size.height-(50-CGRectGetHeight(messageLabel.frame));
                popViewFrame.origin.y = SCREEN_HEIGHT/2-popViewFrame.size.height/2;
                popView.frame = popViewFrame;
            }
        }
        
        CGRect doneButtonFrame = CGRectMake(0, CGRectGetHeight(popView.frame)-35, CGRectGetWidth(popView.frame), 35);
        CGRect cancelButtonFrame = CGRectZero;
        if (haveCancelButton) {
            cancelButtonFrame = CGRectMake(0, CGRectGetHeight(popView.frame)-35, CGRectGetWidth(popView.frame)/2, 35);
            doneButtonFrame = CGRectMake(CGRectGetWidth(popView.frame)/2, CGRectGetHeight(popView.frame)-35, CGRectGetWidth(popView.frame)/2, 35);
            cancelButton.frame = cancelButtonFrame;
            iconImageView.frame = CGRectMake(CGRectGetWidth(popView.frame)/2-35, 30, 70, 80);
            midLineView.frame = CGRectMake(CGRectGetWidth(popView.frame)/2-0.25f, CGRectGetHeight(popView.frame)-35+0.5f, 0.5f, 35);
        }
        doneButton.frame = doneButtonFrame;
        lineView.frame = CGRectMake(0, CGRectGetHeight(popView.frame)-35.5f, CGRectGetWidth(popView.frame), 0.5f);
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)doneClick:(UIButton *)doneButton
{
    if ([self.alertViewDelegate respondsToSelector:@selector(doneButtonClick)]) {
        [self.alertViewDelegate doneButtonClick];
    }
    [self hideAlterView];
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController && ![topVC isKindOfClass:[UIAlertController class]]) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
