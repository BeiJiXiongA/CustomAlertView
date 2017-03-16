//
//  LongPressView.m
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/27.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import "LongPressView.h"
@interface LongPressView ()
{
    UIImageView *iconImageView;
    UILabel *titleLabel;
}
@end
@implementation LongPressView

-(id)init
{
    self = [super init];
    if (self) {
//        [self layoutViews];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self layoutViews];
    }
    return self;
}

-(void)layoutViews
{
    if (self.iconImageName && self.iconImageName.length > 0) {
        iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(10, CGRectGetHeight(self.frame)/2-9, 18, 18);
        iconImageView.image = [UIImage imageNamed:self.iconImageName];
        [self addSubview:iconImageView];
    }
    
    if (self.titleString && self.titleString.length > 0) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.titleString;
        titleLabel.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame)+10, 0, CGRectGetWidth(self.frame)-CGRectGetWidth(iconImageView.frame)-20, CGRectGetHeight(self.frame));
        [self addSubview:titleLabel];
    }
    if (self.tipString && self.tipString.length > 0) {
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.text = self.tipString;
        tipLabel.frame = CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2, 0, 0);
        tipLabel.hidden = YES;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:tipLabel];
        self.tipView = tipLabel;
    }else{
        self.tipView = [[UILabel alloc] init];
        self.tipView.frame = CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2, 0, 0);
        self.tipView.hidden = YES;
        self.tipView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.tipView];
    }
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 5;
    self.tipView.clipsToBounds = YES;
    self.tipView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tipView.layer.borderWidth = 0.5f;
    [self addLongGesture];
}

-(void)addLongGesture
{
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesturePress:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:longGesture];
}

-(void)longGesturePress:(UILongPressGestureRecognizer *)longGesture
{
    CGPoint centerPoint = [longGesture locationInView:self];
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        self.tipView.hidden = NO;
        
        [UIView animateWithDuration:0.1f animations:^{
            self.tipView.frame = CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2, 100, 40);
            self.tipView.center = CGPointMake(CGRectGetWidth(self.frame)/2, -30);
        }];
    }else if(longGesture.state == UIGestureRecognizerStateChanged){
        [UIView animateWithDuration:0.1f animations:^{
            self.tipView.center = CGPointMake(centerPoint.x, centerPoint.y-CGRectGetHeight(self.tipView.frame)-20);
        }];
    }else if (longGesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2f animations:^{
            self.tipView.center = CGPointMake(CGRectGetWidth(self.frame)/2, -30);
        } completion:^(BOOL finished) {
            self.tipView.hidden = YES;
        }];
    }else if(longGesture.state == UIGestureRecognizerStateFailed){
        [UIView animateWithDuration:0.2f animations:^{
            self.tipView.center = CGPointMake(CGRectGetWidth(self.frame)/2, -30);
        } completion:^(BOOL finished) {
            self.tipView.hidden = YES;
        }];
    }
}

@end
