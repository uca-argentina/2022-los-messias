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
		'parsecsPerLocker',
		'boardDefinition'
	],
	#classInstVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> of: boardStructure withAll: aCollectionOfShips [

	^ self new
		  initializeWith: boardStructure
		  withAGroupOf: aCollectionOfShips
]

{ #category : #private }
Board >> addIntoGame: aCollectionOfShips [

	positionOfShips := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		positionOfShips add: (SpaceshipPosition for: aShip at: 0 and: 0) ]
]

{ #category : #moving }
Board >> changePositionOf: aShip by: aNumberOfLockers [

	self move: aShip by: aNumberOfLockers.
	boardDefinition doEffectTo: aShip inPosition: (self numberOfLockerOf:aShip) of: self  
]

{ #category : #private }
Board >> correctPositionIfFinishLineWasCrossedBy: aShip [

	(self hasCrossFinishLine: aShip) ifTrue: [ 
		positionOfShips
			at: (positionOfShips indexOf: (self positionOf: aShip))
			put:
			(positionHandler moveToFinalPosition: (self positionOf: aShip))]
]

{ #category : #moving }
Board >> hasCrossFinishLine: aShip [

	| positionOfShip |
	positionOfShip := self positionOf: aShip.
	^ positionOfShip numberOfLap >= boardDefinition laps
]

{ #category : #initialization }
Board >> initializeWith: aBoardStructure withAGroupOf: aCollectionOfShips [

	boardDefinition := aBoardStructure.
	positionHandler := PositionHandler with: aBoardStructure lockers size.
	parsecsPerLocker := boardDefinition parsecsPerLocker.
	self addIntoGame: aCollectionOfShips
]

{ #category : #private }
Board >> move: aShip by: aNumberOfLockers [

	self moving: aShip lockers: aNumberOfLockers.
	self correctPositionIfFinishLineWasCrossedBy: aShip
]

{ #category : #private }
Board >> move: aShip byParsecs: numberOfParsecs [

	self move: aShip by: (numberOfParsecs * parsecsPerLocker) asInteger
]

{ #category : #private }
Board >> moveAllExcept: aShip by: aNumberOfLockers [

	| ships |
	ships := self shipsInGame copyWithout: aShip.
	ships do: [ :ship | self move: ship by: aNumberOfLockers * -1 ]
]

{ #category : #private }
Board >> moveAllToLockerZero [

	positionOfShips do: [ :aShip | self moveToLockerZero: aShip ship ]
]

{ #category : #private }
Board >> moveToLockerZero: aShip [

self move: aShip by: ((self numberOfLockerOf: aShip) * -1 )
]

{ #category : #private }
Board >> moving: aShip lockers: aNumberOfLockers [

	| oldPosition newPosition |
	oldPosition := self positionOf: aShip.
	newPosition := positionHandler
		               newPositionOf: oldPosition
		               by: aNumberOfLockers.
	positionOfShips
		at: (positionOfShips indexOf: oldPosition)
		put: newPosition
]

{ #category : #'accessing - attributes' }
Board >> numberOfLockerOf: aShip [

	^ (self positionOf: aShip) numberOfLocker 
]

{ #category : #attributes }
Board >> parsecsPerLocker [
	^ parsecsPerLocker
]

{ #category : #'accessing - attributes' }
Board >> positionOf: aShip [

	| positionOfShip |
	positionOfShip := positionOfShips select: [ :aPositionOfShip | 
		                  aPositionOfShip ship == aShip ].

	^ positionOfShip removeFirst
]

{ #category : #ranking }
Board >> rankingOf: aShip [

	^ self shipsSortedByPosition indexOf: aShip
]

{ #category : #'accessing - attributes' }
Board >> shipsInGame [

	| ships |
	ships := OrderedCollection new.
	positionOfShips do: [ :aShip | ships add: aShip ship ].
	^ ships
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
