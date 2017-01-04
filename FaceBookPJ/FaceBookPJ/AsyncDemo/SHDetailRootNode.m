//
//  SHDetailRootNode.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHDetailRootNode.h"
#import "SHDetailCellNode.h"

#import "UIView+SHFindViewController.h"

static const NSInteger kImageHeight = 200;

@interface SHDetailRootNode ()<ASCollectionDataSource,ASCollectionDelegate>

@property (nonatomic, copy) NSString *imageCategory;
@property (nonatomic, strong) ASCollectionNode *collectionNode;
@property (nonatomic, strong) ASButtonNode *button;

@end

@implementation SHDetailRootNode

-(instancetype)initWithImageCategory:(NSString *)imageCategory{
    if (self = [super init]) {
        
        self.automaticallyManagesSubnodes = YES;
        
        _imageCategory = imageCategory;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionNode = [[ASCollectionNode alloc]initWithCollectionViewLayout:layout];
        _collectionNode.delegate = self;
        _collectionNode.dataSource = self;
        _collectionNode.backgroundColor = [UIColor whiteColor];
        
        ASButtonNode *button = [[ASButtonNode alloc]init];
        [self addSubnode:button];
        button.backgroundColor = FlatPink;
        [button addTarget:self action:@selector(gogogo) forControlEvents:ASControlNodeEventTouchUpInside];
        self.button = button;
        
    }
    return self;
}

-(void)dealloc{
    _collectionNode.delegate = nil;
    _collectionNode.dataSource = nil;
}
-(void)gogogo{
    if (self.view.viewController.navigationController) {
        [self.view.viewController.navigationController popViewControllerAnimated:YES];
    }else{
        [self.view.viewController dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

#pragma mark -ASDisplayNode

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    ASCenterLayoutSpec *centerSpec = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionDefault child:self.button];
    self.button.style.preferredSize = CGSizeMake(100, 100);
    self.button.style.layoutPosition = CGPointMake(100, 150);
    ASOverlayLayoutSpec *overLayoutSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:self.collectionNode overlay:centerSpec];
    return [ASWrapperLayoutSpec wrapperWithLayoutElement:overLayoutSpec];
}

-(NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSString *imageCategory = self.imageCategory;
    return  ^{
        SHDetailCellNode *node = [[SHDetailCellNode alloc]init];
        node.row = indexPath.row;
        node.imageCategory = imageCategory;
        return node;
    };
}

-(ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize imageSize = CGSizeMake(CGRectGetWidth(collectionNode.view.frame), kImageHeight);
    return ASSizeRangeMake(imageSize);
}

@end
