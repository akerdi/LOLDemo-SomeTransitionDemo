//
//  SHChampionDetailVC.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class SHChampionsModel;
@interface SHChampionDetailVC : ASViewController<UINavigationControllerDelegate>

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePan;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@property (nonatomic, assign) BOOL isPanInteractionTransition;

-(instancetype)initWithChampionModel:(SHChampionsModel *)model;

@end
