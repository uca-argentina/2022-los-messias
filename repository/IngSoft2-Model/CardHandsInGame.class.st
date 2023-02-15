Class {
	#name : #CardHandsInGame,
	#superclass : #Object,
	#instVars : [
		'cardHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandsInGame class >> with: aCollectionOfShips [
	^self new initializeWith: aCollectionOfShips.
]

{ #category : #accessing }
CardHandsInGame >> cardHandOf: aShip [ 
	^ (cardHands select: [ :aCardHand | aCardHand ship = aShip ]) first
]

{ #category : #actions }
CardHandsInGame >> giveCard: aCard to: aShip [ 
	| cardHand |
	cardHand:= ((cardHands select: [ :aCardHand | aCardHand ship  == aShip ] )first) .
	cardHand add: aCard.
]

{ #category : #initialization }
CardHandsInGame >> initializeWith: aCollectionOfShips [

	cardHands := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		cardHands add: (CardHand of: aShip )].
]
