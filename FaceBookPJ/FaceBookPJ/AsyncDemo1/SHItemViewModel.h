//
//  SHItemViewModel.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHItemViewModel : NSObject

+(instancetype)randomItem;

@property (nonatomic,copy) NSString *titleText;
@property (nonatomic,copy) NSString *firstInfoText;
@property (nonatomic,copy) NSString *secondInfoText;
@property (nonatomic,copy) NSString *originalPriceText;
@property (nonatomic,copy) NSString *finalPriceText;
@property (nonatomic,copy) NSString *soldOutText;
@property (nonatomic,copy) NSString *distanceLabelText;
@property (nonatomic,copy) NSString *badgeText;

-(NSURL *)imageURLWithSize:(CGSize)size;

@end
