//
//  Card.h
//  Matchismo
//
//  Created by Jose Quaresma on 2/3/13.
//  Copyright (c) 2013 Jose Quaresma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;

@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
