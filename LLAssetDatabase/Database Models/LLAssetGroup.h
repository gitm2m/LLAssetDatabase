//
//  LLAssetGroup.h
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLAssetDatabase.h"

@class LLAsset;

@interface LLAssetGroup : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * persistentID;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet *assets;

+(LLAssetGroup *)LLAssetGroupWithALAssetsGroup:(ALAssetsGroup *)assetsGroup managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(BOOL)doesALAssetsGroupExist:(ALAssetsGroup *)assetsGroup managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(LLAssetGroup *)LLAssetsGroupForALAssetsGroup:(ALAssetsGroup *)assetsGroup managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

@interface LLAssetGroup (CoreDataGeneratedAccessors)

- (void)addAssetsObject:(LLAsset *)value;
- (void)removeAssetsObject:(LLAsset *)value;
- (void)addAssets:(NSSet *)values;
- (void)removeAssets:(NSSet *)values;

@end
