//
//  SHViewDemoController.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHViewDemoController.h"

#import "SHDetailViewController.h"
#import "SHDetailRootNode.h"

@interface SHViewDemoController ()<ASTableDataSource,ASTableDelegate,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
@property (nonatomic, copy) NSArray *imageCategories;
@property (nonatomic, strong, readonly) ASTableNode *tableNode;

@end

@implementation SHViewDemoController


#pragma mark -Lifecycle

-(instancetype)init{
    
    if (self = [super initWithNode:[ASTableNode new]]) {
        _imageCategories = @[@"abstract", @"animals", @"business", @"cats", @"city", @"food", @"nightlife", @"fashion", @"people", @"nature", @"sports", @"technics", @"transport"];
    }
    return self;
}

-(void)dealloc{
    self.node.delegate = nil;
    self.node.dataSource = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Image Categories";
    self.navigationController.delegate = self;
    self.node.delegate = self;
    self.node.dataSource = self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.node deselectRowAtIndexPath:self.node.indexPathForSelectedRow animated:YES];
}

#pragma mark -ASTableDataSource/ASTableDelegate

-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return self.imageCategories.count;
}
-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *imageCategory = self.imageCategories[indexPath.row];
    return ^{
        ASTextCellNode *textCellNode = [ASTextCellNode new];
        textCellNode.text = [imageCategory capitalizedString];
        return textCellNode;
    };
}
-(void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *imageCategory = self.imageCategories[indexPath.item];
    SHDetailRootNode *detailRootNode = [[SHDetailRootNode alloc]initWithImageCategory:imageCategory];
    SHDetailViewController *detailViewController = [[SHDetailViewController alloc]initWithNode:detailRootNode];
    detailViewController.title = [imageCategory capitalizedString];
    detailViewController.navigationController.delegate = self;
    
    detailViewController.transitioningDelegate = self;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    
//    [self presentViewController:detailViewController animated:YES completion:NULL];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [NSClassFromString(@"SHPresentingAnimator") new];
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [NSClassFromString(@"SHDismissingAnimator") new];
}
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation==UINavigationControllerOperationPush) {
        return [NSClassFromString(@"SHPresentingAnimator") new];
    }else if (operation==UINavigationControllerOperationNone){
        return nil;
    }else{
        return [NSClassFromString(@"SHDismissingAnimator") new];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
