//
//  iTetKeyNamePair.m
//  iTetrinet
//
//  Created by Alex Heinz on 11/12/09.
//

#import "iTetKeyNamePair.h"


@implementation iTetKeyNamePair

+ (id)keyNamePairFromKeyEvent:(NSEvent*)event;
{
	return [[[self alloc] initWithKeyEvent:event] autorelease];
}

+ (id)keyNamePairForKeyCode:(int)code
			     name:(NSString*)name
{
	return [[[self alloc] initWithKeyCode:code
						   name:name] autorelease];
}

- (id)initWithKeyEvent:(NSEvent*)event
{
	// Get the key code
	keyCode = [event keyCode];
	
	// Check if the event is a modifier event
	BOOL isModifier = ([event type] == NSFlagsChanged);
	
	// Determine the name of the event
	if (isModifier)
		keyName = [[self modifierNameForEvent:event] retain];
	else
		keyName = [[self keyNameForEvent:event] retain];
	
	return self;
	
}

- (id)initWithKeyCode:(int)code
		     name:(NSString*)name
{
	keyCode = code;
	keyName = [name copy];
	
	return self;
}

- (void)dealloc
{
	[keyName release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Key Name Lookups

#define EscapeKeyCode	(53)

NSString* const iTetEscapeKeyPlaceholderString =	@"esc";
NSString* const iTetSpacebarPlaceholderString =		@"     space     ";
NSString* const iTetTabKeyPlaceholderString =		@"  tab  ";
NSString* const iTetReturnKeyPlaceholderString =	@"return";
NSString* const iTetEnterKeyPlaceholderString =		@"enter";
NSString* const iTetDeleteKeyPlaceholderString =	@"delete";

#define iTetLeftArrowKeyPlaceholderString		[NSString stringWithFormat:@"%C", 0x2190]
#define iTetRightArrowKeyPlaceholderString	[NSString stringWithFormat:@"%C", 0x2192]
#define iTetUpArrowKeyPlaceholderString		[NSString stringWithFormat:@"%C", 0x2191]
#define iTetDownArrowKeyPlaceholderString		[NSString stringWithFormat:@"%C", 0x2193]

- (NSString*)keyNameForEvent:(NSEvent*)keyEvent
{
	// Check for events with no characters
	switch ([keyEvent keyCode])
	{
		case EscapeKeyCode:
			return iTetEscapeKeyPlaceholderString;
		// FIXME: others?
	}
	
	// Get the characters representing the event
	NSString* keyString = [[keyEvent charactersIgnoringModifiers] lowercaseString];
	
	// Check for various non-printing keys
	unichar key = [keyString characterAtIndex:0];
	switch (key)
	{
			// Space
		case ' ':
			keyString = iTetSpacebarPlaceholderString;
			break;
			// Tab
		case NSTabCharacter:
			keyString = iTetTabKeyPlaceholderString;
			break;
			// Return/Newline
		case NSLineSeparatorCharacter:
		case NSNewlineCharacter:
		case NSCarriageReturnCharacter:
			keyString = iTetReturnKeyPlaceholderString;
			break;
			// Enter
		case NSEnterCharacter:
			keyString = iTetEnterKeyPlaceholderString;
			break;
			// Backspace/delete
		case NSBackspaceCharacter:
		case NSDeleteCharacter:
			keyString = iTetDeleteKeyPlaceholderString;
			break;
			
			// Arrow keys
		case NSLeftArrowFunctionKey:
			keyString = iTetLeftArrowKeyPlaceholderString;
			break;
		case NSRightArrowFunctionKey:
			keyString = iTetRightArrowKeyPlaceholderString;
			break;
		case NSUpArrowFunctionKey:
			keyString = iTetUpArrowKeyPlaceholderString;
			break;
		case NSDownArrowFunctionKey:
			keyString = iTetDownArrowKeyPlaceholderString;
			break;
	}
	// FIXME: Additional non-printing keys?
	
	return keyString;
}

NSString* const iTetUnknownModifierPlaceholderString =	@"(unknown)";
NSString* const iTetShiftKeyPlaceholderString =			@"   shift   ";
NSString* const iTetControlKeyPlaceholderString	=		@"control";
NSString* const iTetAltOptionKeyPlaceholderString =		@"option";

#define iTetCommandKeyPlaceholderString [NSString stringWithFormat:@" %C  %C ", 0xF8FF, 0x2318]
// The above should render as the unicode Apple logo followed by the unicode cloverleaf

- (NSString*)modifierNameForEvent:(NSEvent*)modifierEvent
{
	NSString* modifierName = iTetUnknownModifierPlaceholderString;
	
	// Check which modifier is held down
	NSUInteger flags = [modifierEvent modifierFlags];
	if ((flags & NSAlphaShiftKeyMask) || (flags & NSShiftKeyMask))
		modifierName = iTetShiftKeyPlaceholderString;
	else if (flags & NSCommandKeyMask)
		modifierName = iTetCommandKeyPlaceholderString;
	else if (flags & NSAlternateKeyMask)
		modifierName = iTetAltOptionKeyPlaceholderString;
	else if (flags & NSControlKeyMask)
		modifierName = iTetControlKeyPlaceholderString;
	
	return modifierName;
}

#pragma mark -
#pragma mark Encoding/Decoding

NSString* const iTetKeyNamePairCodeKey =	@"keyCode";
NSString* const iTetKeyNamePairNameKey =	@"keyName";

- (void)encodeWithCoder:(NSCoder*)encoder
{
	[encoder encodeInt:[self keyCode]
			forKey:iTetKeyNamePairCodeKey];
	[encoder encodeObject:[self keyName]
			   forKey:iTetKeyNamePairNameKey];
}

- (id)initWithCoder:(NSCoder*)decoder
{
	keyCode = [decoder decodeIntForKey:iTetKeyNamePairCodeKey];
	keyName = [[decoder decodeObjectForKey:iTetKeyNamePairNameKey] retain];
	
	return self;
}

#pragma mark -
#pragma mark Accessors (Synthesized)

@synthesize keyCode;
@synthesize keyName;

@end