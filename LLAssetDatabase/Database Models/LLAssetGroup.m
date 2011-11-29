//
//  LLAssetGroup.m
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import "LLAssetGroup.h"
#import "LLAsset.h"


@implementation LLAssetGroup

@dynamic name;
@dynamic type;
@dynamic persistentID;
@dynamic url;
@dynamic assets;

+(LLAssetGroup *)LLAssetGroupWithALAssetsGroup:(ALAssetsGroup *)assetsGroup managedObjectContext:(NSManagedObjectContext *)managedObjectContext {

	if ([LLAssetGroup doesALAssetsGroupExist:assetsGroup managedObjectContext:managedObjectContext]) {
		return [LLAssetGroup LLAssetsGroupForALAssetsGroup:assetsGroup managedObjectContext:managedObjectContext];
	}
	
	NSString *name = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
	NSString *persistentID = [assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
	NSNumber *type = [assetsGroup valueForProperty:ALAssetsGroupPropertyType];
	NSString *URL = [[assetsGroup valueForProperty:ALAssetsGroupPropertyURL] absoluteString];
	
	
	LLAssetGroup *llAssetsGroup = [NSEntityDescription insertNewObjectForEntityForName:@"LLAssetGroup" inManagedObjectContext:managedObjectContext];
	[llAssetsGroup setName:name];
	[llAssetsGroup setPersistentID:persistentID];
	[llAssetsGroup setType:type];
	[llAssetsGroup setUrl:URL];
	
	return llAssetsGroup;
}

+(BOOL)doesALAssetsGroupExist:(ALAssetsGroup *)assetsGroup managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	NSString *persistentID = [assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LLAssetGroup"];
	[fetchRequest setFetchLimit:1];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"persistentID = %@", persistentID];
	[fetchRequest setPredicate:predicate];
	
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	
	NSError *error;
	NSUInteger count = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
	
	if (count == NSNotFound) {
		return YES;
	}
	else if (count) {
		return YES;
	}
	return NO;	
}

+(LLAssetGroup *)LLAssetsGroupForALAssetsGroup:(ALAssetsGroup *)assetsGroup managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	
	NSString *persistentID = [assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LLAssetGroup"];
	[fetchRequest setFetchLimit:1];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"persistentID = %@", persistentID];
	[fetchRequest setPredicate:predicate];
	
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];

	NSError *error;
	NSArray *array = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
	
	if ([array count]) {
		LLAssetGroup *llAssetsGroup = [array objectAtIndex:0];
		return llAssetsGroup;
	}
	
	return nil;
}

@end
