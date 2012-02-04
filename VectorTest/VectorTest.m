//
//  VectorTest.m
//  VectorTest
//
//  Created by Donald McGaughey on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VectorTest.h"
#import "Vector2.h"

@implementation VectorTest

Vector2* myVector;

- (void)setUp
{
    [super setUp];
    
    myVector = [[Vector2 alloc] initWithX:10.0f andY:20.0f];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testBaseVector2
{

    STAssertTrue(myVector.x == 10.0f, @"Testing x value of vector");
    STAssertFalse(myVector.x == 20.0f, @"Testing x value isn't 20");
}

- (void)testVectorLength
{
    double length = [myVector getLength];
    STAssertTrue((length > 22.360679f) && (length < 22.360681), @"Length is %f not 22.360680", length);
}

@end
