#import <Foundation/Foundation.h>
#import "Vector3.h"

@interface Vector2 : NSObject

@property double x;
@property double y;

-(id)initWithX:(double)newX andY:(double)newY;
-(Vector2*) vectorByAddingVector: (Vector2*) other;
-(Vector2*) vectorBySubtractingVector: (Vector2*) other;
-(Vector2*) vectorByMultiplication: (double) multiplier;
-(Vector2*) vectorByDivision: (double) divisor;
-(double) dotProductWithVector:(Vector2*)other;
-(Vector3*) vectorByCrossProductWithVector:(Vector2*) other;
-(Vector2*) vectorByCrossProductWithZ;
-(Vector2*) vectorByCrossProductWithNegativeZ;
-(BOOL)isInteriorToVector:(Vector2*)other;
-(double)getLength;
-(double)distanceToVector:(Vector2*) other;
-(Vector2*)vectorByNormalization;
-(Vector2*)vectorByNormalToThisVector;
-(Vector2*) vectorByRotationInDegrees:(double)degrees;
-(double) angleInDegreesWithVector:(Vector2*) other;
-(Vector2*) vectorByProjectionOntoThisVector:(Vector2*) other;

@end
