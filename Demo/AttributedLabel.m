//
//  AttributedLabel.m
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/26.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import "AttributedLabel.h"

@implementation AttributedLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setAttributedWithString:(NSString *)infoString
                       keyWord:(NSString *)keyWord
{
    [self setAttributedWithString:infoString keyWord:keyWord keyWordFont:[UIFont systemFontOfSize:12] keyWordColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft];
}

-(void)setAttributedWithString:(NSString *)infoString
                       keyWord:(NSString *)keyWord
                   keyWordFont:(UIFont *)keyWordFont
{
    [self setAttributedWithString:infoString keyWord:keyWord keyWordFont:keyWordFont keyWordColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft];
}

-(void)setAttributedWithString:(NSString *)infoString
                       keyWord:(NSString *)keyWord
                   keyWordFont:(UIFont *)keyWordFont
                  keyWordColor:(UIColor *)keyWordColor
{
    [self setAttributedWithString:infoString keyWord:keyWord keyWordFont:keyWordFont keyWordColor:keyWordColor textAlignment:NSTextAlignmentLeft];
}

-(void)setAttributedWithString:(NSString *)infoString
                       keyWord:(NSString *)keyWord
                   keyWordFont:(UIFont *)keyWordFont
                  keyWordColor:(UIColor *)keyWordColor
                 textAlignment:(NSTextAlignment)textAlign
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:infoString];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:keyWordColor,NSFontAttributeName:keyWordFont} range:[infoString rangeOfString:keyWord]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = textAlign;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, infoString.length)];
    self.attributedText = attributedString;
}


@end
