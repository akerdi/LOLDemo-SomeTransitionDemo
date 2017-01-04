//
//  SHAPIManager.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHAPIManager.h"

@implementation SHAPIManager

+(SHAPIManager *)sharedManager{
    static SHAPIManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SHAPIManager alloc]init];
    });
    return manager;
}

-(void)getChampionWithParametor:(id)para progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    [self fetchDataWithURL:@"http://lolapi.games-cube.com/champion" parametor:para  ProgressBlock:progressBlock SuccessBlock:successBlock FailBlock:failBlock];
}

-(void)getChampionDetailWithParametor:(id)para progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    [self fetchDataWithURL:@"http://lolapi.games-cube.com/GetChampionDetail" parametor:para  ProgressBlock:progressBlock SuccessBlock:successBlock FailBlock:failBlock];
}

-(void)getChampionDetailSkinWithParametor:(id)para progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    [self fetchDataWithURL:@"http://lolapi.games-cube.com/GetChampionSkin" parametor:para  ProgressBlock:progressBlock SuccessBlock:successBlock FailBlock:failBlock];
}


-(void)fetchDataWithURL:(NSString *)url parametor:(id)parametor ProgressBlock:(ProgressBlock)progress SuccessBlock:(SuccessBlock)successblock FailBlock:(FailBlock)failblock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:LOLToken forHTTPHeaderField:@"DAIWAN-API-TOKEN"];
    
    [manager GET:url parameters:parametor progress:^(NSProgress * _Nonnull downloadProgress) {
        LxDBAnyVar(downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LxDBAnyVar(responseObject);
        successblock(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LxDBAnyVar(error);
        failblock(task,error);
    }];
}



@end
