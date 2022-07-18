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

	(handOfCards anySatisfy: [ :card | aCard = card]) 
		ifFalse: [ Error signal: 'Card is not in Hand' ]
]

{ #category : #initalization }
CardHand >> initializeCardHandOf: aShip with: cards [ 
	handOfCards := cards asOrderedCollection.
	ship:= aShip
]

{ #category : #action }
CardHand >> remove: aCard [

	| cards |
	self assertCardIsInHand: aCard.
	cards := handOfCards do: [ :card | card = aCard ].
	handOfCards remove: cards first
]

{ #category : #'accessing - attributes' }
CardHand >> ship [
	^ ship
]
