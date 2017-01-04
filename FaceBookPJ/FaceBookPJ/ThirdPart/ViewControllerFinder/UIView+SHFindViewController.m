//
//  UIView+SHFindViewController.m
//  Code beta2
//
//  Created by MyCompany on 15/12/25.
//  Copyright © 2015年 王思峒. All rights reserved.
//

#import "UIView+SHFindViewController.h"

@implementation UIView (SHFindViewController)

-(UIViewController *)viewController{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
