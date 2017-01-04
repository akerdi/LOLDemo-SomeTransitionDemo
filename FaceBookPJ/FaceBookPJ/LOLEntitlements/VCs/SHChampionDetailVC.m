//
//  SHChampionDetailVC.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHChampionDetailVC.h"
#import "SHImageGallaryVC.h"

#import "SHChampionsModel.h"
#import "SHChampionsDetailModel.h"

#import "SHChampionDetailTitleCellNode.h"
#import "SHAbilityCellNode.h"
#import "SHSkinsNode.h"
#import "SHTransition.h"
#import "SHTransitionInteractiveDriven.h"

#import <MJExtension/MJExtension.h>

@interface SHChampionDetailVC ()<ASTableDelegate,ASTableDataSource,UINavigationControllerDelegate>

@property (nonatomic, strong) ASDisplayNode *viewNode;
@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) ASTableNode *targetTransitionNode;//名字取为targetTransition(Node)View，那么转场动画就能识别对象为内容对象
@property (nonatomic, strong) NSIndexPath *targetTransitionIndexPath;//名字取为targetTransitionIndexPath，那么转场动画就能识别对象容器在相关IndexPath里面

@property (nonatomic, strong) SHChampionsModel *model;
@property (nonatomic, strong) SHChampionsDetailModel *detailModel;

@property (nonatomic, strong) GPUImageFilter *filter;

@end

@implementation SHChampionDetailVC

-(instancetype)initWithChampionModel:(SHChampionsModel *)model{
    self.viewNode = [[ASDisplayNode alloc]init];
    self.viewNode.backgroundColor = [UIColor whiteColor];
    if (self = [super initWithNode:self.viewNode]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.model.cname;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStyleGrouped];
    self.tableNode.delegate = self;
    self.tableNode.dataSource = self;
    [self.view addSubnode:self.tableNode];
//    self.tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableNode.style.flexGrow = 1;
    UIImage *headImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.model.pic ofType:nil]];
    GPUImagePicture *pic = nil;
    @weakify(self);
    if (headImage) {
        pic = [[GPUImagePicture alloc]initWithImage:headImage];
        self.filter = [[GPUImageZoomBlurFilter alloc]init];
        GPUImageView *profileImageView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)];
        [self.tableNode.view insertSubview:profileImageView atIndex:0];
        [pic addTarget:self.filter];
        [self.filter addTarget:profileImageView];
        [pic processImage];
        
        RAC(profileImageView,frame) = [RACObserve(self.tableNode.view, contentOffset) map:^id(NSValue* value) {
            @strongify(self);
            CGFloat tableViewY = [value CGPointValue].y;
            CGFloat per = self.view.width/self.view.height;
            CGRect rect = CGRectMake(0, tableViewY*per, self.view.width, self.view.width);
            return [NSValue valueWithCGRect:rect];
        }];
    }
    
    self.targetTransitionNode = self.tableNode;
    ASDisplayNode *tableHeaderView = [ASDisplayNode new];
    tableHeaderView.frame = CGRectMake(0, 0, self.view.width, 200);
    tableHeaderView.backgroundColor = [UIColor clearColor];
    [self.tableNode.view setTableHeaderView:tableHeaderView.view];
    
    ASDisplayNode *sliderNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        slider.value = 0.f;
        [[slider rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISlider* x) {
            @strongify(self);
            CGFloat value = x.value;
            GPUImageZoomBlurFilter *filter = (GPUImageZoomBlurFilter *)self.filter;
            filter.blurSize = value;
            [filter useNextFrameForImageCapture];
            [pic processImage];
        }];
        slider.maximumValue = 1.f;
        slider.value = 1.f;
        return slider;
    }];
    sliderNode.style.preferredSize = CGSizeMake(150, 50);
    [tableHeaderView addSubnode:sliderNode];
    
    ASImageNode *headImageNode = [[ASImageNode alloc]init];
    headImageNode.image = headImage;
    headImageNode.layerBacked = YES;
    [tableHeaderView addSubnode:headImageNode];
    
    ASTextNode *headImageText = [[ASTextNode alloc]init];
    headImageText.layerBacked = YES;
    headImageText.attributedText = [SHAttributeTool championDetailTitleWith:self.title];
    [tableHeaderView addSubnode:headImageText];
    headImageText.style.spacingAfter = 8;
    tableHeaderView.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *node,ASSizeRange constranedSize){
        ASStackLayoutSpec *layoutSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:CellPadding justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsCenter children:@[sliderNode,headImageNode,headImageText]];
        return layoutSpec;
    };
    
    self.node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
        @strongify(self);
        return [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[self.tableNode]];
    };
    
    
    self.edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
    self.edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.edgePan];
    
    [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"宇宙无敌超级好玩英雄:%@",self.title] type:TSMessageNotificationTypeMessage];
    [self fetchData];
}

