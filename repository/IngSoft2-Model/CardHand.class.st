Class {
	#name : #CardHand,
	#superclass : #Object,
	#instVars : [
		'handOfCards',
		'ship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardHand class >> of: aShip with: aCollectionOfCards [ 
	^ self new initializeCardHandOf: aShip with: aCollectionOfCards .
]

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

{ #category : #asserting }
CardHand >> assertIsYourTurn: aShip in: zathuraGame [

	(zathuraGame isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
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

{ #category : #initalization }
CardHand >> initializeCardHandOf: aShip with: cards [ 
	handOfCards := cards asOrderedCollection.
	ship:= aShip
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

{ #category : #'accessing - attributes' }
CardHand >> ship [
	^ ship
]

{ #category : #actions }
CardHand >> using: aCancelationCard removingToAll: aCard in: aZathuraGame [ 
	aCancelationCard  applyEffectRemoving: aCard in: aZathuraGame 
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

	cancellationCard applyEffectRemoving: aCard in: zathuraGame
]

{ #category : #throwing }
CardHand >> using: card toAllShipsin: zathuraGame [

	self assertCardIsInHand: card.
	card applyEffectToAllShipsIn: zathuraGame.
	self remove: card
]
