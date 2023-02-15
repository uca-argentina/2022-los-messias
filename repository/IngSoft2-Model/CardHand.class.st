Class {
	#name : #CardHand,
	#superclass : #Object,
	#instVars : [
		'handOfCards',
		'ship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHand class >> of: aShip [ 
	^self new initializeCardHandOf: aShip with: {  }.
]

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

	(handOfCards anySatisfy: [ :card | aCard = card ]) 
		ifFalse: [ Error signal: 'Card is not in Hand' ]
]

{ #category : #initalization }
CardHand >> initializeCardHandOf: aShip with: cards [ 
	handOfCards := cards asOrderedCollection.
	ship:= aShip
]

{ #category : #private }
CardHand >> remove: aCard [

	| cards |
	cards := handOfCards select: [ :card | card = aCard ].
	handOfCards remove: cards first
]

{ #category : #'accessing - attributes' }
CardHand >> ship [
	^ ship
]

{ #category : #throwing }
CardHand >> throw: aCancelationCard removingToAll: aCard on: aZathuraGame [

	aCancelationCard
		applyEffectTo: aZathuraGame  ships
		removing: aCard
		on: aZathuraGame .
	self remove: aCancelationCard
]

{ #category : #throwing }
CardHand >> throw: aCard to: aShip on: aZathuraGame [

	self assertCardIsInHand: aCard.
	aCard applyEffectTo: aShip on: aZathuraGame  by: self ship.
	self remove: aCard
]

{ #category : #throwing }
CardHand >> throw: cancellationCard to: aShip removing: aCard on: aZathuraGame [

	cancellationCard
		applyEffectTo: { aShip }
		removing: aCard
		on: aZathuraGame 
		.
	self remove: cancellationCard
]

{ #category : #throwing }
CardHand >> throw: card toAllShipsOn: aZathuraGame [

	self assertCardIsInHand: card.
	card applyEffectToAllShipsOn: aZathuraGame by: self ship.
	self remove: card
]
