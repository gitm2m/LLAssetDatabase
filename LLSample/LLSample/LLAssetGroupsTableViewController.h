//
//  LLAssetGroupsTableViewController.h
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/29/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLAssetDatabase.h"

@interface LLAssetGroupsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>


-(BOOL)performFetch;

@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;
@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSFetchRequest *fetchRequest;	

@end
