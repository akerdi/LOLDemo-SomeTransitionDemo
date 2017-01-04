//
//  SHChampionsDetailModel.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/18.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHChampionsDetailModel.h"
#import <MJExtension/MJExtension.h>

@implementation SHChampionsDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"spells":@"SHChampionsDetailSpells",
             @"skins":@"SHChampionsDetailSkins"
             };
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@",self.spells,self.name];
}

@end

@implementation SHChampionsDetailSkins
@end
@implementation SHChampionsDetailPassive

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"descriptionn":@"description"
             };
}

@end
@implementation SHChampionsDetailInfo
@end
@implementation SHChampionsDetailSpells
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"descriptionn":@"description"
             };
}
@end
