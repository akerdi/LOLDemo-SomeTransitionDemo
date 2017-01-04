
//
//  SHLOLAllHeroViewC.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHLOLAllHeroViewC.h"
#import "SHChampionDetailVC.h"

#import "SHChampionCellNodel.h"

#import "AFNetworking.h"
#import <MJExtension/MJExtension.h>
#import "FBShimmeringView.h"
//#import <TLYShyNavBar/TLYShyNavBar.h>

#import "SHTopCollectionNodeSource.h"
#import "SHChampionsModel.h"
#import "SHTransition.h"

@interface SHLOLAllHeroViewC ()<ASCollectionDelegate,ASCollectionDataSource,UINavigationControllerDelegate>{
    BOOL _canTap;
}
@property (nonatomic, strong) ASDisplayNode *viewNode;

@property (nonatomic, strong) ASCollectionNode *topCollectionNode;
@property (nonatomic, strong) ASCollectionNode *bottomCollectionNode;
@property (nonatomic, strong) ASCollectionNode *targetTransitionNode;
@property (nonatomic, strong) NSIndexPath *targetTransitionIndexPath;

@property (nonatomic, strong) NSMutableArray <SHChampionsModel *>*championsArray;

@end

@implementation SHLOLAllHeroViewC

-(instancetype)init{
    self.viewNode = [[ASDisplayNode alloc]init];
    if (self = [super initWithNode:self.viewNode]) {
        self.championsArray = [[NSMutableArray alloc]init];
        _canTap = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"英雄联盟";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *topFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    topFlowLayout.itemSize = CGSizeMake(80, 44);
    topFlowLayout.minimumLineSpacing = 0;
    topFlowLayout.minimumInteritemSpacing = 0;
    topFlowLayout.sectionInset = UIEdgeInsetsZero;
    topFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.topCollectionNode = [[ASCollectionNode alloc]initWithCollectionViewLayout:topFlowLayout];
    self.topCollectionNode.delegate = self;
    self.topCollectionNode.dataSource = self;
    self.topCollectionNode.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, 80*6, 44) andColors:@[[UIColor randomFlatColor],[UIColor randomFlatColor]]];
    self.topCollectionNode.view.showsHorizontalScrollIndicator = NO;
    [self.view addSubnode:self.topCollectionNode];
    self.topCollectionNode.style.preferredSize = CGSizeMake(self.view.width, 44);
    
    CGFloat gridWidth = self.view.width/3-1;
    
    UICollectionViewFlowLayout *bottomFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    bottomFlowLayout.itemSize = CGSizeMake(gridWidth, gridWidth+25);
    bottomFlowLayout.minimumLineSpacing = 0;
    bottomFlowLayout.minimumInteritemSpacing = 0;
    bottomFlowLayout.sectionInset = UIEdgeInsetsZero;
    self.bottomCollectionNode = [[ASCollectionNode alloc]initWithCollectionViewLayout:bottomFlowLayout];
    self.bottomCollectionNode.backgroundColor = [UIColor flatGrayColor];
    self.bottomCollectionNode.delegate = self;
    self.bottomCollectionNode.dataSource = self;
    [self.view addSubnode:self.bottomCollectionNode];
    self.bottomCollectionNode.style.flexGrow = 1;
    
    self.targetTransitionNode = self.bottomCollectionNode;
    
    @weakify(self);
    self.node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
        @strongify(self);
//        self.topCollectionNode.style.layoutPosition = CGPointZero;
        return [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[self.topCollectionNode,self.bottomCollectionNode]];
    };
    
//    self.shyNavBarManager.scrollView = self.bottomCollectionNode.view;
    [self fetchData];
}

-(void)fetchData{
    @weakify(self);
    [[SHAPIManager sharedManager] getChampionWithParametor:nil progress:^(NSProgress * _Nonnull progress) {
        LxDBAnyVar(1111);
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        @strongify(self);
        [responseObject[@"data"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SHChampionsModel *model = [SHChampionsModel mj_objectWithKeyValues:obj];
            [self.championsArray addObject:model];
        }];
        [self.bottomCollectionNode reloadData];
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LxDBAnyVar(error);
    }];
}

-(NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section{
    if (collectionNode==self.topCollectionNode) {
        return 6;
    }
    return self.championsArray.count;
}
-(void)collectionNode:(ASCollectionNode *)collectionNode willDisplayItemWithNode:(SHChampionCellNodel *)node{
    
}

-(ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionNode==self.topCollectionNode) {
        return ^{
            
            //        ASTextNode *text = [[ASTextNode alloc]init];
            //        text.attributedText = [[NSAttributedString alloc]initWithString:@"13959095496sdfsadfsfa" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
            
            ASTextCellNode *textNode = [[ASTextCellNode alloc]init];
            textNode.text = @[@"全部",@"法师",@"近战",@"远战",@"肉坦",@"突进"][indexPath.row];
            return textNode;
        };
    }
    SHChampionsModel *model = self.championsArray[indexPath.row];
    return ^{
        SHChampionCellNodel *textCellNode = [[SHChampionCellNodel alloc]initWithModel:model];
        return textCellNode;
    };
}

-(void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionNode==self.topCollectionNode) {
        return;
    }
    self.targetTransitionIndexPath = indexPath;
    if (_canTap) {
        _canTap = NO;
        SHChampionCellNodel *node = [collectionNode nodeForItemAtIndexPath:indexPath];
        POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
        anima.toValue = @(2*M_PI);
        anima.springBounciness = 18;
        anima.removedOnCompletion = NO;
        [anima setCompletionBlock:^(POPAnimation *animate, BOOL success) {
            if (success) {
                _canTap = YES;
                node.shimmeringLayer.shimmering = NO;
                SHChampionsModel *model = self.championsArray[indexPath.row];
                SHChampionDetailVC *vc = [[SHChampionDetailVC alloc]initWithChampionModel:model];
                self.navigationController.delegate = vc;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        
        [node.layer pop_addAnimation:anima forKey:@"popAnima"];
        node.shimmeringLayer.shimmering = YES;
    }
    
    /*
   
    SHChampionCellNodel *node = [collectionNode nodeForItemAtIndexPath:indexPath];
//    [node.layer pop_addAnimation:anima forKey:@"popAnima"];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    [node.layer addSublayer:layer];
    
    
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 80, 80) cornerRadius:200];
    layer.path = bpath.CGPath;
    [bpath moveToPoint:CGPointZero];
    layer.strokeEnd = 0;
    layer.fillColor = nil;
    POPSpringAnimation *decayAnima = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    decayAnima.toValue = @0.3;
    decayAnima.springBounciness = 20;
    [layer pop_addAnimation:decayAnima forKey:@"decay"];
    */
}
@end