-(void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan{
    CGFloat progress = [edgePan translationInView:self.view].x/self.node.calculatedSize.width;
    progress = MIN(1.f, MAX(0.f, progress));
    if (edgePan.state==UIGestureRecognizerStateBegan) {
        self.isPanInteractionTransition = YES;
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (edgePan.state==UIGestureRecognizerStateChanged){
        LxDBAnyVar(progress);
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (edgePan.state==UIGestureRecognizerStateCancelled||edgePan.state==UIGestureRecognizerStateEnded){
        if (progress>0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
        self.isPanInteractionTransition = NO;
    }
}

-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    /*
     info =             {
     attack = 8;
     defense = 6;
     difficulty = 3;
     magic = 3;
     };
     头像 name title
     头像 attack
     头像 defense
     头像 magic
     头像 difficulty
     
     image          spells:Q:image{full}       W:image{full}        E:image{full}       R:image{full}
     passive                 name
     description             tooltip
     
     
     
     
     
     */
    return self.detailModel?2+self.detailModel.skins.count:0;
}

-(void)tableNode:(ASTableNode *)tableNode willDisplayRowWithNode:(SHChampionDetailTitleCellNode *)node{
    if (self.detailModel&&node.indexPath.row==0) {
        [node.nodeArray enumerateObjectsUsingBlock:^(ASDisplayNode*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *num = [self.detailModel.info valueForKeyPath:@[@"attack",@"defense",@"difficulty",@"magic"][idx]];
            CGFloat per = num.integerValue*1.0/10;
            POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
            springAnimation.springBounciness = 20;
            springAnimation.fromValue = @0;
            springAnimation.toValue = @(per);
            springAnimation.removedOnCompletion = NO;
            [obj.layer.sublayers[0] pop_addAnimation:springAnimation forKey:@"springPOP"];
        }];
    }
}

-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return ^{
            SHChampionDetailTitleCellNode *node = [[SHChampionDetailTitleCellNode alloc]initWithModel:self.model championsDetailModel:self.detailModel];
            return node;
        };
    }else if (indexPath.row==1){
        return ^{
            SHAbilityCellNode *node = [[SHAbilityCellNode alloc]initWithMode:self.detailModel];
            return node;
        };
    }else{
        SHChampionsDetailSkins *skinModel = self.detailModel.skins[indexPath.row-2];
        return ^{
            SHSkinsNode *node = [[SHSkinsNode alloc]initWithModel:skinModel];
            return node;
        };
    }
}

-(void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
    self.targetTransitionIndexPath = indexPath;
    if (indexPath.row>1) {
        SHChampionsDetailSkins *skinModel = self.detailModel.skins[indexPath.row-2];
        LxDBAnyVar(skinModel);
        LxDBAnyVar(@"点击进去，可以查看大图，操作大图，保存大图");
        SHImageGallaryVC *vc = [[SHImageGallaryVC alloc]initWithModel:@{@"champion_id":self.model.id,@"skinid":skinModel.id}];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)fetchData{
    [[SHAPIManager sharedManager] getChampionDetailWithParametor:@{@"champion_id":self.model.id} progress:^(NSProgress * _Nonnull progress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         self.detailModel = [SHChampionsDetailModel mj_objectWithKeyValues:responseObject[@"data"][0]];
         [self.tableNode reloadData];
        LxDBAnyVar(responseObject);
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LxDBAnyVar(error);
    }];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    if (operation==UINavigationControllerOperationPush){
        if ([toVC isKindOfClass:NSClassFromString(@"SHChampionDetailVC")]){
            return [SHTransition transitionWithTransitionType:SHTransitionType_Push];
        }
    }else{
        if ([toVC isKindOfClass:NSClassFromString(@"SHLOLAllHeroViewC")]) {
            return [SHTransition transitionWithTransitionType:SHTransitionType_Pop];
        }
    }
    return nil;
}
//-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        if ([navigationController.viewControllers count]==1) {
//            navigationController.interactivePopGestureRecognizer.enabled = NO;
//        }else{
//            navigationController.interactivePopGestureRecognizer.enabled = YES;
//        }
//    }
//}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0){
    if ([animationController isKindOfClass:[SHTransition class]]){
        return self.percentDrivenTransition;
    }else{
        return nil;
    }
}
@end
