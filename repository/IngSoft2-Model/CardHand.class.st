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

{ #category : #action }
CardHand >> add: aCard [
	handOfCards add: aCard.
]

{ #category : #asserting }
CardHand >> assertCardIsInHand: aCard [

	(handOfCards anySatisfy: [ :card | aCard isKindOf: card class ]) ifFalse: [ 
		Error signal: 'Card is not in Hand' ]
]

{ #category : #initalization }
CardHand >> initializeCardHandOf: aShip with: cards [ 
	handOfCards := cards asOrderedCollection.
	ship:= aShip
]

{ #category : #private }
CardHand >> remove: aCard [

	| theCard |
	theCard := 0.
	handOfCards do: [ :card | (card isKindOf: aCard class)
		 ifTrue: [ theCard := card ] ].
	handOfCards remove: theCard
]

{ #category : #'accessing - attributes' }
CardHand >> ship [
	^ ship
]

{ #category : #throwing }
CardHand >> throw: aCancelationCard removingToAll: aCard on: aCardManager [

	aCancelationCard
		applyEffectTo: aCardManager ships
		removing: aCard
		on: aCardManager.
	self remove: aCancelationCard
]

{ #category : #throwing }
CardHand >> throw: aCard to: aShip on: aCardManager [

	self assertCardIsInHand: aCard.
	aCard applyEffectTo: aShip on: aCardManager by: self ship.
	self remove: aCard
]

{ #category : #throwing }
CardHand >> throw: cancellationCard to: aShip removing: aCard on: aCardManager [

	cancellationCard applyEffectTo: {aShip} removing: aCard on: aCardManager.
	self remove: cancellationCard
]

{ #category : #throwing }
CardHand >> throw: card toAllShipsOn: aCardManager [

	self assertCardIsInHand: card.
	card applyEffectToAllShipsOn: aCardManager by: self ship.
	self remove: card
]
