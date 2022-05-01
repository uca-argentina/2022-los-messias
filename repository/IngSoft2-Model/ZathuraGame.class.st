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

{ #category : #initialization }
ZathuraGame class >> withShips: aNumberOfShips withNumberOfLockers: aNumberOfLockers withDiceCup: aDiceCup [

	self assertNumberOfShipsIsValid: aNumberOfShips.
	^ self new
		  initializeWithShips: aNumberOfShips
		  withNumberOfLockers: aNumberOfLockers
		  withDiceCup: aDiceCup
]

{ #category : #playing }
ZathuraGame >> finishingTheGame: aShip [

	^ [ 
	  winner := aShip.
	  self end ]
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initialization }
ZathuraGame >> initializeWithShips: aCollectionOfShips withNumberOfLockers: aNumberOfLockers withDiceCup: aDiceCup [

	diceCup := aDiceCup.
	board := Board of: aNumberOfLockers withAll:aCollectionOfShips.
	ships := aCollectionOfShips
]

{ #category : #playing }
ZathuraGame >> play [

	finished := false.

	[ finished ] whileFalse: [ 
		ships do: [ :aShip | 
			finished ifFalse: [ 
				board move: aShip by: diceCup roll.
				(board didShipCrossFinishLine: aShip) ifTrue:
					(self finishingTheGame: aShip) ] ] ]
]

{ #category : #positioning }
ZathuraGame >> positionOfShip: aShip [ 
	^board positionOfShip: aShip
]

{ #category : #ending }
ZathuraGame >> winner [
	^ winner.
]
