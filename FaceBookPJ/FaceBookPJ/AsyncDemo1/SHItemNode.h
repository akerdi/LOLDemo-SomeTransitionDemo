//
//  SHItemNode.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
@class SHItemViewModel;

@interface SHItemNode : ASCellNode

-initWithViewModel:(SHItemViewModel *)viewModel;
+(CGSize)sizeForWidth:(CGFloat)width;
+(CGSize)preferredViewSize;

@end
