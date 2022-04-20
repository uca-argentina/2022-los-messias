Class {
	#name : #ZathuraGame,
	#superclass : #Object,
	#instVars : [
		'finished',
		'diceCup',
		'board',
		'ships',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ZathuraGame class >> assertNumberOfShipsIsValid: aCollectionOfShips [

	aCollectionOfShips size >= 2 ifFalse: [ Error signal: 'Zathura cannot be played with less than two ships' ]
]

{ #category : #initialization }
ZathuraGame class >> withShips: aNumberOfShips withNumberOfLockers: aNumberOfLockers withDiceCup: aDiceCup [

	self assertNumberOfShipsIsValid: aNumberOfShips.
	^ self new
		  initializeWithShips: aNumberOfShips
		  withNumberOfLockers: aNumberOfLockers
		  withDiceCup: aDiceCup
]

{ #category : #ending }
ZathuraGame >> end [
	finished := true.
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initialization }
ZathuraGame >> initializeWithShips: aCollectionOfShips withNumberOfLockers: aNumberOfLockers withDiceCup: aDiceCup [

	diceCup := aDiceCup.
	board := Board withLockers: aNumberOfLockers withShips:aCollectionOfShips.
	ships := aCollectionOfShips
]

{ #category : #positioning }
ZathuraGame >> positionOfShip: aShip [ 
	^board positionOfShip: aShip
]

{ #category : #starting }
ZathuraGame >> start [

	| shipPlaying |
	finished := false.

	[ finished not ] whileTrue: [ 
		ships do: [ :aShip | finished ifFalse: [(board movesShip: aShip lockers: diceCup roll) ifTrue: [ winner := aShip. self end ] ] ]

	]
]

{ #category : #ending }
ZathuraGame >> winner [
	^ winner.
]
