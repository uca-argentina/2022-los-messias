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
		'numberOfLaps',
		'lockersGame',
		'lockers',
		'positionHandler'
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
Board class >> of: lockers and: laps withAll: aCollectionOfShips [

	self assertValid: lockers.
	^ self new
		  initializeWith: lockers
		  and: laps
		  withAGroupOf: aCollectionOfShips
]

{ #category : #moving }
Board >> hasCrossFinishLine: aShip [

	| positionOfShip |
	positionOfShip := self spaceshipPositionOf: aShip.
	^ positionOfShip numberOfLap >= numberOfLaps
]

{ #category : #initialization }
Board >> initializeWith: theLockers and: laps withAGroupOf: aCollectionOfShips [

	lockersGame := theLockers.
	lockers := theLockers size.
	positionHandler := PositionHandler with: lockers.
	numberOfLaps := laps.
	positionOfShips := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		positionOfShips add: (SpaceshipPosition for: aShip at: 0 and: 0) ]
]

{ #category : #moving }
Board >> move: aShip by: aNumberOfLockers [

	| oldPosition newPosition |
	oldPosition := self spaceshipPositionOf: aShip.
	newPosition := positionHandler
		               createNewPositionOf: oldPosition
		               by: aNumberOfLockers.
	self remove: oldPosition add: newPosition.
	(self hasCrossFinishLine: aShip) ifTrue: [ 
		self
			remove: newPosition
			add: (positionHandler moveToFinalPosition: newPosition) ]
]

{ #category : #'accessing - attributes' }
Board >> numberOfLapOf: aShip [

	^ (self spaceshipPositionOf: aShip) numberOfLap 
]

{ #category : #'accessing - attributes' }
Board >> numberOfLockerOf: aShip [

	^ (self spaceshipPositionOf: aShip) numberOfLocker 
]

{ #category : #moving }
Board >> playTurnOnBoard: aShip by: aNumberOfLockers [

	self move: aShip by: aNumberOfLockers.
	(lockersGame at: (self numberOfLockerOf: aShip) + 1)
		action: positionOfShips
		triggeredBy: aShip
		on: self
]

{ #category : #ranking }
Board >> rankingOf: aShip [

	^ self shipsSortedByPosition indexOf: aShip
]

{ #category : #moving }
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
