Class {
	#name : #CardHand,
	#superclass : #Object,
	#instVars : [
		'handOfCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHand class >> with: cards [

	^ self new initializeWith: cards
]

{ #category : #actions }
CardHand >> add: aCard [
	handOfCards add: aCard.
]

{ #category : #asserting }
CardHand >> assertCardIsInHand: aCard [

	(handOfCards anySatisfy: [ :card | aCard isMemberOf: (card class) ]) 
		ifFalse: [ Error signal: 'Card is not in Hand' ]
]

{ #category : #assertions }
CardHand >> assertZathuraHasCardsOnTable [
	self shouldBeImplemented.
]

{ #category : #assertion }
CardHand >> assertZathuraHasCardsOnTableIn: aZathuraGame [ 
	self shouldBeImplemented.
]

{ #category : #accesing }
CardHand >> cardsOf [

	^ handOfCards
]

{ #category : #accesing }
CardHand >> cardsOf: aCard [

	^ handOfCards select: [ :card | card hasEqualClass: aCard ]
]

{ #category : #initialization }
CardHand >> initializeWith: cards [

	handOfCards := cards asOrderedCollection 
]

{ #category : #removing }
CardHand >> remove: aCard [

	| theCard |
	theCard := 0.
	handOfCards do: [ :card | (card isMemberOf: aCard class) ifTrue: [ theCard := card ] ].
	handOfCards remove: theCard
]

{ #category : #throwing }
CardHand >> using: card to: ship in: zathuraGame [

	self assertCardIsInHand: card.
	card applyEffectTo: ship in: zathuraGame.
	self remove: card
]

{ #category : #action }
CardHand >> using: cancellationCard to: aShip removing: aCard in: zathuraGame [

	"Esto rompe si hay más de una OverLoad en el tablero, vamos a tener que identificar al ship en algunos casos y en otros no. El nombre applyEffectToACard: desp hay que cambiarlo"

(zathuraGame cardsOnTableOf: aCard) = 0 ifTrue:[Error signal:'There are not cards in play' ].
	cancellationCard
		applyEffectTo: aShip
		removing: aCard
		in: zathuraGame
]

{ #category : #throwing }
CardHand >> using: card toAllShipsin: zathuraGame [

	self assertCardIsInHand: card.
	card applyEffectToAllShipsIn: zathuraGame.
	self remove: card
]
