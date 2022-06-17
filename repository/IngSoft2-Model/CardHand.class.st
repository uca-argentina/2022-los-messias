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
CardHand >> throw: aCancelationCard removingToAll: aCard in: aZathuraGame [

	aZathuraGame throw: aCancelationCard.
	aCancelationCard
		applyEffectToAllShipsRemoving: aCard
		in: aZathuraGame
]

{ #category : #throwing }
CardHand >> throw: card to: aShip in: zathuraGame [

	self assertCardIsInHand: card.
	zathuraGame throw: card.
	card applyEffectTo: aShip in: zathuraGame by: self ship.
	self remove: card
]

{ #category : #action }
CardHand >> throw: cancellationCard to: aShip removing: aCard in: zathuraGame [

	zathuraGame throw: cancellationCard.
	cancellationCard applyEffectTo: aShip removing: aCard in: zathuraGame
]

{ #category : #throwing }
CardHand >> throw: card toAllShipsin: zathuraGame [

	self assertCardIsInHand: card.
	zathuraGame throw: card.
	card applyEffectToAllShipsIn: zathuraGame by: self ship.
	self remove: card
]
