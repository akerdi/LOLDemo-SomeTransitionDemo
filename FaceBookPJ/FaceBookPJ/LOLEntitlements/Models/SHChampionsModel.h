//
//  SHChampionsModel.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
 cname = "\U5b89\U59ae";
 ename = Annie;
 id = 1;
 pic = "annie_square_0.png";
 title = "\U9ed1\U6697\U4e4b\U5973";
 update = "2016-08-14T21:45:48";
 }*/

@interface SHChampionsModel : NSObject

@property (nonatomic, copy) NSString *cname;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *update;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, copy) NSString *ename;

@end
