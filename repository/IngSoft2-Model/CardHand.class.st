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

{ #category : #actions }
CardHand >> add: aCard [
	handOfCards add: aCard.
]

{ #category : #asserting }
CardHand >> assertCardIsInHand: aCard [

	(handOfCards anySatisfy: [ :card | aCard isKindOf: card class ]) ifFalse: [ 
		Error signal: 'Card is not in Hand' ]
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

{ #category : #removing }
CardHand >> remove: aCard [

	| theCard |
	theCard := 0.
	handOfCards do: [ :card | 
		(card isKindOf:  aCard class) ifTrue: [ theCard := card ] ].
	handOfCards remove: theCard
]

{ #category : #'accessing - attributes' }
CardHand >> ship [
	^ ship
]

{ #category : #actions }
CardHand >> throw: aCancelationCard removingToAll: aCard in: aZathuraGame [

	aCancelationCard
		applyEffectTo: (aZathuraGame ships )
		removing: aCard
		in: aZathuraGame.
	self remove: aCancelationCard
]

{ #category : #throwing }
CardHand >> throw: card to: aShip in: zathuraGame [

	self assertCardIsInHand: card.
	card applyEffectTo: aShip on: zathuraGame by: self ship.
	self remove: card
]

{ #category : #action }
CardHand >> throw: cancellationCard to: aShip removing: aCard in: zathuraGame [

	cancellationCard applyEffectTo: {aShip} removing: aCard in: zathuraGame.
	self remove: cancellationCard
]

{ #category : #throwing }
CardHand >> throw: card toAllShipsin: zathuraGame [

	self assertCardIsInHand: card.
	card applyEffectToAllShipsOn: zathuraGame by: self ship.
	self remove: card
]
