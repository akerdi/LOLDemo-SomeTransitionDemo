//
//  SHAttributeTool.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHAttributeTool.h"

@implementation SHAttributeTool

+(NSAttributedString *)championtitleAttributeWith:(NSString *)str{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    NSAttributedString *strr = [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor flatWhiteColorDark],NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle}];
    return strr;
}

+(NSAttributedString *)championDetailDescriptionWith:(NSString *)str{
    NSAttributedString *strr = [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor flatWhiteColorDark],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return strr;
}

+(NSAttributedString *)championDetailTitleWith:(NSString *)str{
    NSAttributedString *strr = [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor flatWhiteColorDark],NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    return strr;
}

@end
