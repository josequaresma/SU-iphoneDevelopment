//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jose Quaresma on 2/3/13.
//  Copyright (c) 2013 Jose Quaresma. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; // because we provide setter AND getter


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *othercard = [otherCards lastObject];
        if ([othercard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (othercard.rank == self.rank){
            score = 4;
        }
    } else if ([otherCards count] == 2)
    {
        PlayingCard *othercard1 = otherCards[0];
        PlayingCard *othercard2 = otherCards[1];
        if (([othercard1.suit isEqualToString:self.suit]) && ([othercard2.suit isEqualToString:self.suit])) {
            score = 4;
        } else if ((othercard1.rank == self.rank) && (othercard1.rank == self.rank)){
            score = 8;
        }
    }
    return score;
}


- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end