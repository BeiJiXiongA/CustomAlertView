//
//  AttributedLabel.h
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/26.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttributedLabel : UILabel

-(void)setAttributedWithString:(NSString *)infoString
                       keyWord:(NSString *)keyWord;

-(void)setAttributedWithString:(NSString *)infoString
                       keyWord:(NSString *)keyWord
                   keyWordFont:(UIFont *)keyWordFont;

-(void)setAttributedWithString:(NSString *)infoString
                       keyWord:(NSString *)keyWord
                   keyWordFont:(UIFont *)keyWordFont
                  keyWordColor:(UIColor *)keyWordColor;

-(void)setAttributedWithString:(NSString *)infoString
                       keyWord:(NSString *)keyWord
                   keyWordFont:(UIFont *)keyWordFont
                  keyWordColor:(UIColor *)keyWordColor
                 textAlignment:(NSTextAlignment)textAlign;

@end
