#import "Vector3.h"

@implementation Vector3

@synthesize x;
@synthesize y;
@synthesize z;

-(id)init
{
    if (self = [super init])
    {
        self.x = 0;
        self.y = 0;
        self.z = 0;
    }
    
    return self;
}

-(id)initWithX:(double)newX
          andY:(double)newY
          andZ:(double)newZ
{
    if (self = [super init])
    {
        self.x = newX;
        self.y = newY;
        self.z = newZ;
    }
    
    return self;
}

-(Vector3*)vectorByAddingVector:(Vector3*)other
{
	Vector3* sum = [[Vector3 alloc] init];
	sum.x = self.x + other.x;
	sum.y = self.y + other.y;
	sum.z = self.z + other.z;
	return sum;
}

-(Vector3*)vectorBySubtractingVector:(Vector3*)other
{
    Vector3* difference = [[Vector3 alloc] init];
	difference.x = self.x - other.x;
	difference.y = self.y - other.y;
	difference.z = self.z - other.z;
	return difference;
}

-(Vector3*)vectorByMultiplication:(double)multiplier
{
	return [[Vector3 alloc] initWithX:self.x * multiplier 
                                 andY:self.y * multiplier 
                                 andZ:self.z * multiplier];
}

-(Vector3*)vectorByDivision:(double)divisor
{
	return [[Vector3 alloc] initWithX:self.x / divisor
                                 andY:self.y / divisor 
                                 andZ:self.z / divisor];
}

-(double)dotProductWithVector:(Vector3*)other
{
	return (self.x * other.x) + (self.y * other.y) + (self.z * other.z);
}

-(Vector3*)vectorByCrossProductWithVector:(Vector3*)other
{
	Vector3* product = [[Vector3 alloc] init];
	product.x = (self.y * other.z) - (self.z * other.y);
	product.y = (self.z * other.x) - (self.x * other.z);
	product.z = (self.x * other.y) - (self.y * other.x);
	return product;
}

-(double)getLength
{
	return sqrt(pow(self.x, 2) + pow(self.y, 2) + pow(self.z, 2));
}

-(double)distanceToVector:(Vector3*)other
{
	return sqrt(pow(self.x - other.x, 2) + pow(self.y - other.y, 2) + pow(self.z - other.z, 2));
}

-(Vector3*) vectorByNormalization
{
	double length = [self getLength];
	return [[Vector3 alloc] initWithX:self.x / length 
                                 andY:self.y / length 
                                 andZ:self.z / length];
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"Vector3: %f,%f,%f", self.x, self,y, self.z];
}

@end
