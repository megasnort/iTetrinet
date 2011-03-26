//
//  iTetPlayerLeaveMessage.m
//  iTetrinet
//
//  Created by Alex Heinz on 3/21/11.
//  Copyright (c) 2011 Alex Heinz (xale@acm.jhu.edu)
//  This is free software, presented under the MIT License
//  See the included license.txt for more information
//

#import "iTetPlayerLeaveMessage.h"

NSString* const iTetPlayerLeaveMessageTag =	@"playerleave";

@implementation iTetPlayerLeaveMessage

- (id)initWithMessageTokens:(NSArray*)tokens
{
	// Treat the second token as the player number
	playerNumber = [[tokens objectAtIndex:1] integerValue];
	
	return self;
}

+ (id)messageWithPlayerNumber:(NSInteger)number
{
	return [[[self alloc] initWithPlayerNumber:number] autorelease];
}

- (id)initWithPlayerNumber:(NSInteger)number
{
	playerNumber = number;
	
	return self;
}

#pragma mark -
#pragma mark Message Contents

- (NSString*)messageContents
{
	return [NSString stringWithFormat:@"%@ %ld", iTetPlayerLeaveMessageTag, [self playerNumber]];
}

#pragma mark -
#pragma mark Accessors

@synthesize playerNumber;

@end
