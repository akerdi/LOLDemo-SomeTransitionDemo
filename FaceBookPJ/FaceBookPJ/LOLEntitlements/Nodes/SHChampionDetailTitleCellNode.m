//
//  SHChampionDetailCellNode.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/18.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHChampionDetailTitleCellNode.h"

#import "SHChampionsModel.h"
#import "SHChampionsDetailModel.h"

@interface SHChampionDetailTitleCellNode ()

//@property (nonatomic, strong) ASImageNode *portImgNode;
//@property (nonatomic, strong) ASTextNode *textNode;
//@property (nonatomic, strong) ASDisplayNode *separatorNode;

@property (nonatomic, strong) SHChampionsModel *championsModel;
@property (nonatomic, strong) SHChampionsDetailModel *championsDetailModel;

@end

@implementation SHChampionDetailTitleCellNode

-(instancetype)initWithModel:(id)championsModel championsDetailModel:(id)championsDetailModel{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.championsModel = championsModel;
        self.championsDetailModel = championsDetailModel;
        
        self.shapeArray = [[NSMutableArray alloc]initWithCapacity:4];
        self.nodeArray = [[NSMutableArray alloc]initWithCapacity:4];
        self.labelArray = [[NSMutableArray alloc]initWithCapacity:4];
        for (int i=0; i<4; i++) {
            UIColor *ramdomColor = [UIColor randomFlatColor];
            ASTextNode *textNode = [[ASTextNode alloc]init];
            textNode.layerBacked = YES;
            textNode.attributedText = [[NSAttributedString alloc]initWithString:@[@"攻击",@"防御",@"难度",@"法术"][i] attributes:@{NSForegroundColorAttributeName:ramdomColor,NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            [self addSubnode:textNode];
            [self.labelArray addObject:textNode];
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.lineWidth = 4;
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(100, 0)];
            layer.path = path.CGPath;
            layer.fillColor = nil;
            layer.strokeColor = ramdomColor.CGColor;
            layer.lineCap = kCALineCapRound;
            layer.lineJoin = kCALineJoinRound;
            layer.strokeEnd = 0;
            ASDisplayNode *node = [[ASDisplayNode alloc]init];
            node.style.preferredSize = CGSizeMake(100, textNode.calculatedSize.height);
            node.layerBacked = YES;
            node.style.flexGrow = YES;
            [self addSubnode:node];
            [self.nodeArray addObject:node];
            [self.shapeArray addObject:layer];
        }
    }
    return self;
}

-(void)displayWillStart{
    [super displayWillStart];
}

-(void)didLoad{
    [super didLoad];
    [self.nodeArray enumerateObjectsUsingBlock:^(ASTextNode*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.layer addSublayer:self.shapeArray[idx]];
    }];
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    //self.portImgNode.style.preferredSize = CGSizeMake(80, 80);
//    self.textNode.style.preferredSize = CGSizeMake(constrainedSize.max.width-2*CellPadding-80-CellPadding, 20);
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:self.nodeArray.count];
    
    [self.labelArray enumerateObjectsUsingBlock:^(ASTextNode*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ASStackLayoutSpec *horizenSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:CellPadding justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[obj,self.nodeArray[idx]]];
        [arr addObject:horizenSpec];
    }];
    
    ASStackLayoutSpec *verticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:4 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:arr];
//    verticalSpec.style.flexGrow = 1;
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 8, 8, 8) child:verticalSpec];
}


@end
