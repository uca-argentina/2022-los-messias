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
		'cardGenerator',
		'shipsWithHandOfCards',
		'aDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ZathuraGame class >> assertNumberOfShipsIsValid: aCollectionOfShips [

	aCollectionOfShips size >= 2 ifFalse: [ Error signal: 'Zathura cannot be played with less than two ships' ]
]

{ #category : #'instance creation' }
ZathuraGame class >> playBy: ships movedInBoardOf: boardStructure rolling: die [

	self assertNumberOfShipsIsValid: ships.
	^ self new
		  initializePlayingBy: ships
		  movedInBoardOf: boardStructure
		  rolling: die
]

{ #category : #'class initialization' }
ZathuraGame class >> playBy: ships movedInBoardOf: boardStructure rolling: die withCards: aCollectionOfCards [

	self assertNumberOfShipsIsValid: ships.
	^ self new
		  initializePlayingBy: ships
		  movedInBoardOf: boardStructure
		  rolling: die withCards: aCollectionOfCards
]

{ #category : #adding }
ZathuraGame >> addIntoGame: aCollectionOfShips [

	| collectionOfShipsWithHandOfCards |
	collectionOfShipsWithHandOfCards := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		collectionOfShipsWithHandOfCards add:
			((HandOfCards with: aShip) addAll:
				 (aDeck generate: 2)) ].
	shipsWithHandOfCards := Sequence with:
		                                  collectionOfShipsWithHandOfCards
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasFinished [

	finished ifFalse: [ Error signal: 'Zathura has not finished yet' ]
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasNotBeenPlayed [

	timesPlayed = 1 ifTrue: [ 
		Error signal: 'Zathura cannot be played more than once' ]
]

{ #category : #accessing }
ZathuraGame >> cardsOf: spaceship [
 
	^{1. 2}
]

{ #category : #private }
ZathuraGame >> checkIfWon: aShip [

	(board hasCrossFinishLine: (aShip name)) ifFalse: [ ^ self ].
	timesPlayed := 1.
	finished := true
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initalization }
ZathuraGame >> initializePlayingBy: aCollectionOfShips movedInBoardOf: boardStructure rolling: aDiceCup withCards: aCollectionOfCards [ 
	| shipPlayer |
	diceCup := aDiceCup.
	board := Board of: boardStructure withAll: aCollectionOfShips.
	aDeck:= Deck withAll: aCollectionOfCards.
	self addIntoGame: aCollectionOfShips.
	finished := false.
	timesPlayed := 0
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
	aShip := shipsWithHandOfCards value.
	board changePositionOf: aShip name by: ((diceCup roll) + (aShip changeOfRoll)).
	self checkIfWon: aShip.
	shipsWithHandOfCards next
]

{ #category : #positioning }
ZathuraGame >> rankingOf: aShip [

	^ board rankingOf: aShip.
]

{ #category : #actions }
ZathuraGame >> reduceRollDiceOf: aString [ 
	self shouldBeImplemented.
]

{ #category : #actions }
ZathuraGame >> reduceRollDiceOf: aShip by: anInteger [ 
	(self shipWithHandOfCards: aShip) reduceRollBy: anInteger .
]

{ #category : #accesing }
ZathuraGame >> shipWithHandOfCards: aShip [ 
	| ship |
	ship := (shipsWithHandOfCards collection) select: [ :aShipWithHandOfCards | aShipWithHandOfCards name == aShip].
	^ ship at: 1
	
]

{ #category : #ending }
ZathuraGame >> winner [

	| winner |
	self assertZathuraHasFinished.
	winner := shipsWithHandOfCards collection select: [ :ship | 
		          (self rankingOf: ship name) == 1 ].
	^ winner at: 1
]
