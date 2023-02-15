Class {
	#name : #ActiveCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'ship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
ActiveCard class >> with: card appliedTo: ship [

	^ self new initializeWith: card appliedTo: ship
]

{ #category : #comparing }
ActiveCard >> = activeCard [

	^ self ship = activeCard ship and: [ 
		  self card class = activeCard card class ]
]

{ #category : #accessing }
ActiveCard >> card [
	^ card
]

{ #category : #accessing }
ActiveCard >> changeOfRoll [ 

^card changeOfRoll.
]

{ #category : #initialization }
ActiveCard >> initializeWith: aCard appliedTo: aShip [
	card := aCard.
	ship := aShip 
]

{ #category : #accessing }
ActiveCard >> ship [
	^ ship
]
