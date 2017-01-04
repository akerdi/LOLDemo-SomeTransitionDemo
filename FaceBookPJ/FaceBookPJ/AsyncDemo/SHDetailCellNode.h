//
//  SHDetailCellNode.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface SHDetailCellNode : ASCellNode

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, copy) NSString *imageCategory;
@property (nonatomic,strong) ASNetworkImageNode *imageNode;

@end
