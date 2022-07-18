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
		'cardApplicator',
		'turnEffectApplicator'
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

{ #category : #asserting }
ZathuraGame >> assertZathuraHasFinished [

	finished ifFalse: [ Error signal: 'Zathura has not finished yet' ]
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasNotFinished [

	finished == true ifTrue: [ Error signal: 'Zathura has been already played' ]
]

{ #category : #accessing }
ZathuraGame >> checkIfWon: aShip [

	(board hasCrossFinishLine: aShip) ifTrue: [ 
		finished := true ]
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initalization }
ZathuraGame >> initializePlayingBy: aCollectionOfShips movedInBoardOf: boardStructure rolling: aDiceCup withCards: aCollectionOfCards [

	diceCup := aDiceCup.
	turnEffectApplicator := TurnApplicator with: aCollectionOfShips.

	cardApplicator := CardApplicator
		                  with: turnEffectApplicator
		                  and: aCollectionOfCards.
	board := Board
		         of: boardStructure
		         withAll: aCollectionOfShips asOrderedCollection
		         and: cardApplicator.
	
	cardApplicator load: board.

	finished := false
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
	self assertZathuraHasNotFinished.
	[ finished ] whileFalse: [ self playTurn ]
]

{ #category : #playing }
ZathuraGame >> playTurn [

	| aShip |
	self assertZathuraHasNotFinished.
	aShip := turnEffectApplicator next.
	board changePositionOf: aShip with: diceCup.
	self checkIfWon: aShip
]

{ #category : #positioning }
ZathuraGame >> rankingOf: aShip [

	^ board rankingOf: aShip.
]

{ #category : #action }
ZathuraGame >> throws: aCard [

	self assertZathuraHasNotFinished.
	cardApplicator throws: aCard
]

{ #category : #accessing }
ZathuraGame >> winner [

	self assertZathuraHasFinished.
	^ turnEffectApplicator ships detect: [ :ship | (self rankingOf: ship) == 1 ]
]
