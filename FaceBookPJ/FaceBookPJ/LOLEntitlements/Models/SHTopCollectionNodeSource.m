//
//  SHTopCollectionNodeSource.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHTopCollectionNodeSource.h"

@implementation SHTopCollectionNodeSource

-(NSInteger)numberOfSectionsInCollectionView:(ASCollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section{
    return 6;
}
-(ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ^{
        ASTextCellNode *textNode = [[ASTextCellNode alloc]init];
        textNode.text = @"111111";
        return textNode;
    };
}

@end
