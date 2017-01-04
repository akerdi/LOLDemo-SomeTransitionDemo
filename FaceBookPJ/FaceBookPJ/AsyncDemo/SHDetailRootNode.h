//
//  SHDetailRootNode.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface SHDetailRootNode : ASDisplayNode

@property (nonatomic,strong, readonly) ASCollectionNode *collectionNode;

-(instancetype)initWithImageCategory:(NSString *)imageCategory;

@end
