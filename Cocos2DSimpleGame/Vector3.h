#import <Foundation/Foundation.h>

@interface Vector3 : NSObject

@property double x;
@property double y;
@property double z;

-(id)initVector3WithX:(double)newX Y:(double)newY Z:(double)newZ;
-(Vector3*)vectorByAddingVector:(Vector3*)other;
-(Vector3*)vectorBySubtractingVector:(Vector3*)other;
-(Vector3*)vectorByMultiplication:(double)multiplier;
-(Vector3*)vectorByDivision:(double)divisor;
-(double)dotProductWithVector:(Vector3*)other;
-(Vector3*)vectorByCrossProductWithVector:(Vector3*)other;
-(double)getLength;
-(double)distanceToVector:(Vector3*)other;
-(Vector3*) vectorByNormalization;

@end
