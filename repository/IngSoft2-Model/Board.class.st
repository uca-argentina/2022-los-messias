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
	numberOfLockers:		<Object>
	positionOfShips:		<Object>


    Implementation Points
"
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
Board >> didShipCrossFinishLine: aShip [

	| shipCrossFinishLine |
	shipCrossFinishLine := false.
	(positionOfShips at: aShip) >= numberOfLockers ifTrue: [ 
		positionOfShips at: aShip put: numberOfLockers.
		shipCrossFinishLine := true ].
	^ shipCrossFinishLine
]

{ #category : #initialization }
Board >> initializeWithLockers: aNumberOfLockers withShips: aCollectionOfShips [

	numberOfLockers := aNumberOfLockers.
	positionOfShips := Dictionary new.
	aCollectionOfShips do:
		self initializingPositionOfShipsWithAllShipsAtPositionZero
]

{ #category : #methods }
Board >> initializingPositionOfShipsWithAllShipsAtPositionZero [

	^ [ :aShip | positionOfShips at: aShip put: 0 ]
]

{ #category : #moving }
Board >> movesShip: aShip lockers: aNumberOfLockers [

	| actualPosition newPosition |
	actualPosition := positionOfShips at: aShip.
	newPosition := actualPosition + aNumberOfLockers.
	positionOfShips at: aShip put: newPosition.
	^ self didShipCrossFinishLine: aShip
]

{ #category : #initialization }
Board >> positionOfShip: aShip [

	^ positionOfShips at: aShip 
]
