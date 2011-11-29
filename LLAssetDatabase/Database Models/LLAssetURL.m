//
//  LLAssetURL.m
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import "LLAssetURL.h"
#import "LLAsset.h"


@implementation LLAssetURL

@dynamic type;
@dynamic url;
@dynamic asset;

+(NSArray *)LLAssetURLArrayWithALAssetURLDictionary:(NSDictionary *)assetURLs managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
	for (NSString *key in [assetURLs allKeys]) {
		NSString *URL = [[assetURLs objectForKey:key] absoluteString];
		
		LLAssetURL *assetURL = [LLAssetURL LLAssetURLWithALAssetURL:URL type:key managedObjectContext:managedObjectContext];
		[array addObject:assetURL];
	}
	return array;
}

+(LLAssetURL *)LLAssetURLWithALAssetURL:(NSString *)assetURL type:(NSString *)URLType managedObjectContext:(NSManagedObjectContext *)managedObjectContext {

	if ([LLAssetURL doesALAssetURLExist:assetURL managedObjectContext:managedObjectContext]) {
		return [LLAssetURL LLAssetURLForALAssetURL:assetURL managedObjectContext:managedObjectContext];
	}
	
	LLAssetURL *llAssetURL = [NSEntityDescription insertNewObjectForEntityForName:@"LLAssetURL" inManagedObjectContext:managedObjectContext];
	[llAssetURL setType:URLType];
	[llAssetURL setUrl:assetURL];
	
	return llAssetURL;
}

+(BOOL)doesALAssetURLExist:(NSString *)assetURL managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LLAssetURL"];
	[fetchRequest setFetchLimit:1];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", assetURL];
	[fetchRequest setPredicate:predicate];
	
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"url" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	
	NSError *error;
	NSUInteger count =  [managedObjectContext countForFetchRequest:fetchRequest error:&error];
	
	if (count == NSNotFound) {
		return YES;
	}
	else if (count) {
		return YES;
	}
	return NO;
}

+(LLAssetURL *)LLAssetURLForALAssetURL:(NSString *)assetURL managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LLAssetURL"];
	[fetchRequest setFetchLimit:1];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", assetURL];
	[fetchRequest setPredicate:predicate];
	
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"url" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	
	NSError *error;
	NSArray *assetURLS = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
	
	if ([assetURLS count]) {
		LLAssetURL *llAssetURL = (LLAssetURL *)[assetURLS objectAtIndex:0];		
		return llAssetURL;
	}
	
	return nil;
}

@end
