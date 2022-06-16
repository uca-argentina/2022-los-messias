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

	^ ((self ship = activeCard ship) and: [ 
		  self card hasEqualClass: activeCard card ])
]

{ #category : #accesing }
ActiveCard >> card [
	^ card
]

{ #category : #initialization }
ActiveCard >> changeOfRoll [ 

^card changeOfRoll.
]

{ #category : #initialization }
ActiveCard >> initializeWith: aCard appliedTo: aShip [
	card := aCard.
	ship := aShip 
]

{ #category : #accesing }
ActiveCard >> ship [
	^ ship
]
