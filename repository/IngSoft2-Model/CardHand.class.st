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

{ #category : #asserting }
CardHand >> assertCardIsInHand: aCard [

	(handOfCards anySatisfy: [ :card | aCard isMemberOf: (card class) ]) 
		ifFalse: [ Error signal: 'Card is not in Hand' ]
]

{ #category : #accesing }
CardHand >> cardsOf: aCard [

	| cards |
	cards := handOfCards select: [ :card | aCard isMemberOf: card class ].
	^ cards size
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

{ #category : #throwing }
CardHand >> using: card toAllShipsin: zathuraGame [

	self assertCardIsInHand: card.
	card applyEffectToAllShipsIn: zathuraGame.
	self remove: card
]
