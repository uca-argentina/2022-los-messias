Class {
	#name : #ZathuraShip,
	#superclass : #Object,
	#instVars : [
		'ship',
		'cardHand',
		'changeOfRoll'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ZathuraShip class >> with: ship and: cardHand [

	^ self new initializeWith: ship and: cardHand
]

{ #category : #accessing }
ZathuraShip >> cardsOf: aCard [ 
	^ cardHand cardsOf: aCard
]

{ #category : #accessing }
ZathuraShip >> changeOfRoll [
	^ changeOfRoll
]

{ #category : #accesing }
ZathuraShip >> changeRolBy: integer [

	changeOfRoll := changeOfRoll + integer
]

{ #category : #initialization }
ZathuraShip >> initializeWith: aShip and: aCardHand [

	ship := aShip.
	cardHand := aCardHand.
	changeOfRoll := 0
]

{ #category : #accesing }
ZathuraShip >> ship [
	^ ship
]

{ #category : #action }
ZathuraShip >> throw: card to: aShip in: zathuraGame [ 

	cardHand throw: card to: aShip in: zathuraGame.
]
