//
//  SHTransition.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/25.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SHTransitionType_Push,
    SHTransitionType_Pop,
} SHTransitionType;

@interface SHTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval transitionTime;

+(instancetype)transitionWithTransitionType:(SHTransitionType)type;
-(instancetype)initWithTransitionType:(SHTransitionType)type;


@end
