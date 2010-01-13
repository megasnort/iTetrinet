//
//  iTetLocalFieldView.h
//  iTetrinet
//
//  Created by Alex Heinz on 8/28/09.
//
// A BoardView subclass that also draws the active (falling) block and accepts
// player input. Used only for the local player's board.

#import <Cocoa/Cocoa.h>
#import "iTetFieldView.h"

@class iTetKeyNamePair;

@interface iTetLocalFieldView : iTetFieldView
{
	IBOutlet id eventDelegate;
}

- (void)keyPressed:(iTetKeyNamePair*)key;

@end
