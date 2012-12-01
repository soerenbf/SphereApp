//
//  SphereTests.m
//  SphereTests
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "SphereTests.h"
#import "SphereViewController.h"

@implementation SphereTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    SphereViewController *test_subject = [[SphereViewController alloc] init];
    STAssertNotNil(test_subject, @"Could not create test subject.");
}

@end
