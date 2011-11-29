//
//  LLAssetIndexer.m
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import "LLAssetIndexer.h"

@implementation LLAssetIndexer

@synthesize managedObjectContext = __managedObjectContext;
@synthesize assetsGroup = __assetsGroup;
@synthesize isExecuting = __isExecuting;
@synthesize isFinished = __isFinished;
@synthesize llAssetsGroup = __llAssetsGroup;


-(id)initWithAssetGroup:(ALAssetsGroup *)assetsGroup {
	self = [super init];
	if (self) {
		
		[self setAssetsGroup:assetsGroup];
				
		return self;
	}
	
	return nil;
}

-(void)start {
	__block NSUInteger count = 0;
	NSLog(@"START ON %f FOR GROUP %@", [[NSDate date] timeIntervalSince1970], [[self assetsGroup] valueForProperty:ALAssetsGroupPropertyName]);
	
	LLAssetGroup *llAssetGroup = [LLAssetGroup LLAssetGroupWithALAssetsGroup:[self assetsGroup] managedObjectContext:[self managedObjectContext]];
	[self setLlAssetsGroup:llAssetGroup];
	
	[__assetsGroup enumerateAssetsWithOptions:NSEnumerationConcurrent usingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
		if ([self isCancelled]) {
			*stop = YES;
		}
		else if (*stop) {
			[self saveContext];
			[self finish];
		}
		
		if (asset) {
			LLAsset *llAsset = [LLAsset LLAssetWithALAsset:asset managedObjectContext:[self managedObjectContext]];
			[[self llAssetsGroup] addAssetsObject:llAsset];
			count++;
		}
		NSLog(@"COUNT %i", count);
		if (count == 10) {

			[self saveContext];
		}
	}];
	
    [self willChangeValueForKey:@"isExecuting"];
    __isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

-(BOOL)isConcurrent {
	return YES;
}

-(void)finish {
	NSLog(@"FINISHED ON %f FOR GROUP %@", [[NSDate date] timeIntervalSince1970], [[self assetsGroup] valueForProperty:ALAssetsGroupPropertyName]);

	[self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
	
    __isExecuting = NO;
    __isFinished = YES;
	
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

-(void)saveContext {
	NSError *error;
	[[self managedObjectContext] save:&error];	
}

-(NSManagedObjectContext *)managedObjectContext {
	if (__managedObjectContext) {
		return __managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *persistentStoreCoordinator = [LLAssetDatabase persistentStoreCoordinator];
	
	__managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
	[__managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
	
	return __managedObjectContext;
}



@end
