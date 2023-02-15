Class {
	#name : #CardsOnTable,
	#superclass : #Object,
	#instVars : [
		'cardsOnTable',
		'thrownCardsStack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardsOnTable class >> initalizeNew [

	^ self new initalizeNew .
]

{ #category : #actions }
CardsOnTable >> addCardToTable: aCard [ 
	cardsOnTable add: aCard.
	self addToTheCardsStack: aCard card
]

{ #category : #actions }
CardsOnTable >> addToTheCardsStack: aCard [ 
	thrownCardsStack add: aCard.
]

{ #category : #assertions }
CardsOnTable >> assertCardHasBeenThrown [
		thrownCardsStack ifEmpty: [ 
		Error signal:
			'Redo card must be thrown before another card has been played' ]
]

{ #category : #asserting }
CardsOnTable >> assertIsOnTable: aCard [ 
		aCard ifEmpty: [ 
		Error signal: 'This card is not active in the table' ]
]

{ #category : #private }
CardsOnTable >> cardsAffecting: aShip [

	^cardsOnTable select: [ :aCard | aCard ship includes: aShip ]
]

{ #category : #accessing }
CardsOnTable >> findCardOnTable: aCard [ 
		| theCard |
	theCard := cardsOnTable select: [ :card | card = aCard ].
	self assertIsOnTable: theCard.
	^ theCard first
]

{ #category : #private }
CardsOnTable >> initalizeNew [

	cardsOnTable := OrderedCollection new.
	thrownCardsStack := OrderedCollection new.
]

{ #category : #actions }
CardsOnTable >> lastCardThrownOnTheGame [
	self assertCardHasBeenThrown.
	^ thrownCardsStack last
]

{ #category : #actions }
CardsOnTable >> remove: aCard [ 
	cardsOnTable remove: aCard.
]

{ #category : #actions }
CardsOnTable >> rollChangeOf: aShip [ 
	^(self cardsAffecting: aShip) sum: [ :aCard |  aCard changeOfRoll ].
]
