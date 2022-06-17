Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'deck',
		'cardHands',
		'cardsOnTable',
		'thrownCardsStack'
	],
	#classInstVars : [
		'cardHands',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> with: aCollectionOfShips and: aCollectionOfCards [

	^self new initializeWith: aCollectionOfShips and: aCollectionOfCards.

]

{ #category : #initialization }
CardManager >> initializeCardHandsBy: aCollectionOfShips [
	cardHands := OrderedCollection new. 
	aCollectionOfShips do: [ :aShip | 
		cardHands add: (CardHand of: aShip with: { 
					 deck next.
					 deck next }) ].
	^cardHands 
]

{ #category : #initialization }
CardManager >> initializeWith: aCollectionOfShips and: aCollectionOfCards [

	deck := aCollectionOfCards asOrderedCollection asSequence.
	cardHands := self initializeCardHandsBy: aCollectionOfShips.
	cardsOnTable := OrderedCollection new.
	thrownCardsStack := OrderedCollection new
]
