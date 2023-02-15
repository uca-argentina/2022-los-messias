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
		'boardDefinition',
		'lastEffect',
		'cardManager'
	],
	#classInstVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> of: aBoardStructure withAll: aCollectionOfShips andCardManager: aCardManager [

	^ self new
		  initializeWith: aBoardStructure
		  withAGroupOf: aCollectionOfShips
		  withCardManager: aCardManager
]

{ #category : #private }
Board >> addIntoGame: aCollectionOfShips [

	positionOfShips := OrderedCollection new.
	aCollectionOfShips do: [ :aShip | 
		positionOfShips add: (ShipPosition for: aShip at: 0 and: 0) ]
]

{ #category : #private }
Board >> applyEffectOnLockerOrCorrectPositionIfShipCrossedTheFinishLine: aShip [

	| thisLocker |
	thisLocker := boardDefinition lockerAt:
		              (self numberOfLockerOf: aShip) + 1.
	lastEffect := thisLocker.
	(self hasCrossFinishLine: aShip) ifFalse: [ 
		thisLocker applyFor: aShip on: self] ifTrue: [ self correctPositionOfWinner: aShip ]
	
]

{ #category : #private }
Board >> applyEffectOnLockerOrCorrectThePositionOfWinnerTo: aShip [

	| thisLocker |
	thisLocker := boardDefinition lockerAt:
		              (self numberOfLockerOf: aShip) + 1.
	lastEffect := thisLocker.
	(self hasCrossFinishLine: aShip) ifFalse: [ 
		thisLocker applyFor: aShip on: self] ifTrue: [ self correctPositionOfWinner: aShip ]
	
]

{ #category : #moving }
Board >> applyLastEffectOn: aShip [

	lastEffect applyFor: aShip on: self
]

{ #category : #moving }
Board >> changePositionOf: aShip by: aNumberOfLockers [

	self move: aShip by: aNumberOfLockers.
	self applyEffectOnLockerOrCorrectPositionIfShipCrossedTheFinishLine: aShip
]

{ #category : #private }
Board >> correctPositionOfWinner: aShip [


		positionOfShips
			replaceAll: (self positionOf: aShip)
			with: (self moveToFinalPosition: aShip) 
]

{ #category : #private }
Board >> giveCardTo: aShip [

	cardManager addTheNextCardToHandCardOf: aShip
]

{ #category : #moving }
Board >> hasCrossFinishLine: aShip [

	| positionOfShip |
	positionOfShip := self positionOf: aShip.
	^ positionOfShip numberOfLap >= boardDefinition laps
]

{ #category : #initalization }
Board >> initializeWith: aBoardDefinition withAGroupOf: aCollectionOfShips withCardManager: aCardManager [

	boardDefinition := aBoardDefinition.
	self addIntoGame: aCollectionOfShips.
	lastEffect := LockerNoEffect new.
	cardManager := aCardManager
]

{ #category : #private }
Board >> move: aShip by: aNumberOfLockers [

	| oldPosition newPosition |
	oldPosition := self positionOf: aShip.
	newPosition := self
		               newPositionStartingAt: oldPosition
		               movingBy: aNumberOfLockers.
	positionOfShips replaceAll: oldPosition with: newPosition


]

{ #category : #private }
Board >> move: aShip byParsecs: numberOfParsecs [

	self
		move: aShip
		by: (numberOfParsecs * boardDefinition distancePerLockerAsParsecs ) floor.
]

{ #category : #private }
Board >> moveAllExcept: aShip by: aNumberOfLockers [

	| ships |
	ships := (positionOfShips collect: [ :positionOfShip | 
		          positionOfShip ship ]) copyWithout: aShip.
	ships do: [ :ship | self move: ship by: aNumberOfLockers * -1 ]
]

{ #category : #private }
Board >> moveAllShipsBackwardsExcept: aShip by: aNumberOfLockers [

	| ships |
	ships := (positionOfShips collect: [ :positionOfShip | 
		          positionOfShip ship ]) copyWithout: aShip.
	ships do: [ :ship | self move: ship by: aNumberOfLockers * -1 ]
]

{ #category : #private }
Board >> moveAllToLockerZero [

	positionOfShips do: [ :aShip | self moveToLockerZero: aShip ship ]
]

{ #category : #private }
Board >> moveToFinalPosition: aShip [

	^ ShipPosition for: aShip at: boardDefinition laps and: 0
]

{ #category : #private }
Board >> moveToLockerZero: aShip [

self move: aShip by: ((self numberOfLockerOf: aShip) * -1 )
]

{ #category : #private }
Board >> newPositionStartingAt: oldPosition movingBy: aNumberOfLockers [

	| newNumberOfLockers aLap aLocker |
	newNumberOfLockers := oldPosition numberOfLocker + aNumberOfLockers.
	aLap := oldPosition numberOfLap
	        + (newNumberOfLockers // boardDefinition numberOfLockers).
	aLocker := newNumberOfLockers % boardDefinition numberOfLockers.
	aLap < 0 ifTrue: [ 
		aLap := 0.
		aLocker := 0 ].
	^ ShipPosition for: oldPosition ship at: aLap and: aLocker
]

{ #category : #'accessing - attributes' }
Board >> numberOfLockerOf: aShip [

	^ (self positionOf: aShip) numberOfLocker 
]

{ #category : #'accessing - attributes' }
Board >> positionOf: aShip [

	| positionOfShip |
	positionOfShip := positionOfShips select: [ :aPositionOfShip | 
		                  (aPositionOfShip ship) == aShip ].

	^ positionOfShip removeFirst
]

{ #category : #ranking }
Board >> rankingOf: aShip [

	^ self shipsSortedByPosition indexOf: aShip
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
