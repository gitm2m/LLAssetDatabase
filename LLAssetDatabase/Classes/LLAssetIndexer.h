//
//  LLAssetIndexer.h
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLAssetDatabase.h"

@class LLAsset, LLAssetGroup, LLAssetLocation, LLAssetURL;

@interface LLAssetIndexer : NSOperation

-(id)initWithAssetGroup:(ALAssetsGroup *)assetsGroup;
-(void)saveContext;

-(void)finish;

@property (nonatomic, retain) ALAssetsGroup *assetsGroup;
@property (nonatomic, retain) LLAssetGroup *llAssetsGroup;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly) BOOL isExecuting;
@property (readonly) BOOL isFinished;

@end
