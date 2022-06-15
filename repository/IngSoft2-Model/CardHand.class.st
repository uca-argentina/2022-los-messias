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

{ #category : #'accessing - arguments' }
CardHand >> handOfCards [
	^ handOfCards
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
CardHand >> throwInstant: aCancelationCard removingToAll: aCard in: aZathuraGame [ 
	aCancelationCard  applyEffectToAllShipsRemoving: aCard in: aZathuraGame 
]

{ #category : #action }
CardHand >> throwInstant: aCard to: aShip in: zathuraGame [ 

	self assertCardIsInHand: aCard.
	aCard applyEffectTo: aShip in: zathuraGame.
	self remove: aCard
]

{ #category : #action }
CardHand >> throwInstant: cancellationCard to: aShip removing: aCard in: zathuraGame [

	cancellationCard applyEffectTo: aShip removing: aCard in: zathuraGame
]

{ #category : #throwing }
CardHand >> throwPermanent: card to: aShip in: zathuraGame [

	self assertCardIsInHand: card.
	self assertIsYourTurn: (self ship) in: zathuraGame. 
	card applyEffectTo: aShip in: zathuraGame.
	self remove: card
]

{ #category : #throwing }
CardHand >> throwPermanent: card toAllShipsin: zathuraGame [

	self assertCardIsInHand: card.
	self assertIsYourTurn: self ship in: zathuraGame. 
	card applyEffectToAllShipsIn: zathuraGame.
	self remove: card
]
