//
//  LLAssetLocation.h
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLAssetDatabase.h"

@class LLAsset;

@interface LLAssetLocation : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * altitude;
@property (nonatomic, retain) NSNumber * horizontalAccuracy;
@property (nonatomic, retain) NSNumber * verticalAccuracy;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * course;
@property (nonatomic, retain) LLAsset *asset;

+(LLAssetLocation *)LLAssetLocationWithCLLocation:(CLLocation *)location managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
