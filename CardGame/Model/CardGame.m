//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Beo Bo on 2/1/13.
//  Copyright (c) 2013 Beo Bo. All rights reserved.
//

#import "CardGame.h"

@interface CardGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@end

@implementation CardGame
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (NSMutableArray *)cards
{
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card)
                self = nil;
            else
                self.cards[i] = card;
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index <[self.cards count]) ? self.cards[index] : nil;
}

- (NSString *)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *flipResult;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        flipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        flipResult = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    // after finding enough card
                    break;
                }
            }
            // no avaiable card
            self.score -= FLIP_COST;
            if (!flipResult)
                flipResult = [NSString stringWithFormat:@"Flipped up %@",card.contents];
        }
        card.faceUp = !card.isFaceUp;
    }
    
    return flipResult;
}

- (NSString *)flipCardHardModeAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *flipResult;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard1 in self.cards) {
                if (otherCard1.isFaceUp && !otherCard1.isUnplayable) {
                    for (Card *otherCard2 in self.cards) {
                        if (otherCard2.isFaceUp && !otherCard2.isUnplayable && otherCard1 != otherCard2) {
                            int matchScore = [card match:@[otherCard1,otherCard2]];
                            switch (matchScore) {
                                case 9: // 3ranks
                                case 4: // 3suits
                                    // 3 ranks
                                    card.unplayable = YES;
                                    otherCard1.unplayable = YES;
                                    otherCard2.unplayable = YES;
                                    self.score += matchScore * MATCH_BONUS;
                                    flipResult = [NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points",card.contents, otherCard1.contents, otherCard2.contents, matchScore * MATCH_BONUS];
                                    break;
                                case 5: // 0-1 ranks
                                case 1: // 0-1 suits
                                    card.unplayable = YES;
                                    otherCard1.unplayable = YES;
                                    otherCard2.faceUp = NO;
                                    self.score += matchScore * MATCH_BONUS;
                                    flipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",card.contents, otherCard1.contents, matchScore * MATCH_BONUS];
                                    break;
                                case 6: // 0-2 ranks
                                case 2: // 0-2 suits
                                    card.unplayable = YES;
                                    otherCard2.unplayable = YES;
                                    otherCard1.faceUp = NO;
                                    self.score += (matchScore-1) * MATCH_BONUS;
                                    flipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",card.contents, otherCard2.contents, (matchScore-1) * MATCH_BONUS];
                                    break;
                                case 7: // 1-2 ranks
                                case 3: // 1-2 suits
                                    otherCard1.unplayable = YES;
                                    otherCard2.unplayable = YES;
                                    //card.faceUp = NO;
                                    self.score += (matchScore-2) * MATCH_BONUS;
                                    flipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",otherCard1.contents, otherCard2.contents, (matchScore-2) * MATCH_BONUS];
                                    break;
                                case 0: // mismatch
                                    otherCard1.faceUp = NO;
                                    otherCard2.faceUp = NO;
                                    self.score -= MISMATCH_PENALTY;
                                    flipResult = [NSString stringWithFormat:@"%@ & %@ & %@ don't match! %d point penalty!", card.contents, otherCard1.contents, otherCard2.contents, MISMATCH_PENALTY];
                            }
                            // after finding enough cards
                            break; //or return
                        }
                    }
                    // no 2nd available card
                }
            }
            // no 1st avaiable card
            self.score -= FLIP_COST;
            if (!flipResult)
                flipResult = [NSString stringWithFormat:@"Flipped up %@",card.contents];

        }
        card.faceUp = !card.isFaceUp;
    }

    return flipResult;
    
}

@end
