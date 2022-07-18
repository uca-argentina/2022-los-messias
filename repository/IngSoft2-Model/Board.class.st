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
		'cardApplicator',
		'jail'
	],
	#classInstVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> of: aBoardStructure withAll: aCollectionOfShips and: aCardApplicator [

	^ self new
		  initializeWith: aBoardStructure
		  withAGroupOf: aCollectionOfShips
		  withCardManager: aCardApplicator
]

{ #category : #private }
Board >> addIntoGame: aCollectionOfShips [

	positionOfShips := aCollectionOfShips collect: [ :aShip | 
		                          (ShipPosition for: aShip at: 0 and: 0) ].
]

{ #category : #adding }
Board >> addToJail: aShip [

	jail add: aShip
]

{ #category : #private }
Board >> applyEffectOnLockerOrCorrectThePositionIfCrossFinishLineTo: aShip [

	| thisLocker |
	thisLocker := boardDefinition lockerAt: (self numberOfLockerOf: aShip) + 1.
	lastEffect := thisLocker.
	(self hasCrossFinishLine: aShip)
		ifFalse: [ thisLocker applyFor: aShip on: self ]
		ifTrue: [ self correctPositionIfCrossFinishLineTo: aShip ]
]

{ #category : #moving }
Board >> applyLastEffectOn: aShip [

	lastEffect applyFor: aShip on: self
]

{ #category : #moving }
Board >> changePositionOf: aShip with: diceCup [

	| aNumberOfLockers |
	aNumberOfLockers := diceCup roll
	                    + (cardApplicator findChangeOfRoll: aShip).
	self
		checkIf: aShip
		isOnJailAndCanBeReleasedWith: aNumberOfLockers
		of: diceCup maxNumberOfRoll.
	
	(jail includes: aShip) ifFalse: [ 
		self move: aShip by: aNumberOfLockers.
		self applyEffectOnLockerOrCorrectThePositionIfCrossFinishLineTo:
			aShip ]
]

{ #category : #private }
Board >> checkIf: aShip isOnJailAndCanBeReleasedWith: aNumberOfLockers of: maxNumberOfLockers [

	
	((jail includes: aShip) and: (aNumberOfLockers = maxNumberOfLockers)) ifTrue: [ 
		self releaseFromJail: aShip ]
]

{ #category : #private }
Board >> correctPositionIfCrossFinishLineTo: aShip [


		positionOfShips
			replaceAll: (self positionOf: aShip)
			with: (self moveToFinalPosition: aShip) 
]

{ #category : #private }
Board >> giveCardTo: aShip [

	cardApplicator addTheNextCardToHandCardOf: aShip
]

{ #category : #moving }
Board >> hasCrossFinishLine: aShip [

	| positionOfShip |
	positionOfShip := self positionOf: aShip.
	^ positionOfShip numberOfLap >= boardDefinition laps
]

{ #category : #initalization }
Board >> initializeWith: aBoardDefinition withAGroupOf: aCollectionOfShips withCardManager: aCardApplicator [

	boardDefinition := aBoardDefinition.
	self addIntoGame: aCollectionOfShips.
	lastEffect := LockerNoEffect new.
	cardApplicator := aCardApplicator.
	jail := OrderedCollection new.
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
		by: (numberOfParsecs * boardDefinition unitPerLocker) floor
]

{ #category : #private }
Board >> moveAllBackwardsExcept: aShip by: aNumberOfLockers [

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

	^ positionOfShips detect: [ :aPositionOfShip | 
		  aPositionOfShip ship == aShip ]
]

{ #category : #ranking }
Board >> rankingOf: aShip [

	^ self shipsSortedByPosition indexOf: aShip
]

{ #category : #removing }
Board >> releaseFromJail: aShip [

	jail remove: aShip ifAbsent: [ 
		Error signal:
			'The ship is not in a Jail Locker' ]
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
