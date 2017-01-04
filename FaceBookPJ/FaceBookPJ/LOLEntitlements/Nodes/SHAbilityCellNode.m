//
//  SHAbilityCellNode.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/19.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHAbilityCellNode.h"

#import "SHChampionsDetailModel.h"

@interface SHAbilityCellNode()

@property (nonatomic, strong) NSMutableArray *imageNodeArray;
@property (nonatomic, strong) NSMutableArray *attributeArray;
//@property (nonatomic, strong) ASDisplayNode *imageParentNode;
@property (nonatomic, strong) ASTextNode *descriptionNode;
//@property (nonatomic, strong) ASDisplayNode *separatorNode;

@property (nonatomic, strong) SHChampionsDetailModel *detailModel;
@end

@implementation SHAbilityCellNode

-(instancetype)initWithMode:(id)model{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageNodeArray = [[NSMutableArray alloc]initWithCapacity:5];
        self.attributeArray = [[NSMutableArray alloc]initWithCapacity:5];
        self.detailModel = model;
        
//        self.imageParentNode = [[ASDisplayNode alloc]init];
//        self.imageParentNode.style.flexGrow = YES;
        for (int i=0; i<5; i++) {
            if (i>0) {
                SHChampionsDetailSpells *spell = self.detailModel.spells[i-1];
                [self.attributeArray addObject:[SHAttributeTool championDetailDescriptionWith:spell.tooltip]];
            }else{
                [self.attributeArray addObject:[SHAttributeTool championDetailDescriptionWith:self.detailModel.passive.descriptionn]];
            }
            
            ASImageNode *abilityImgNode = [[ASImageNode alloc]init];
//            abilityImgNode.style.preferredSize = CGSizeMake(60, 60);
            abilityImgNode.style.flexGrow = YES;
            abilityImgNode.backgroundColor = [UIColor randomFlatColor];
            [abilityImgNode addTarget:self action:@selector(abilityImgNodeImgClick:) forControlEvents:ASControlNodeEventTouchUpInside];
            NSString *imgName = i==0?self.detailModel.passive.image[@"full"]:[self.detailModel.spells[i-1] valueForKeyPath:@"image"][@"full"];
            abilityImgNode.image = [UIImage imageNamed:imgName];
            [self addSubnode:abilityImgNode];
            [self.imageNodeArray addObject:abilityImgNode];
        }
        
        self.descriptionNode = [[ASTextNode alloc]init];
        self.descriptionNode.layerBacked = YES;
//            self.descriptionNode.style.flexShrink = YES;
        self.descriptionNode.attributedText = self.attributeArray[0];
        [self addSubnode:self.descriptionNode];
        
//        self.separatorNode = [[ASDisplayNode alloc]init];
//        self.separatorNode.backgroundColor = [UIColor flatGrayColor];
//        [self addSubnode:self.separatorNode];
    }
    return self;
}

-(void)didLoad{
    [super didLoad];
//    CGSize size = self.calculatedSize;
//    self.separatorNode.frame = CGRectMake(CellPadding, size.height-1, size.width-CellPadding, 1/[UIScreen mainScreen].scale);
}

-(void)abilityImgNodeImgClick:(ASImageNode *)sender{
    LxDBAnyVar(sender);
    
    POPSpringAnimation *springAnima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    springAnima.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.2f, 1.2f)];
    springAnima.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    springAnima.springBounciness = 20;
    springAnima.removedOnCompletion = NO;
    [sender.layer pop_addAnimation:springAnima forKey:@"springScale"];
    
    POPBasicAnimation *alphaAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    alphaAnima.fromValue = @1;
    alphaAnima.toValue = @0;
    alphaAnima.duration = 0.12f;
    alphaAnima.removedOnCompletion = NO;
    alphaAnima.autoreverses = YES;
    [self.descriptionNode.layer pop_addAnimation:alphaAnima forKey:@"alphaAni"];
    
    NSInteger index = [self.imageNodeArray indexOfObject:sender];
    LxDBAnyVar(index);
    self.descriptionNode.attributedText = self.attributeArray[index];
    [self setNeedsLayout];
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    NSMutableArray *ratioImageNode = [NSMutableArray arrayWithCapacity:5];
    for (int i=0; i<5; i++) {
        ASRatioLayoutSpec *ratioSpec = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:1 child:self.imageNodeArray[i]];
        [ratioImageNode addObject:ratioSpec];
    }
    ASStackLayoutSpec *horizenAroundSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsCenter children:ratioImageNode];
    horizenAroundSpec.style.flexGrow = YES;
    
    ASStackLayoutSpec *verticalSpec = [[ASStackLayoutSpec alloc]init];
    verticalSpec.spacing = CellPadding;
    verticalSpec.justifyContent = ASStackLayoutJustifyContentStart;
    verticalSpec.alignItems = ASStackLayoutAlignItemsStart;
    verticalSpec.direction = ASStackLayoutDirectionVertical;
    verticalSpec.children = @[horizenAroundSpec,self.descriptionNode];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(CellPadding, CellPadding, CellPadding, CellPadding) child:verticalSpec];
}

@end
