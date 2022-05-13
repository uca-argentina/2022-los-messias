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
		'ranking',
		'lockers',
		'finalPosition'
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

{ #category : #private }
Board >> allShipPositions [

	^ self withShipLapAndLockerNumberCollect: [ :aShip :aLap :aLockerNumber | 
		  SpaceshipPosition for: aShip at: aLap and: aLockerNumber ]
]

{ #category : #initialization }
Board >> hasCrossFinishLine: aShip [

	| positionOfShip |
	positionOfShip := self spaceshipPositionOf: aShip.
	^ positionOfShip numberOfLap >= numberOfLaps
]

{ #category : #initialization }
Board >> initializeWith: theLockers and: laps withAGroupOf: aCollectionOfShips [

	lockersGame := theLockers.
	lockers := theLockers size.
	"1 to: lockers do: [ :aLocker | lockersGame add: LockerNoEffect new ]."
	numberOfLaps := laps.
	positionOfShips := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		positionOfShips add: (SpaceshipPosition for: aShip at: 0 and: 0) ].
	finalPosition := SpaceshipPosition
		                 for: 'AnImaginaryShip'
		                 at: numberOfLaps
		                 and: 0.
	ranking := OrderedCollection new.
	ranking := aCollectionOfShips
]

{ #category : #moving }
Board >> move: aShip by: aNumberOfLockers [

	| positionOfShip newPosition |
	positionOfShip := self spaceshipPositionOf: aShip.
	newPosition := positionOfShip numberOfLocker + aNumberOfLockers.
	positionOfShip
		updateLap: positionOfShip numberOfLap + (newPosition // lockers)
		andLocker: newPosition % lockers.
	positionOfShip > finalPosition ifTrue: [ 
		positionOfShip updateLap: numberOfLaps andLocker: 0 ]
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
		action: aShip
		on: self

]

{ #category : #ranking }
Board >> rankingOf: aShip [

	^ self shipsSortedByPosition indexOf: aShip
]

{ #category : #ranking }
Board >> shipsSortedByPosition [

	^ self sortedShipPositions collect: [ :position | position spaceship ]
]

{ #category : #ranking }
Board >> sortedShipPositions [

	^ self allShipPositions sort: [ :positionA :positionB | 
		  positionA > positionB ]
]

{ #category : #'accessing - attributes' }
Board >> spaceshipPositionOf: aShip [

	| result |
	result := positionOfShips select: [ :aPositionOfShip | 
		          aPositionOfShip spaceship == aShip ].

	^ result at: 1
]

{ #category : #action }
Board >> speedUp: aShip [
	self move: aShip by: 4
]

{ #category : #private }
Board >> withShipLapAndLockerNumberCollect: block [

	| lockerNumber lap |
	^ positionOfShips keys collect: [ :ship | 
		  lap := self numberOfLapOf: ship.
		  lockerNumber := self numberOfLockerOf: ship.
		  block value: ship value: lap value: lockerNumber ]
]
