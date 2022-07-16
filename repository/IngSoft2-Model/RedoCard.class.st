Class {
	#name : #RedoCard,
	#superclass : #Card,
	#instVars : [
		'cardRepeated'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RedoCard >> = aCard [

	^ (aCard class == RedoCancellationCard) or: (self class = aCard class)
]

{ #category : #visiting }
RedoCard >> accept: aCardManager [

	self fetchCardToRedoFrom: aCardManager.
	^ cardRepeated accept: aCardManager
]

{ #category : #action }
RedoCard >> assertIsValid: sourceShip on: cardManager [

	cardRepeated assertIsValid: sourceShip on: cardManager
]

{ #category : #accessing }
RedoCard >> cardRepeated [
	^cardRepeated 
]

{ #category : #action }
RedoCard >> fetchCardToRedoFrom: aCardManager [

	| aCard |
	aCard := aCardManager lastCardThrownOnTheGame.
	(aCard = self) ifTrue: [ aCard := aCard cardRepeated ].
	cardRepeated := aCard
]
