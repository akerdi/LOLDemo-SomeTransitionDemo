//
//  SHChampionCellNodel.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHChampionCellNodel.h"

#import "SHChampionsModel.h"

#import "FBShimmeringView.h"


@interface SHChampionCellNodel ()

@property (nonatomic, strong) ASImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *textNode;
@property (nonatomic, strong) ASDisplayNode *textParentNode;

@property (nonatomic, strong) SHChampionsModel *model;

@end

@implementation SHChampionCellNodel

-(instancetype)initWithModel:(id)model{
    if (self = [super init]) {
        self.model = model;
        self.imageNode = [[ASImageNode alloc]init];
        self.imageNode.style.flexGrow = YES;
        
        self.imageNode.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubnode:self.imageNode];
        self.imageNode.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.model.pic ofType:nil]];
        
        self.textParentNode = [[ASDisplayNode alloc]init];
        [self addSubnode:self.textParentNode];
        
        self.textNode = [[ASTextNode alloc]init];
        self.textNode.layerBacked = YES;
        self.textParentNode.backgroundColor = [UIColor flatWhiteColor];
        self.textNode.attributedText = [SHAttributeTool championtitleAttributeWith:self.model.cname];
        [self.textParentNode addSubnode:self.textNode];
        @weakify(self);
        self.textParentNode.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize){
            @strongify(self);
            return [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionDefault child:self.textNode];
        };
        
        self.borderWidth = 1/[UIScreen mainScreen].scale;
        self.borderColor = FlatGray.CGColor;
        
        
    }
    return self;
}

-(void)didLoad{
    [super didLoad];
    self.shimmeringLayer = [[FBShimmeringView alloc]initWithFrame:CGRectMake(0, 0, self.imageNode.calculatedSize.width, self.imageNode.calculatedSize.height)];
    [self.view addSubview:self.shimmeringLayer];
    self.shimmeringLayer.contentView = self.imageNode.view;
    self.shimmeringLayer.shimmering = YES;
    self.shimmeringLayer.shimmeringSpeed -=90;
    @weakify(self);
    [[[RACSignal interval:4 onScheduler:[RACScheduler currentScheduler]] take:1] subscribeNext:^(id x) {
        @strongify(self);
        self.shimmeringLayer.shimmering = NO;
    }];
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    self.imageNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, constrainedSize.max.height-25);
    self.textParentNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 25);
    return [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsCenter children:@[self.imageNode,self.textParentNode]];
}

@end
