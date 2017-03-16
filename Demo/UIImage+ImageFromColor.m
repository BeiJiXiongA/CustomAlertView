//
//  UIImage+ImageFromColor.m
//  SpaceHome
//
//  Created by ZhangWei-SpaceHome on 15/9/8.
//
//

#import "UIImage+ImageFromColor.h"

@implementation UIImage (ImageFromColor)
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
