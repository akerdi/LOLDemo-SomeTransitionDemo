//
//  SHDismissingAnimator.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/14.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHDismissingAnimator.h"

@implementation SHDismissingAnimator

-(NSTimeInterval)
transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toVC.view.userInteractionEnabled = YES;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __block UIView *dimmingView;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.layer.opacity<1.f) {
            dimmingView = obj;
            *stop = YES;
        }
    }];
    
    
    POPBasicAnimation *opacityAnimation= [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @0;
    opacityAnimation.toValue = @1;
    
    POPBasicAnimation *offScreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    offScreenAnimation.toValue = @(-fromVC.view.layer.position.y);
    [offScreenAnimation setCompletionBlock:^(POPAnimation *anima, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    [fromVC.view.layer pop_addAnimation:offScreenAnimation forKey:@"offscreenAnimation"];
//    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
}
@end
