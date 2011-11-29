//
//  LLAssetURL.h
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLAssetDatabase.h"

@class LLAsset;

@interface LLAssetURL : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) LLAsset *asset;


+(NSArray *)LLAssetURLArrayWithALAssetURLDictionary:(NSDictionary *)assetURLs managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(LLAssetURL *)LLAssetURLWithALAssetURL:(NSString *)assetURL type:(NSString *)URLType managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(BOOL)doesALAssetURLExist:(NSString *)assetURL managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(LLAssetURL *)LLAssetURLForALAssetURL:(NSString *)assetURL managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
