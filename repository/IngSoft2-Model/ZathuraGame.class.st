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
		'timesPlayed',
		'ships',
		'shipsHand',
		'cardManager',
		'cardApplicator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ZathuraGame class >> assertNumberOfShipsIsValid: aCollectionOfShips [

	aCollectionOfShips size >= 2 ifFalse: [ Error signal: 'Zathura cannot be played with less than two ships' ]
]

{ #category : #'instance creation' }
ZathuraGame class >> playBy: ships movedInBoardOf: boardStructure rolling: die withCards: cards [

	self assertNumberOfShipsIsValid: ships.
	^ self new
		  initializePlayingBy: ships
		  movedInBoardOf: boardStructure
		  rolling: die
		  withCards: cards
]

{ #category : #private }
ZathuraGame >> applyLastEffectOn: aShip [ 
	board applyLastEffectOn: (aShip).
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasFinished [

	finished ifFalse: [ Error signal: 'Zathura has not finished yet' ]
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasNotBeenPlayed [

	(timesPlayed == 1) ifTrue: [ 
		Error signal: 'Zathura cannot be played more than once' ]
]

{ #category : #accessing }
ZathuraGame >> cardApplicator [

	^ cardApplicator
]

{ #category : #accessing }
ZathuraGame >> checkIfWon: aShip [

	(board hasCrossFinishLine: aShip) ifTrue: [ 
	timesPlayed := 1.
	finished := true ].
]

{ #category : #ending }
ZathuraGame >> findWinnerShip [

	| winnerShip winner |
	winner := ships select: [ :ship | (self rankingOf: ship) == 1 ].
	winnerShip := winner at: 1.
	^ winnerShip
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initalization }
ZathuraGame >> initializePlayingBy: aCollectionOfShips movedInBoardOf: boardStructure rolling: aDiceCup withCards: aCollectionOfCards [

	diceCup := aDiceCup.
	cardManager := CardManager
		               with: aCollectionOfShips
		               and: aCollectionOfCards
		               from: self.
	ships := aCollectionOfShips asOrderedCollection asSequence.
	cardApplicator := CardApplicator with: cardManager.
	board := Board
		         of: boardStructure
		         withAll: ships
		         withCards: aCollectionOfCards
		         andCardManager: cardManager.

	finished := false.
	timesPlayed := 0
]

{ #category : #accessing }
ZathuraGame >> isTurnOf: aShip [

	^ ((ships first) == aShip)
]

{ #category : #positioning }
ZathuraGame >> numberOfLapOf: aShip [

	^ (board positionOf: aShip) numberOfLap 
]

{ #category : #positioning }
ZathuraGame >> numberOfLockerOf: aShip [

	^ board numberOfLockerOf: aShip
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
	aShip := ships next.
	board
		changePositionOf: aShip
		by: diceCup roll + (cardManager findChangeOfRoll: aShip).
	self checkIfWon: aShip
]

{ #category : #positioning }
ZathuraGame >> rankingOf: aShip [

	^ board rankingOf: aShip.
]

{ #category : #accessing }
ZathuraGame >> ships [

	^ ships
]

{ #category : #ending }
ZathuraGame >> winner [

	self assertZathuraHasFinished.
	^ self findWinnerShip
]
