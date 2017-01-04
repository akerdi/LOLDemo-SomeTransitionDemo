
//
//  SHLoadingNode.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHLoadingNode.h"

static CGFloat kFixedHeight = 200.f;

@interface SHLoadingNode ()

@end

@implementation SHLoadingNode{
    ASDisplayNode *_loadingSpinner;
}

+(CGFloat)desiredHeightForWidth:(CGFloat)width{
    return kFixedHeight;
}

-(instancetype)init{
    if (self = [super init]) {
        _loadingSpinner = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [spinner startAnimating];
            return spinner;
        }];
        _loadingSpinner.style.preferredSize = CGSizeMake(50, 50);
        
        [self addSubnode:_loadingSpinner];
    }
    return self;
}

-(void)layout{
    [super layout];
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASCenterLayoutSpec *centerSpec = [[ASCenterLayoutSpec alloc]init];
    centerSpec.centeringOptions = ASCenterLayoutSpecCenteringXY;
    centerSpec.sizingOptions = ASCenterLayoutSpecSizingOptionDefault;
    centerSpec.child = _loadingSpinner;
    return centerSpec;
}


@end
