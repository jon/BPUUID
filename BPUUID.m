//
//  BPUUID.m
//  Skates
//
//  Created by Jon Olson on 2/3/10.
//  Copyright 2010 Ballistic Pigeon, LLC. All rights reserved.
//

#import "BPUUID.h"


@interface BPUUID (Private)

@end

@implementation BPUUID

#pragma mark -
#pragma mark Construction and deallocation

+ (BPUUID *)UUID {
	return [[[self alloc] init] autorelease];
}

+ (BPUUID *)UUIDWithCFUUID:(CFUUIDRef)uuid {
	return [[[self alloc] initWithCFUUID:uuid] autorelease];
}

+ (BPUUID *)UUIDWithString:(NSString *)uuidString {
	return [[[self alloc] initWithString:uuidString] autorelease];
}

+ (BPUUID *)UUIDWithBytes:(NSData *)uuidBytes {
	return [[[self alloc] initWithBytes:uuidBytes] autorelease];
}

- (id)init {
	if (self = [super init]) {
		CFUUID = CFUUIDCreate(NULL);
	}
	
	return self;
}

- (id)initWithCFUUID:(CFUUIDRef)uuid {
	if (self = [super init]) {
		CFRetain(uuid);
		CFUUID = uuid;
	}
	
	return self;
}

- (id)initWithString:(NSString *)uuidString {
	if (self = [super init]) {
		CFUUID = CFUUIDCreateFromString(NULL, (CFStringRef)uuidString);
	}
	
	return self;
}

- (id)initWithBytes:(NSData *)uuidBytes {
	if (self = [super init]) {
		CFUUIDBytes bytes;
		assert(sizeof(bytes) == [uuidBytes length]);
		[uuidBytes getBytes:&bytes];
		CFUUID = CFUUIDCreateFromUUIDBytes(NULL, bytes);
	}
	
	return self;
}

- (void)dealloc {
	CFRelease(CFUUID);
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

@synthesize CFUUID;

#pragma mark -
#pragma mark UUID Represnetations

- (NSString *)stringRepresentation {
	NSString *stringRep = (NSString *)CFUUIDCreateString(NULL, CFUUID);
	return [stringRep autorelease];
}

- (NSData *)byteRepresentation {
	CFUUIDBytes bytes = CFUUIDGetUUIDBytes(CFUUID);
	return [NSData dataWithBytes:&bytes length:sizeof(bytes)];
}

#pragma mark -
#pragma mark Description

- (NSString *)description {
	return [self stringRepresentation];
}

#pragma mark -
#pragma mark NSCoding implementation

- (id)initWithCoder:(NSCoder *)decoder {
	NSString *uuidString = [decoder decodeObjectForKey:@"UUID"];
	return [self initWithString:uuidString];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:[self stringRepresentation] forKey:@"UUID"];
}

@end
