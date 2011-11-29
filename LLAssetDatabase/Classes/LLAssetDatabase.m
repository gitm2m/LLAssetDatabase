//
//  LLAssetDatabase.m
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import "LLAssetDatabase.h"

@implementation LLAssetDatabase

@synthesize managedObjectContext = __managedObjectContext;
@synthesize operationQueue = __operationQueue;

- (void)dealloc
{
	[__managedObjectContext release];
	
	[__operationQueue cancelAllOperations];
	[__operationQueue release];
	
    [super dealloc];
}

-(void)index {
	ALAssetsLibrary *library = [ALAssetsLibrary sharedLibrary];
	[library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
		
		if (group) {
			LLAssetIndexer *assetIndexer = [[LLAssetIndexer alloc] initWithAssetGroup:group];
			
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mergeChanges:) name:NSManagedObjectContextDidSaveNotification object:[assetIndexer managedObjectContext]];
			
			[[self operationQueue] addOperation:assetIndexer];
			[assetIndexer release];
		}
		
	} failureBlock:^(NSError *error) {
		
	}];
}

-(void)mergeChanges:(NSNotification *)notification {
	[[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
}

-(NSOperationQueue *)operationQueue {
	if (__operationQueue) {
		return __operationQueue;
	}
	
	__operationQueue = [[NSOperationQueue alloc] init];
	return __operationQueue;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [LLAssetDatabase persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
+ (NSManagedObjectModel *)managedObjectModel
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LLAssetDatabase" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	
	static dispatch_once_t onceToken;
	static NSPersistentStoreCoordinator *shared = nil;
	dispatch_once(&onceToken, ^{
		NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LLAssetDatabase.sqlite"];
		
		NSError *error = nil;
		NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
		
		shared = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
		if (![shared addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
		{
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}    
	});	
	return shared;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
