//
//  LLAssetLocation.m
//  AssetDatabase
//
//  Created by Glenn Wolters on 11/28/11.
//  Copyright (c) 2011 OMGWTFBBQ. All rights reserved.
//

#import "LLAssetLocation.h"
#import "LLAsset.h"


@implementation LLAssetLocation

@dynamic latitude;
@dynamic longitude;
@dynamic altitude;
@dynamic horizontalAccuracy;
@dynamic verticalAccuracy;
@dynamic timestamp;
@dynamic speed;
@dynamic course;
@dynamic asset;

+(LLAssetLocation *)LLAssetLocationWithCLLocation:(CLLocation *)location managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	
	CLLocationCoordinate2D coordinate = [location coordinate];
	NSNumber * latitude = [NSNumber numberWithDouble:coordinate.latitude];
	NSNumber * longitude = [NSNumber numberWithDouble:coordinate.longitude];
	NSNumber * altitude = [NSNumber numberWithDouble:location.altitude];
	NSNumber * horizontalAccuracy = [NSNumber numberWithDouble:location.horizontalAccuracy];
	NSNumber * verticalAccuracy = [NSNumber numberWithDouble:location.verticalAccuracy];
	NSDate * timestamp = [location timestamp];
	NSNumber * speed = [NSNumber numberWithDouble:location.speed];
	NSNumber * course = [NSNumber numberWithDouble:location.course];
	
	LLAssetLocation *assetLocation = [NSEntityDescription insertNewObjectForEntityForName:@"LLAssetLocation" inManagedObjectContext:managedObjectContext];
	
	[assetLocation setLatitude:latitude];
	[assetLocation setLongitude:longitude];
	[assetLocation setAltitude:altitude];
	[assetLocation setHorizontalAccuracy:horizontalAccuracy];
	[assetLocation setVerticalAccuracy:verticalAccuracy];
	[assetLocation setTimestamp:timestamp];
	[assetLocation setSpeed:speed];
	[assetLocation setCourse:course];
	
	return assetLocation;
}

@end
