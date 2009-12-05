//
//  iTetGame.h
//  iTetrinet
//
//  Created by Alex Heinz on 12/3/09.
//

#import <Cocoa/Cocoa.h>
#import "iTetSpecials.h"

@class iTetLocalPlayer;
@class iTetPlayer;
@class iTetGameRules;

@interface iTetGame : NSObject
{
	NSArray* players;
	iTetLocalPlayer* localPlayer;
	iTetGameRules* rules;
	
	NSTimer* blockTimer;
}

- (id)initWithPlayers:(NSArray*)participants
		    rules:(iTetGameRules*)gameRules
	  startingLevel:(int)startingLevel
   initialStackHeight:(int)stackHeight;

- (void)specialUsed:(iTetSpecialType)special
	     byPlayer:(iTetPlayer*)sender
	     onPlayer:(iTetPlayer*)target;
- (void)linesAdded:(int)numLines
	    byPlayer:(iTetPlayer*)sender;

@end