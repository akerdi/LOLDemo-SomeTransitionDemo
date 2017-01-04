//
//  SHPushingAnimator.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/14.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHPushingAnimator.h"

@implementation SHPushingAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 这里拿到即将新推出的VC的View
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    // 这里设置退出view具体如何设置
    toView.frame = CGRectMake(0,0, KScreenSize.width, KScreenSize.height);
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
    
    [transitionContext.containerView addSubview:toView];
    // pop动画
    POPSpringAnimation *positionAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnim.toValue = @(transitionContext.containerView.center.y);
    positionAnim.springBounciness = 10;
    [positionAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.springBounciness = 20;
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    [toView.layer pop_addAnimation:positionAnim forKey:@"positionAnimation"];
    [toView.layer pop_addAnimation:scaleAnim forKey:@"scaleAnimation"];
}

@end
