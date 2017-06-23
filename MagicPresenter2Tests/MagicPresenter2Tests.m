//
//  MagicPresenter2Tests.m
//  MagicPresenter2Tests
//
//  Created by James Tang on 23/6/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MagicPresenter2Tests : XCTestCase

@property (nonatomic, copy) NSString *manifestPath;

@end

@implementation MagicPresenter2Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"manifest" ofType:@"json"];
    self.manifestPath = path;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFileExists {
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:self.manifestPath], @"file should exist");
}

- (void)testIsValidJSON {
    NSData *data = [NSData dataWithContentsOfFile:self.manifestPath];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(jsonObject);
}

@end
