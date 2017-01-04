//
//  SHCatViiewController.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHCatViiewController.h"
#import "SHItemNode.h"
#import "SHBlurbNode.h"
#import "SHLoadingNode.h"
#import "SHItemViewModel.h"

static const NSTimeInterval kWebResponseDelay = 1.0;
static const BOOL kSimulateWebResponse = YES;
static const NSInteger kBatchSize = 20;

static const CGFloat kHorizontalSectionPadding = 10.0f;
static const CGFloat kVerticalSectionPadding = 20.0f;

@interface SHCatViiewController () <ASCollectionDataSource, ASCollectionDelegate, ASCollectionViewDelegateFlowLayout>
{
    ASCollectionNode *_collectionNode;
    NSMutableArray *_data;
}

@end

@implementation SHCatViiewController
#pragma mark -
#pragma mark UIViewController.

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionNode = [[ASCollectionNode alloc] initWithCollectionViewLayout:layout];
    
    self = [super initWithNode:_collectionNode];
    
    if (self) {
        
        self.title = @"Cat Deals";
        
        _collectionNode.dataSource = self;
        _collectionNode.delegate = self;
        _collectionNode.backgroundColor = [UIColor grayColor];
        
        ASRangeTuningParameters preloadTuning;
        preloadTuning.leadingBufferScreenfuls = 2;
        preloadTuning.trailingBufferScreenfuls = 1;
        [_collectionNode setTuningParameters:preloadTuning forRangeType:ASLayoutRangeTypePreload];
        
        ASRangeTuningParameters displayTuning;
        displayTuning.leadingBufferScreenfuls = 1;
        displayTuning.trailingBufferScreenfuls = 0.5;
        [_collectionNode setTuningParameters:displayTuning forRangeType:ASLayoutRangeTypeDisplay];
        
        [_collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
        [_collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionFooter];
        
        _data = [[NSMutableArray alloc] init];
        
        self.navigationItem.leftItemsSupplementBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTapped)];  }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set any collectionView properties here (once the node's backing view is loaded)
    _collectionNode.view.leadingScreensForBatching = 2;
    [self fetchMoreCatsWithCompletion:nil];
}
- (void)fetchMoreCatsWithCompletion:(void (^)(BOOL))completion {
    if (kSimulateWebResponse) {
        __weak typeof(self) weakSelf = self;
        void(^mockWebService)() = ^{
            NSLog(@"ViewController \"got data from a web service\"");
            SHCatViiewController *strongSelf = weakSelf;
            if (strongSelf != nil)
            {
                NSLog(@"ViewController is not nil");
                [strongSelf appendMoreItems:kBatchSize completion:completion];
                NSLog(@"ViewController finished updating collectionView");
            }
            else {
                NSLog(@"ViewController is nil - won't update collectionView");
            }
        };
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kWebResponseDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), mockWebService);
    } else {
        [self appendMoreItems:kBatchSize completion:completion];
    }
}

- (void)appendMoreItems:(NSInteger)numberOfNewItems completion:(void (^)(BOOL))completion {
    NSArray *newData = [self getMoreData:numberOfNewItems];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionNode performBatchAnimated:YES updates:^{
            [_data addObjectsFromArray:newData];
            NSArray *addedIndexPaths = [self indexPathsForObjects:newData];
            [_collectionNode insertItemsAtIndexPaths:addedIndexPaths];
        } completion:completion];
    });
}

- (NSArray *)getMoreData:(NSInteger)count {
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [data addObject:[SHItemViewModel randomItem]];
    }
    return data;
}
- (NSArray *)indexPathsForObjects:(NSArray *)data {
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSInteger section = 0;
    for (SHItemViewModel *viewModel in data) {
        NSInteger item = [_data indexOfObject:viewModel];
        NSAssert(item < [_data count] && item != NSNotFound, @"Item should be in _data");
        [indexPaths addObject:[NSIndexPath indexPathForItem:item inSection:section]];
    }
    return indexPaths;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [_collectionNode.view.collectionViewLayout invalidateLayout];
}
- (void)reloadTapped
{
    [_collectionNode reloadData];
}
#pragma mark - ASCollectionNodeDelegate / ASCollectionNodeDataSource

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHItemViewModel *viewModel = _data[indexPath.item];
    return ^{
        return [[SHItemNode alloc] initWithViewModel:viewModel];
    };
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 0) {
        return [[SHBlurbNode alloc] init];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && indexPath.section == 0) {
        return [[SHLoadingNode alloc] init];
    }
    return nil;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat collectionViewWidth = CGRectGetWidth(self.view.frame) - 2 * kHorizontalSectionPadding;
    CGFloat oneItemWidth = [SHItemNode preferredViewSize].width;
    NSInteger numColumns = floor(collectionViewWidth / oneItemWidth);
    // Number of columns should be at least 1
    numColumns = MAX(1, numColumns);
    
    CGFloat totalSpaceBetweenColumns = (numColumns - 1) * kHorizontalSectionPadding;
    CGFloat itemWidth = ((collectionViewWidth - totalSpaceBetweenColumns) / numColumns);
    CGSize itemSize = [SHItemNode sizeForWidth:itemWidth];
    return ASSizeRangeMake(itemSize, itemSize);
//    SHItemNode *itemNode = [collectionNode nodeForItemAtIndexPath:indexPath];
//    return ASSizeRangeMake([itemNode layoutThatFits:ASSizeRangeMake(CGSizeZero,self.view.frame.size)].size);
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section
{
    return [_data count];
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode
{
    return 1;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willBeginBatchFetchWithContext:(ASBatchContext *)context
{
    NSLog(@"fetch additional content");
    [self fetchMoreCatsWithCompletion:^(BOOL finished){
        [context completeBatchFetching:YES];
    }];
}
#pragma mark - ASCollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kVerticalSectionPadding, kHorizontalSectionPadding, kVerticalSectionPadding, kHorizontalSectionPadding);
}

- (CGSize)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat width = CGRectGetWidth(self.view.frame) - 2 * kHorizontalSectionPadding;
        return CGSizeMake(width, [SHBlurbNode desiredHeightForWidth:width]);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat width = CGRectGetWidth(self.view.frame);
        return CGSizeMake(width, [SHLoadingNode desiredHeightForWidth:width]);
    }
    return CGSizeZero;
}






@end
