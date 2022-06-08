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

{ #category : #adding }
CardHand >> addAll: cards [ 
	cards do: [ :card | handOfCards add: card ]
]

{ #category : #asserting }
CardHand >> assertCardIsInHand: aCard [

	(handOfCards anySatisfy: [ :card | aCard isMemberOf: (card class) ]) 
		ifFalse: [ Error signal: 'Card is not in Hand' ]
]

{ #category : #attributes }
CardHand >> cards [

	^ handOfCards 
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
CardHand >> throw: card to: ship in: zathuraGame [

	self assertCardIsInHand: card.
	card applyEffectTo: ship in: zathuraGame.
	self remove: card
]
