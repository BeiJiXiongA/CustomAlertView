//
//  UILabel+AttributedLabel.m
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/26.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import "UILabel+AttributedLabel.h"

@implementation UILabel (AttributedLabel)

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
