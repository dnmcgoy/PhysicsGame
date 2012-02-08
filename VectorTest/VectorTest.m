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

-(void)testVectorByAddingVector
{
    Vector2* other = [[Vector2 alloc] initWithX:50 andY:67];
    Vector2* sum = [myVector vectorByAddingVector:other];
    STAssertEquals(sum.x, (double)60.0, @"Testing vectorByAddingVector: x was not 60");
    STAssertEquals(sum.y, (double)87.0, @"Testing vectorByAddingVector: y was not 87");
    
    other = [[Vector2 alloc] initWithX:-9897 andY:-5555];
    sum = [myVector vectorByAddingVector:other];
    STAssertEquals(sum.x, (double)-9887, @"Testing vectorByAddingVector: x was not -9887");
    STAssertEquals(sum.y, (double)-5535, @"Testing vectorByAddingVector: x was not -5535");
}

-(void)testVectorBySubtractingVector
{
    Vector2* other = [[Vector2 alloc] initWithX:50 andY:67];
    Vector2* diff = [myVector vectorBySubtractingVector:other];
    STAssertEquals(diff.x, (double)-40.0, @"Testing vectorBySubtractingVector: x was not -40");
    STAssertEquals(diff.y, (double)-47.0, @"Testing vectorBySubtractingVector: y was not -47");
    
    other = [[Vector2 alloc] initWithX:-9897 andY:-5555];
    diff = [myVector vectorBySubtractingVector:other];
    STAssertEquals(diff.x, (double)9907, @"Testing vectorBySubtractingVector: x was not 9907");
    STAssertEquals(diff.y, (double)5575, @"Testing vectorBySubtractingVector: x was not 5575");
}

-(void)testVectorByMultiplication
{
    Vector2* product = [myVector vectorByMultiplication:10];
    STAssertEquals(product.x, (double)100.0, @"Testing vectorByMultiplication: x was not 100");
    STAssertEquals(product.y, (double)200.0, @"Testing vectorByMultiplication: y was not 200");
                   
}

-(void)testVectorByDivision
{
    Vector2* quotient = [myVector vectorByDivision:10];
    STAssertEquals(quotient.x, (double)1.0, @"Testing vectorByDivision: x was not 1");
    STAssertEquals(quotient.y, (double)2.0, @"Testing vectorByDivision: y was not 2");
}

-(void)testDotProductWithVector
{
    Vector2* other = [[Vector2 alloc] initWithX:5 andY:7];
    double product = [myVector dotProductWithVector:other];
    STAssertEquals(product, (double)190.0, @"Testing dotProductWithVector: x was not 190");
}

-(void)testVectorByCrossProductWithVector
{
    Vector2* other = [[Vector2 alloc] initWithX:10 andY:11];
    Vector3* product = [myVector vectorByCrossProductWithVector:other];
    STAssertEquals(product.x, (double)0, @"Testing vectorByCrossProductWithVector: x was not 0");
    STAssertEquals(product.y, (double)0, @"Testing vectorByCrossProductWithVector: y was not 0");
    STAssertEquals(product.z, (double)-90, @"Testing vectorByCrossProductWithVector: z was not -90");
}

-(void)testVectorByCrossProductWithZ
{
    Vector2* product = [myVector vectorByCrossProductWithZ];
    STAssertEquals(product.x, (double)20, @"Testing vectorByCrossProductWithZ: x was not 20");
    STAssertEquals(product.y, (double)-10, @"Testing vectorByCrossProductWithZ: y was not -10");
}

-(void)testVectorByCrossProductWithNegativeZ
{
    Vector2* product = [myVector vectorByCrossProductWithNegativeZ];
    STAssertEquals(product.x, (double)-20, @"Testing vectorByCrossProductWithNegativeZ: x was not -20");
    STAssertEquals(product.y, (double)10, @"Testing vectorByCrossProductWithNegativeZ: y was not 10");
}

