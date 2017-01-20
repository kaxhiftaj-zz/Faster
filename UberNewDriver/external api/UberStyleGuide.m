//
//  UberStyleGuide.m
//  UberforXOwner
//
//  Created by Elluminati - macbook on 08/01/15.
//  Copyright (c) 2015 Jigs. All rights reserved.
//

#import "UberStyleGuide.h"

@implementation UberStyleGuide

#pragma mark- Color

+(UIColor *)colorDefault

{
    UIColor *regularColor= [UIColor colorWithRed:(3.0f/255.0f) green:(169.0f/255.0f) blue:(245.0f/255.0f) alpha:1.0];
    return regularColor;
}

#pragma mark - Fonts

+ (UIFont *)fontRegularLight {
    return [UIFont fontWithName:@"OpenSans-Light" size:14.0f];
}

+ (UIFont *)fontRegular {
    //return [UIFont fontWithName:@"OpenSans-Regular" size:14.0f];
    return [UIFont fontWithName:@"OpenSans" size:14.0f];
}

+ (UIFont *)fontRegular:(CGFloat)size
{
    return [UIFont fontWithName:@"OpenSans" size:size];
}

+ (UIFont *)fontRegularBold
{
    
   return [UIFont fontWithName:@"OpenSans-Bold" size:13.0f];
}

+ (UIFont *)fontSemiBold
{
    
    return [UIFont fontWithName:@"OpenSans-Semibold" size:13.0f];
}

+ (UIFont *)fontSemiBold:(CGFloat)size
{
    return [UIFont fontWithName:@"OpenSans-Semibold" size:size];
}


+ (UIFont *)fontRegularBold:(CGFloat)size
{
    return [UIFont fontWithName:@"OpenSans-Bold" size:size];
}

+ (UIFont *)fontButtonBold {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f];
}

+ (UIFont *)fontLarge {
    return [UIFont fontWithName:@"HelveticaNeue" size:21.0f];
}




@end
