//
//  BBAAppDelegate.h
//  Bluetooth Project
//
//  Created by Brian Pedersen on 1/20/12.
//  Copyright (c) 2012 Bluebird. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BBAAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
