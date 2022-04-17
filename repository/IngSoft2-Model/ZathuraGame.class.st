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
ZathuraGame class >> assertNumberOfDieInCupDiceIsValid: aDiceCup [

	(aDiceCup roll) > 0 ifFalse: [ Error signal: 'Zathura cannot be played with an empty dice cup' ]
]

{ #category : #asserting }
ZathuraGame class >> assertNumberOfShipsIsValid: aNumberOfShips [

	aNumberOfShips >= 2 ifFalse: [ Error signal: 'Zathura cannot be played with less than two players' ]
]

{ #category : #initialization }
ZathuraGame class >> withShips: aNumberOfShips withNumberOfLockers: aNumberOfLockers withDiceCup: aDiceCup [

	self assertNumberOfShipsIsValid: aNumberOfShips.
	self assertNumberOfDieInCupDiceIsValid: aDiceCup.
	^ self new
		  initializeWithShips: aNumberOfShips
		  withNumberOfLockers: aNumberOfLockers
		  withDiceCup: aDiceCup
]

{ #category : #ending }
ZathuraGame >> end [
	finished := true.
]

{ #category : #getters }
ZathuraGame >> getPositionOfShip: anId [ 
	| ship |
	ship := (ships select: [ :aShip | aShip getId == anId ]).
	^ (ship at: 1) isInPosition 
]

{ #category : #ending }
ZathuraGame >> getWinner [
	^ winner.
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initialization }
ZathuraGame >> initializeWithShips: aNumberOfShips withNumberOfLockers: aNumberOfLockers withDiceCup: aDiceCup [

	diceCup := aDiceCup.
	board := Board with: aNumberOfLockers.
	ships := OrderedCollection new.
	1 to: aNumberOfShips do: [ :i | ships add: (Ship with: i) ]
]

{ #category : #starting }
ZathuraGame >> start [

	| i shipPlaying |
	finished := false.

	i := 0.
	[ finished == false ] whileTrue: [ 
		i := i % ships size + 1.
		shipPlaying := ships at: i.
		shipPlaying playsWith: diceCup in: board.

		(board didShipCrossFinishLine: shipPlaying) ifTrue: [ winner := shipPlaying. self end ].

		i := i + 1 ]
]
