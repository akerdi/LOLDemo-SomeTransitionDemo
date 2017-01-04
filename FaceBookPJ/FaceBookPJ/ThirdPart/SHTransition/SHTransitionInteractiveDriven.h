//
//  SHTransitionInteractiveDriven.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/26.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XWInteractiveTransitionGestureDirection) {//手势的方向
    XWInteractiveTransitionGestureDirectionLeft = 0,
    XWInteractiveTransitionGestureDirectionRight,
    XWInteractiveTransitionGestureDirectionUp,
    XWInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, XWInteractiveTransitionType) {//手势控制哪种转场
    XWInteractiveTransitionTypePresent = 0,
    XWInteractiveTransitionTypeDismiss,
    XWInteractiveTransitionTypePush,
    XWInteractiveTransitionTypePop,
};

@interface SHTransitionInteractiveDriven : UIPercentDrivenInteractiveTransition
/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;
//初始化方法

+ (instancetype)interactiveTransitionWithTransitionType:(XWInteractiveTransitionType)type GestureDirection:(XWInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(XWInteractiveTransitionType)type GestureDirection:(XWInteractiveTransitionGestureDirection)direction;

/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(ASViewController *)viewController;

@end
