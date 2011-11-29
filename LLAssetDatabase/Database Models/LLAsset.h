//
//  LLAsset.h
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLAssetDatabase.h"

@class LLAssetGroup, LLAssetLocation, LLAssetURL;

@interface LLAsset : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * orientation;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *urls;
@property (nonatomic, retain) LLAssetGroup *group;
@property (nonatomic, retain) LLAssetLocation *location;

+(LLAsset *)LLAssetWithALAsset:(ALAsset *)asset managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(BOOL)doesALAssetExist:(ALAsset *)asset managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(LLAsset *)LLAssetForALAsset:(ALAsset *)asset managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

@interface LLAsset (CoreDataGeneratedAccessors)

- (void)addUrlsObject:(LLAssetURL *)value;
- (void)removeUrlsObject:(LLAssetURL *)value;
- (void)addUrls:(NSSet *)values;
- (void)removeUrls:(NSSet *)values;



@end
