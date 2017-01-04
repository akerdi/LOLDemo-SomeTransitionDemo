//
//  SHChampionDetailCellNode.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/18.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface SHChampionDetailTitleCellNode : ASCellNode

@property (nonatomic, strong) NSMutableArray *shapeArray;
@property (nonatomic, strong) NSMutableArray *nodeArray;
@property (nonatomic, strong) NSMutableArray *labelArray;

-(instancetype)initWithModel:(id)championsModel championsDetailModel:(id)championsDetailModel;

@end
