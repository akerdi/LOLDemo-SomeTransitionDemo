//
//  SHImageGallaryVC.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/21.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHImageGallaryVC.h"

#import <GPUImage/GPUImage.h>
#import <PINRemoteImage/PINRemoteImage.h>


@interface SHImageGallaryVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) ASScrollNode *scrollNode;
@property (nonatomic, strong) NSDictionary *modelDiction;

@property (nonatomic, strong) GPUImagePicture *picture;

@end

@implementation SHImageGallaryVC

-(instancetype)initWithModel:(id)model{
    self.scrollNode = [[ASScrollNode alloc]init];
    if (self = [super initWithNode:self.scrollNode]) {
        self.modelDiction = model;//{@"champion_id":champion_id,@"skinid":skinid}
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollNode.view.delegate = self;
    
    
    [self fetchData];
    
}

-(void)fetchData{
    [[SHAPIManager sharedManager] getChampionDetailSkinWithParametor:self.modelDiction progress:^(NSProgress * _Nonnull progress) {
        LxDBAnyVar(progress.completedUnitCount/progress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LxDBAnyVar(responseObject);
        
        NSString *returnStr = responseObject[@"data"][0][@"return"];
        LxDBAnyVar(returnStr);
//        UIImageView *imgView = [[UIImageView alloc]init];
//        [imgView pin_setImageFromURL:[NSURL URLWithString:returnStr] completion:^(PINRemoteImageManagerResult * _Nonnull result) {
//            LxDBAnyVar(result.image);
//        }];
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LxDBAnyVar(error);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
