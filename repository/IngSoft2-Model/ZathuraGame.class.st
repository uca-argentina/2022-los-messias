"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
!
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	board:		<Object>
	diceCup:		<Object>
	finished:		<Object>
	ships:		<Object>
	winner:		<Object>


    Implementation Points
"
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

{ #category : #'instance creation' }
ZathuraGame class >> playBy: ships movedInBoardOf: lockers and: laps rolling: die [

	self assertNumberOfShipsIsValid: ships.
	^ self new initializePlayingBy: ships movedInBoardOf: lockers and: laps rolling: die
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasFinished [

	finished ifFalse: [ Error signal: 'Zathura has not finished yet' ]
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasNotBeenPlayed [

	finished ifTrue: [ 
		Error signal: 'Zathura cannot be played more than once' ]
]

{ #category : #private }
ZathuraGame >> changeActivePlayer [

	| aShip |
	aShip := ships removeFirst.
	ships addLast: aShip
]

{ #category : #private }
ZathuraGame >> checkIfWon: aShip [
	(board hasCrossFinishLine: aShip) ifTrue: [ 
		winner := aShip.
		finished := true ]
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initialization }
ZathuraGame >> initializePlayingBy: aCollectionOfShips movedInBoardOf: lockers and: aNumberOfLaps rolling: aDiceCup [

	diceCup := aDiceCup.
	board := Board
		         of: lockers
		         and: aNumberOfLaps
		         withAll: aCollectionOfShips.
	ships := aCollectionOfShips.
	finished := false
]

{ #category : #positioning }
ZathuraGame >> numberOfLapsOf: aShip [

	^ board numberOfLapsOf:  aShip
]

{ #category : #playing }
ZathuraGame >> play [

	self assertZathuraHasNotBeenPlayed.

	[ finished ] whileFalse: [ self playTurn ]
]

{ #category : #playing }
ZathuraGame >> playTurn [

	| aShip |
	self assertZathuraHasNotBeenPlayed.
	aShip := ships at: 1.
	board move: aShip by: diceCup roll.
	self checkIfWon: aShip.
	self changeActivePlayer.
]

{ #category : #positioning }
ZathuraGame >> positionOfShipOnBoard: aShip [

	^ board numberOfLockersOf: aShip
]

{ #category : #positioning }
ZathuraGame >> rankingOf: aShip [

	^ (board rankingOf: aShip).
]

{ #category : #ending }
ZathuraGame >> winner [
	self assertZathuraHasFinished.
	^ winner
]
