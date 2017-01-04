//
//  SHNavigationViewC.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/25.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHNavigationViewC.h"

#import "SHTransition.h"

@class SHLOLAllHeroViewC;
#import "SHChampionDetailVC.h"

@interface SHNavigationViewC ()

@end

@implementation SHNavigationViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
    if ([animationController isKindOfClass:[SHChampionDetailVC class]]){
        SHChampionDetailVC *vc = (SHChampionDetailVC *)animationController;
        return vc.percentDrivenTransition;
    }else{
        return nil;
    }
}

@end
