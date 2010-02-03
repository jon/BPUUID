//
//  BPUUID.h
//  Skates
//
//  Created by Jon Olson on 2/3/10.
//  Copyright 2010 Ballistic Pigeon, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BPUUID : NSObject {
	CFUUIDRef CFUUID;
}

@property (readonly) CFUUIDRef CFUUID;

+ (BPUUID *)UUID;
+ (BPUUID *)UUIDWithCFUUID:(CFUUIDRef)uuid;
+ (BPUUID *)UUIDWithString:(NSString *)uuidString;
+ (BPUUID *)UUIDWithBytes:(NSData *)uuidBytes;

- (id)initWithCFUUID:(CFUUIDRef)uuid;
- (id)initWithString:(NSString *)uuidString;
- (id)initWithBytes:(NSData *)uuidBytes;

- (NSString *)stringRepresentation;
- (NSData *)byteRepresentation;

@end
