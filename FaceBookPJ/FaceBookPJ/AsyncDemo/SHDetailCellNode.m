//
//  SHDetailCellNode.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHDetailCellNode.h"

@implementation SHDetailCellNode

-(instancetype)init{
    if (self = [super init]) {
        self.automaticallyManagesSubnodes = YES;
        _imageNode = [[ASNetworkImageNode alloc]init];
        _imageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
        
        
        
        
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    return [ASRatioLayoutSpec ratioLayoutSpecWithRatio:1.f child:self.imageNode];
}
-(void)layoutDidFinish{
    [super layoutDidFinish];
    
    self.imageNode.URL = [self imageURL];
}

- (NSURL *)imageURL
{
    CGSize imageSize = self.calculatedSize;
    NSString *imageURLString = [NSString stringWithFormat:@"http://lorempixel.com/%ld/%ld/%@/%ld", (NSInteger)imageSize.width, (NSInteger)imageSize.height, self.imageCategory, self.row];
    return [NSURL URLWithString:imageURLString];
}



@end
