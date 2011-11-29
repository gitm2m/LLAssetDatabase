//
//  LLAsset.m
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import "LLAsset.h"

@implementation LLAsset

@dynamic date;
@dynamic orientation;
@dynamic duration;
@dynamic type;
@dynamic urls;
@dynamic group;
@dynamic location;

+(LLAsset *)LLAssetWithALAsset:(ALAsset *)asset managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	if ([LLAsset doesALAssetExist:asset managedObjectContext:managedObjectContext]) {
		LLAsset *ss = [LLAsset LLAssetForALAsset:asset managedObjectContext:managedObjectContext];

		return ss;
	}
	
	NSDate *date = [asset valueForProperty:ALAssetPropertyDate];
	NSNumber *duration = [asset valueForProperty:ALAssetPropertyDuration];
	NSNumber *orientation = [asset valueForProperty:ALAssetPropertyOrientation];
	NSDictionary *urls = [asset valueForProperty:ALAssetPropertyURLs];
	NSString *type = [asset valueForProperty:ALAssetPropertyType];
	CLLocation *location = [asset valueForProperty:ALAssetPropertyLocation];
	
	LLAsset *llasset = [NSEntityDescription insertNewObjectForEntityForName:@"LLAsset" inManagedObjectContext:managedObjectContext];
	LLAssetLocation *assetLocation = [LLAssetLocation LLAssetLocationWithCLLocation:location managedObjectContext:managedObjectContext];
	NSArray *assetURLS = [LLAssetURL LLAssetURLArrayWithALAssetURLDictionary:urls managedObjectContext:managedObjectContext];
	
	[llasset setDate:date];
	[llasset setType:type];
	[llasset setOrientation:orientation];
	
	if (![duration isEqual:ALErrorInvalidProperty]) {
		[llasset setDuration:duration];	
	}	
	
	[llasset setUrls:[NSSet setWithArray:assetURLS]];
	[llasset setLocation:assetLocation];

	return llasset;
}


+(BOOL)doesALAssetExist:(ALAsset *)asset managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	NSDictionary *urls = [asset valueForProperty:ALAssetPropertyURLs];
	for (NSString *key in [urls allKeys]) {
		NSString *URL =	[urls objectForKey:key];
		
		NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LLAssetURL"];
		[fetchRequest setFetchLimit:1];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@", URL];
		[fetchRequest setPredicate:predicate];
		
		NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES];
		[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		
		NSError *error;
		NSInteger count = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
		
		if (count == NSNotFound) {
			return YES;
		}
		else if (count) {
			return YES;
		}
	}
	
	return NO;
}

+(LLAsset *)LLAssetForALAsset:(ALAsset *)asset managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	NSDictionary *urls = [asset valueForProperty:ALAssetPropertyURLs];
	
	for (NSString *key in [urls allKeys]) {
		NSString *URL =	[urls objectForKey:key];
		
		NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LLAssetURL"];
		[fetchRequest setFetchLimit:1];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@", URL];
		[fetchRequest setPredicate:predicate];
		
		NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES];
		[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		
		NSError *error;
		NSArray *array = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
		
		if ([array count]) {
			LLAssetURL *llAssetURL = [array objectAtIndex:0];
			LLAsset *llasset = [llAssetURL asset];
			
			return llasset;
		}
	}

	return nil;
}

@end
