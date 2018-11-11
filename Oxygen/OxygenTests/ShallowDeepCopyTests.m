//
//  ShallowDeepCopyTests.m
//  OxygenTests
//
//  Created by Meiliang Dong on 2018/10/15.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ShallowDeepCopyTests : XCTestCase

@end

@implementation ShallowDeepCopyTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testPointerVariable {

    NSString *originalString = @"Hello World!";
    
    NSString *copyString = [originalString copy];
    
    NSString *mutableCopyString = [originalString mutableCopy];
    
    NSLog(@"&originalString=%p, originalString=%p\n", &originalString, originalString);
    
    NSLog(@"&copyString=%p, copyString=%p\n", &copyString, copyString);

    NSLog(@"&mutableCopyString=%p, mutableCopyString=%p\n", &mutableCopyString, mutableCopyString);
    
    /*
     One result:
     &originalString=0x7ffeed12e9f0, originalString=0x11f9741e0
     &copyString=0x7ffeed12e9e8, copyString=0x11f9741e0
     &mutableCopyString=0x7ffeed12e9e0, mutableCopyString=0x7fd8abf96e00
     */
    XCTAssertTrue(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
