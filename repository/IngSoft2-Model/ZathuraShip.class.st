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

{ #category : #actions }
ZathuraShip >> addCardToHand: aCard [
	cardHand add: aCard.
]

{ #category : #asserting }
ZathuraShip >> assertIsYourTurn: aShip in: zathuraGame [

	(zathuraGame isTurnOf: aShip) ifFalse: [ Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #accessing }
ZathuraShip >> cardsOf [

	^ cardHand cardsOf
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
ZathuraShip >> changeRollBy: integer [

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

{ #category : #actions }
ZathuraShip >> using: aCancellationCard removing: aCard in: aZathuraGame [ 
			cardHand
		using: aCancellationCard
		to: ''
		removing: aCard
		in: aZathuraGame
]

{ #category : #action }
ZathuraShip >> using: card to: aShip in: zathuraGame [

	self assertIsYourTurn: (self ship) in: zathuraGame.
	cardHand using: card to: aShip in: zathuraGame
]

{ #category : #action }
ZathuraShip >> using: aCancellationCard to: aShip removing: anOverloadCard in: zathuraGame [

	cardHand
		using: aCancellationCard
		to: aShip
		removing: anOverloadCard
		in: zathuraGame
]

{ #category : #action }
ZathuraShip >> using: card toAllShipsin: zathuraGame [

	self assertIsYourTurn: self ship in: zathuraGame.
	cardHand using: card toAllShipsin: zathuraGame
]
