//
//  PlayingCard.m
//  CardGame
//
//  Created by Beo Bo on 1/31/13.
//  Copyright (c) 2013 Beo Bo. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuit
{
    static NSArray *validSuits = nil;
    if (!validSuits)
        validSuits = @[@"♥",@"♦",@"♠",@"♣"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuit] containsObject:suit])
        _suit = suit;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings)
        rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return rankStrings;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
        _rank = rank;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit])
            score = 2;
        else if (otherCard.rank == self.rank)
            score = 6;
    } else if ([otherCards count] == 2) {
        PlayingCard *otherCard1 = otherCards[0];
        PlayingCard *otherCard2 = otherCards[1];
        if ([otherCard1.suit isEqualToString:self.suit] && [otherCard2.suit isEqualToString:self.suit]) score = 4;
        else if ([otherCard1.suit isEqualToString:self.suit]) score = 1;
        else if ([otherCard2.suit isEqualToString:self.suit]) score = 2;
        else if ([otherCard1.suit isEqualToString:otherCard2.suit]) score = 3;
        else if (otherCard1.rank == self.rank && otherCard2.rank == self.rank) score = 9;
        else if (otherCard1.rank == self.rank) score = 5;
        else if (otherCard2.rank == self.rank) score = 6;
        else if (otherCard1.rank == otherCard2.rank) score = 7;
    }
    
    return score;
}

@end
