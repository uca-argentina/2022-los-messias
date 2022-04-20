Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfLockers',
		'positionOfShips'
	],
	#classInstVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertValid: numberOfLockers [

	numberOfLockers >= 2 ifFalse: [ 
		Error signal: 'Zathura cannot be played with a board with less than two lockers' ]
]

{ #category : #initialization }
Board class >> withLockers: aNumberOfLockers withShips: aCollectionOfShips [
	self assertValid: aNumberOfLockers.
	^self new initializeWithLockers: aNumberOfLockers withShips: aCollectionOfShips  .
]

{ #category : #initialization }
Board >> didShipCrossFinishLine: aNewPosition [

	^aNewPosition  >= numberOfLockers

]

{ #category : #initialization }
Board >> initializeWithLockers: aNumberOfLockers withShips: aCollectionOfShips [
	numberOfLockers := aNumberOfLockers.
	positionOfShips := Dictionary new.
	aCollectionOfShips do:  [ :aShip | positionOfShips at: aShip put: 0].
]

{ #category : #moving }
Board >> movesShip: aShip lockers: aNumberOfLockers [

	| actualPosition newPosition checkIfShipWon |
	actualPosition := positionOfShips at: aShip.
	newPosition := actualPosition + aNumberOfLockers.
	checkIfShipWon := (self didShipCrossFinishLine: newPosition ).
	checkIfShipWon
		ifTrue: [ positionOfShips at: aShip put: numberOfLockers ]
		ifFalse: [ positionOfShips at: aShip put: newPosition ].
	^checkIfShipWon
]

{ #category : #initialization }
Board >> positionOfShip: aShip [

	^ positionOfShips at: aShip 
]
