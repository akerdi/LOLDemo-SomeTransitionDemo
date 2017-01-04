//
//  SHChampionCellNodel.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class FBShimmeringView;

@interface SHChampionCellNodel : ASCellNode

@property (nonatomic, strong) FBShimmeringView *shimmeringLayer;

-(instancetype)initWithModel:(id)model;

@end
