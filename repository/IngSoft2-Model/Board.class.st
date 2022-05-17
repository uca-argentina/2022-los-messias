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
		'positionOfShips',
		'positionHandler',
		'boardStructure'
	],
	#classInstVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertValid: lockers [

	lockers size >= 2 ifFalse: [ 
		Error signal: 'Board cannot be created with less than two lockers' ]
]

{ #category : #'instance creation' }
Board class >> of: boardStructure withAll: aCollectionOfShips [

	self assertValid: boardStructure lockers.
	^ self new
		  initializeWith: boardStructure
		  withAGroupOf: aCollectionOfShips
]

{ #category : #'accessing - attributes' }
Board >> AllNameOfShips [

	| ships |
	ships := OrderedCollection new.
	positionOfShips do: [ :aShip | ships add: aShip ship ].
	^ ships
]

{ #category : #accesing }
Board >> boardStructure [
	^ boardStructure
]

{ #category : #moving }
Board >> correctPositionIfShipWon: aShip [

	(self hasCrossFinishLine: aShip) ifTrue: [ 
		self
			remove: (self spaceshipPositionOf: aShip)
			add: (positionHandler moveToFinalPosition:
					 (self spaceshipPositionOf: aShip)) ]
]

{ #category : #moving }
Board >> hasCrossFinishLine: aShip [

	| positionOfShip |
	positionOfShip := self spaceshipPositionOf: aShip.
	^ positionOfShip numberOfLap >= boardStructure laps
]

{ #category : #initialization }
Board >> initializeWith: aBoardStructure withAGroupOf: aCollectionOfShips [

	boardStructure := aBoardStructure.
	positionHandler := PositionHandler with: aBoardStructure lockers size.
	self load: aCollectionOfShips
]

{ #category : #private }
Board >> load: aCollectionOfShips [

	positionOfShips := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		positionOfShips add: (SpaceshipPosition for: aShip at: 0 and: 0) ]
]

{ #category : #moving }
Board >> move: aShip by: aNumberOfLockers [

	self moving: aShip lockers: aNumberOfLockers.
	self correctPositionIfShipWon: aShip
]

{ #category : #private }
Board >> moving: aShip lockers: aNumberOfLockers [

	| oldPosition newPosition |
	oldPosition := self spaceshipPositionOf: aShip.
	newPosition := positionHandler
		               createNewPositionOf: oldPosition
		               by: aNumberOfLockers.
	self remove: oldPosition add: newPosition.
]

{ #category : #'accessing - attributes' }
Board >> numberOfLockerOf: aShip [

	^ (self spaceshipPositionOf: aShip) numberOfLocker 
]

{ #category : #private }
Board >> playTurnOnBoard: aShip by: aNumberOfLockers [

	self move: aShip by: aNumberOfLockers.
	(boardStructure lockers at: (self numberOfLockerOf: aShip) + 1)
		action: aShip
		on: self
]

{ #category : #ranking }
Board >> rankingOf: aShip [

	^ self shipsSortedByPosition indexOf: aShip
]

{ #category : #private }
Board >> remove: positionOfShip add: newPosition [

	positionOfShips removeAllSuchThat: [ :shipPosition | 
		shipPosition == positionOfShip ].
	positionOfShips add: newPosition
]

{ #category : #ranking }
Board >> shipsSortedByPosition [

	^ self sortedShipPositions collect: [ :position | position ship ]
]

{ #category : #ranking }
Board >> sortedShipPositions [

	^positionOfShips  sort: [ :positionA :positionB | 
		  positionA > positionB ]
]

{ #category : #'accessing - attributes' }
Board >> spaceshipPositionOf: aShip [

	| positionOfShip |
	positionOfShip := positionOfShips select: [ :aPositionOfShip | 
		          aPositionOfShip ship == aShip ].

	^ positionOfShip at: 1
]
