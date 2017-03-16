//
//  SHTextField.m
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/28.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import "SHTextField.h"

@implementation SHTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 控制文本的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    return CGRectInset(rect, 8, 0);
}

// 控制 placeHolder 的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    return CGRectInset(rect, 8, 0);
}

@end