-(void)testIsInteriorToVector
{
    Vector2* other = [[Vector2 alloc] initWithX:10 andY:0];
    STAssertTrue([myVector isInteriorToVector:other], @"Testing isInteriorToVector: should be true");
    
    other = [[Vector2 alloc] initWithX:0 andY:10];
    STAssertFalse([myVector isInteriorToVector:other], @"Testing isInteriorToVector: should be false");
}

-(void)testDistanceToVector
{
    Vector2* other = [[Vector2 alloc] initWithX:0 andY:40];
    double distance = [myVector distanceToVector:other];
    STAssertTrue(distance > 22.36f, @"Testing distanceToVector: distance was not greater than 22.36");
    STAssertTrue(distance < 22.37f, @"Testing distanceToVector: distance was not less than 22.37");
}

-(void)testVectorByNormalization
{
    Vector2* normalized = [myVector vectorByNormalization];
    STAssertTrue(normalized.x > 0.447, @"Testing vectorByNormalization: x was not greater than 0.447");
    STAssertTrue(normalized.x < 0.448, @"Testing vectorByNormalization: x was not less than 0.448");
    STAssertTrue(normalized.y > 0.894, @"Testing vectorByNormalization: y was not greater than 0.894");
    STAssertTrue(normalized.y < 0.895, @"Testing vectorByNormalization: y was not less than 0.895");
}

-(void)testVectorByNormalToThisVector
{
    Vector2* normal = [myVector vectorByNormalToThisVector];
    STAssertTrue(normal.x > -0.895, @"Testing vectorByNormalToThisVector: x was not greater than -0.895");
    STAssertTrue(normal.x < -0.894, @"Testing vectorByNormalToThisVector: x was not less than -0.894");
    STAssertTrue(normal.y > 0.447, @"Testing vectorByNormalToThisVector: y was not greater than 0.447");
    STAssertTrue(normal.y < 0.448, @"Testing vectorByNormalToThisVector: y was not less than 0.448");
}

-(void)testVectorByRotationInDegrees
{
    Vector2* rotated = [myVector vectorByRotationInDegrees:90];
    STAssertTrue(rotated.x > -20.01, @"Testing vectorByRotationInDegrees: x was not greater than -20.01");
    STAssertTrue(rotated.x < -19.99, @"Testing vectorByRotationInDegrees: x was not less than -19.99");
    STAssertTrue(rotated.y > 9.99, @"Testing vectorByRotationInDegrees: y was not greater than 9.99");
    STAssertTrue(rotated.y < 10.01, @"Testing vectorByRotationInDegrees: y was not less than -10.01");
}

-(void)testAngleInDegreesWithVector
{
    Vector2* other = [[Vector2 alloc] initWithX:-20 andY:10];
    double angle = [myVector angleInDegreesWithVector:other];
    STAssertTrue(angle > 89.99 && angle < 90.01, @"Testing angleInDegreesWithVector: angle was not 90");
}

-(void)testVectorByProjectionOntoThisVector
{
    Vector2* other = [[Vector2 alloc] initWithX:1 andY:0];
    Vector2* projection = [myVector vectorByProjectionOntoThisVector:other];
    STAssertTrue(projection.x > 0.19 && projection.x < 0.21, @"Testing vectorByProjectionOntoThisVector: x was not 0.2");
    STAssertTrue(projection.y > 0.39 && projection.y < 0.41, @"Testing vectorByProjectionOntoThisVector: y was not 0.4");
}

-(void)testToVector3
{
    Vector3* vector3 = [myVector toVector3];
    STAssertEquals(vector3.x, myVector.x, @"Testing toVector3: x was not equal");
    STAssertEquals(vector3.y, myVector.y, @"Testing toVector3: y was not equal");
    STAssertEquals(vector3.z, (double)0, @"Testing toVector3: z was not 0");
}

- (void)testVectorLength
{
    double length = [myVector getLength];
    STAssertTrue((length > 22.360679f) && (length < 22.360681), @"Length is %f not 22.360680", length);
}

@end
