//
//  Deck.h
//  CardGame
//
//  Created by Beo Bo on 1/31/13.
//  Copyright (c) 2013 Beo Bo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
