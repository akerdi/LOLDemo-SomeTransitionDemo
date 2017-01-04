//
//  SHTransition.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/25.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHTransition.h"

@interface SHTransition()

@property (nonatomic, assign) SHTransitionType type;

@end

@implementation SHTransition

+(instancetype)transitionWithTransitionType:(SHTransitionType)type{
    return [[self alloc]initWithTransitionType:type];
}
-(instancetype)initWithTransitionType:(SHTransitionType)type{
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.transitionTime<=0.f) {
        return 0.45;
    }
    return self.transitionTime;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (self.type) {
        case SHTransitionType_Push:
            [self pushTransitionWithContext:transitionContext];
            break;
            
        default:
            [self popTransitionWithContext:transitionContext];
            break;
    }
}

-(void)pushTransitionWithContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    id fromvc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([fromvc isKindOfClass:[ASViewController class]]) {
        ASViewController *tableVC = (ASViewController *)fromvc;
        ASCollectionNode *collectionNode = [tableVC valueForKeyPath:@"targetTransitionNode"];
        NSIndexPath *indexPath = [tableVC valueForKeyPath:@"targetTransitionIndexPath"];
        ASCellNode *cell = [collectionNode nodeForItemAtIndexPath:indexPath];
        __block ASImageNode *imageNode = nil;
        imageNode = [cell valueForKeyPath:@"imageNode"];
        
        ASViewController *toTableVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIView *containerView = [transitionContext containerView];
        UIImageView *tempView = [UIImageView new];
        tempView.frame = imageNode.frame;
        tempView.image = imageNode.image;
//        将拿到的图片转换成对应坐标
        tempView.frame = [imageNode.view convertRect:imageNode.frame toView:containerView];
        toTableVC.node.view.alpha = 0;
        toTableVC.node.alpha = 0;
        
        [containerView addSubview:toTableVC.node.view];
        [containerView addSubview:tempView];
//        tempView的坐标变换
        POPSpringAnimation *positionAnimate = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        positionAnimate.springBounciness = 8;
        positionAnimate.fromValue = [NSValue valueWithCGRect:tempView.frame];
        positionAnimate.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, toTableVC.node.calculatedSize.width, toTableVC.node.calculatedSize.width)];
        [tempView pop_addAnimation:positionAnimate forKey:@"viewFrameAniamte"];
        [positionAnimate setCompletionBlock:^(POPAnimation *animate, BOOL complete) {
            if (complete) {
                tempView.alpha = 0;
//                一定要记得写，不然动画结束，屏幕不能按
                [transitionContext completeTransition:YES];
            }
        }];
        //toTableVC的试图从alpha0-》alpha1
        POPBasicAnimation *basicAnimate = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        basicAnimate.fromValue = @0;
        basicAnimate.toValue = @1;
        basicAnimate.duration = 0.4;
        [toTableVC.node.layer pop_addAnimation:basicAnimate forKey:@"layerOpacityAnima"];
        
    }else{//UIViewController class
        UIViewController *tableVC = (UIViewController *)fromvc;
        UICollectionView *collectionNode = [tableVC valueForKeyPath:@"targetTransitionView"];
    }
    
}
-(void)popTransitionWithContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    ASViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ASViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ASCollectionNode *collectionNode = [toVC valueForKeyPath:@"targetTransitionNode"];
    ASCellNode *cellNode = [collectionNode nodeForItemAtIndexPath:[toVC valueForKeyPath:@"targetTransitionIndexPath"]];
    
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    
    [containerView insertSubview:toVC.view atIndex:0];
    //fromVC的从看得见变成看不见过渡
    POPBasicAnimation *alphaAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    alphaAnima.toValue = @0;
    alphaAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    alphaAnima.duration = 0.35;
    [fromVC.node.layer pop_addAnimation:alphaAnima forKey:@"viewNodeLayerAlphaAnimate"];
    //tempView 动画
    POPSpringAnimation *positionAinma = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    positionAinma.fromValue = [NSValue valueWithCGRect:tempView.frame];
    ASImageNode *imageNode = [cellNode valueForKeyPath:@"imageNode"];
    positionAinma.toValue = [NSValue valueWithCGRect:[imageNode.view convertRect:imageNode.bounds toView:containerView]];
    [tempView pop_addAnimation:positionAinma forKey:@"positionAnimate"];
    [positionAinma setCompletionBlock:^(POPAnimation *animate, BOOL complete) {
        if (complete) {
            [transitionContext completeTransition:YES];
        }
    }];
    
    POPBasicAnimation *tempViewAlphaAnimate = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    tempViewAlphaAnimate.fromValue = @0;
    tempViewAlphaAnimate.toValue = @1;
    tempViewAlphaAnimate.autoreverses = YES;
    [tempView.layer pop_addAnimation:tempViewAlphaAnimate forKey:@"tempViewAlphaAnimate"];
}


@end
