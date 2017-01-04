//
//  SHAPIManager.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/17.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^FailBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);
typedef void(^SuccessBlock)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject);
typedef void(^ProgressBlock)(NSProgress * _Nonnull progress);

@interface SHAPIManager : NSObject

+(SHAPIManager *)sharedManager;

-(void)getChampionWithParametor:(id)para progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
-(void)getChampionDetailWithParametor:(id)para progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
-(void)getChampionDetailSkinWithParametor:(id)para progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

@end
