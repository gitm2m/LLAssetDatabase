//
//  LLAssetDatabase.h
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

#import "ALAssetsLibrary+helper.h"
#import "LLAssetIndexer.h"

#import "LLAsset.h"
#import "LLAssetGroup.h"
#import "LLAssetLocation.h"
#import "LLAssetURL.h"


@interface LLAssetDatabase : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSOperationQueue *operationQueue;

- (void)saveContext;
-(void)index;

+(NSURL *)applicationDocumentsDirectory;
+(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
+(NSManagedObjectModel *)managedObjectModel;

@end
