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

{ #category : #action }
CardHand >> using: cancellationCard toCard: overloadCard in: zathuraGame [ 
"Esto rompe si hay más de una OverLoad en el tablero, vamos a tener que identificar al ship en algunos casos y en otros no. El nombre applyEffectToACard: desp hay que cambiarlo"
	cancellationCard applyEffectToACard: overloadCard in: zathuraGame
]
