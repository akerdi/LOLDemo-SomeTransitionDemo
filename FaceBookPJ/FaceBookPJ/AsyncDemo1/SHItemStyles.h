//
//  SHItemStyles.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHItemStyles : NSObject
+ (NSDictionary *)titleStyle;
+ (NSDictionary *)subtitleStyle;
+ (NSDictionary *)distanceStyle;
+ (NSDictionary *)secondInfoStyle;
+ (NSDictionary *)originalPriceStyle;
+ (NSDictionary *)finalPriceStyle;
+ (NSDictionary *)soldOutStyle;
+ (NSDictionary *)badgeStyle;
+ (UIColor *)badgeColor;
+ (UIImage *)placeholderImage;
@end
