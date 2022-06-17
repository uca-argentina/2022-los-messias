Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
ZathuraTest >> assert: aShip isAt: locker with: lap in: aGame [

	self assert: (aGame numberOfLockerOf: aShip) equals: locker.
	self assert: (aGame numberOfLapOf: aShip) equals: lap.
]

{ #category : #accessing }
ZathuraTest >> assert: aShip isAtLocker: locker in: aGame [

	self assert: (aGame numberOfLockerOf: aShip) equals: locker.
]

{ #category : #boardSpecificDefinitions }
ZathuraTest >> boardDefinitionWithNoEffectsOf: numberOfLockers and: unitMeasure played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	^ BoardDefinition
		  with: lockers
		  and: unitMeasure
		  played: laps
]

{ #category : #boardSpecificDefinitions }
ZathuraTest >> boardDefinitionWithNoEffectsOf: numberOfLockers andParsec: parsec played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	^ BoardDefinition with: lockers and: (Parsec with: parsec) played: laps
]

{ #category : #boardSpecificDefinitions }
ZathuraTest >> boardDefinitionWithOnly: effect at: effectLockerNumber of: numberOfLockers andParsec: parsec played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	lockers at: effectLockerNumber put: effect.

	^ BoardDefinition with: lockers and: (Parsec with: parsec) played: laps
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipAndRedShipStartsTheGameWithTwoCards [

	| die ships boardStructure zathura |
	die := LoadedDie with: 2.
	ships := #( 'RedShip' 'BlueShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	self assert: (zathura cardsOf: 'RedShip') size equals: 2.
	self assert: (zathura cardsOf: 'BlueShip') size equals: 2
]

{ #category : #cancellationCard }
ZathuraTest >> testBlueShipCantThrowCancellationCardIfNoCardsHaveBeenPlayed [

	| diceCup zathura  cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           CancellationCard new }.
	cardManager := zathura cardApplicator.
	self
		should: [ 
			cardManager
				throws: CancellationCard new
				to: 'RedShip'
				removing: OverloadCard new
				from: 'BlueShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #cancellationCard }
ZathuraTest >> testBlueShipCantThrowCancellationCardToOverloadCardIfNoOverloadCardsHaveBeenPlayed [

	| diceCup zathura cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           SpeedCard new.
				           CancellationCard new }.
	cardManager := zathura cardApplicator.
	cardManager throws: SpeedCard new to: 'RedShip' from: 'BlueShip'.
	self
		should: [ 
			cardManager
				throws: CancellationCard new
				to: 'RedShip'
				removing: OverloadCard new
				from: 'BlueShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipCantThrowOverloadCardIfNotInHand [

	| zathura aDie  cardManager |
	aDie := LoadedDie with: 1.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { AccelerationCard new }.
	cardManager := zathura cardApplicator.
	self
		should: [ 
		cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Card is not in Hand'
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAAtomicBombAndAllShipsGoToFirstLockerOfTheSameLap [

	| die ships zathura boardDefinition |
	die := LoadedDie with: 8.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	boardDefinition := self
		                   boardDefinitionWithOnly: AtomicBombEffect new
		                   at: 7
		                   of: 10
		                   andParsec: 50
		                   played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 0
		with: 1
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 0
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 0
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAMoonWalkLockerAndTheResultIsItMovesAllOtherShipsBackwardsTwoLockers [

	| die ships zathura boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	boardStructure := self
		                  boardDefinitionWithOnly: (MoonWalkEffect with: 2)
		                  at: 7
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 6
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 1
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 1
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoASpeedUpLockerAndTheResultIsItAdvancesFourLockersMore [

	| die ships zathura boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	boardStructure := self
		                  boardDefinitionWithOnly: SpeedUpEffect new
		                  at: 4
		                  of: 8
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 7
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAWormHoleLockerAndTheResultIsItAdvancesFourLockersBackwards [

	| die ships zathura boardStructure |
	die := LoadedDie with: 5.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	boardStructure := self
		                  boardDefinitionWithOnly: WormHoleEffect new
		                  at: 6
		                  of: 9
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 1
		with: 0
		in: zathura
]

{ #category : #redoCard }
ZathuraTest >> testBlueShipThrowsARedoCardAfterARepeatCardHasBeenPlayed [

	| diceCup zathura cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf: (self
				            boardDefinitionWithOnly: SpeedUpEffect new
				            at: 8
				            of: 30
				            andParsec: 100
				            played: 1)
		           rolling: diceCup
		           withCards: { 
				           RepeatCard new.
				           RedoCard new }.

	cardManager := zathura cardApplicator.

	zathura playTurn.

	cardManager throws: RepeatCard new to: 'BlueShip' from: 'BlueShip'.
	cardManager throws: RedoCard new to: 'GreenShip' from: 'GreenShip'.
	
	self assert: 'GreenShip' isAt: 4 with: 0 in: zathura 
]

{ #category : #redoCard }
ZathuraTest >> testBlueShipThrowsARedoCardToAPermanentCardWhenItsNotHisTurn [

	| diceCup zathura cardApplicator |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           SpeedCard new.
				           RedoCard new }.

	cardApplicator := zathura cardApplicator.
	cardApplicator throws: SpeedCard new to: 'BlueShip' from: 'BlueShip'.

	self
		should: [ 
		cardApplicator throws: RedoCard new to: 'BlueShip' from: 'GreenShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #redoCard }
ZathuraTest >> testBlueShipThrowsARedoCardToRepeatAnotherRedoCardThrownToASpeedCard [

	| diceCup zathura cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           SpeedCard new.
				           RedoCard new }.

	cardManager := zathura cardApplicator.
	cardManager throws: SpeedCard new to: 'BlueShip' from: 'BlueShip'.

	zathura playTurn.
	cardManager throws: RedoCard new to: 'RedShip' from: 'RedShip'.

	zathura playTurn.
	cardManager throws: RedoCard new to: 'GreenShip' from: 'GreenShip'.
	zathura playTurn.

	self
		assert: 'BlueShip'
		isAt: 8
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 8
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 8
		with: 0
		in: zathura
]

{ #category : #speedCard }
ZathuraTest >> testBlueShipThrowsASpeedCardToRedShipAndRedShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura   cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 20
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { SpeedCard new }.
	cardManager := zathura cardApplicator.
	cardManager throws: SpeedCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 8 in: zathura.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 16 in: zathura
]

{ #category : #cancellationCard }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAfterTwoRoundsThrowsACancellationCard [

	| diceCup zathura   cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           AccelerationCard new.
				           CancellationCard new }.
	cardManager := zathura cardApplicator.
	cardManager throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 8 in: zathura;
		assert: 'RedShip' isAtLocker: 8 in: zathura.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 16 in: zathura;
		assert: 'RedShip' isAtLocker: 16 in: zathura.
	cardManager
		throws: CancellationCard new
		removing: AccelerationCard new
		from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 23 in: zathura;
		assert: 'RedShip' isAtLocker: 23 in: zathura
]

{ #category : #redoCard }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAfterTwoRoundsThrowsARedoCard [

	| diceCup zathura   cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           AccelerationCard new.
				           RedoCard new }.
	cardManager := zathura cardApplicator.
	cardManager throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 8 in: zathura;
		assert: 'RedShip' isAtLocker: 8 in: zathura.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 16 in: zathura;
		assert: 'RedShip' isAtLocker: 16 in: zathura.
	cardManager throws: RedoCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 25 in: zathura;
		assert: 'RedShip' isAtLocker: 25 in: zathura
]

{ #category : #accelerationCard }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAllShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura lockersOfBlueShip lockersOfRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 20
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { AccelerationCard new }.
	cardManager := zathura cardApplicator.
	cardManager throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 8 in: zathura;
		assert: 'RedShip' isAtLocker: 8 in: zathura.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: 'BlueShip' isAtLocker: 16 in: zathura;
		assert: 'RedShip' isAtLocker: 16 in: zathura.
]

{ #category : #redoCard }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndAfterTwoRoundsThrowsARedoCardToGreenShip [

	| diceCup zathura lockersOfBlueShip lockersOfRedShip lockersOfGreenShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           RedoCard new }.
	cardManager := zathura cardApplicator.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 7 in: zathura.
	self assert: 'GreenShip' isAtLocker: 7 in: zathura.

	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 12 in: zathura.
	self assert: 'GreenShip' isAtLocker: 14 in: zathura.
	cardManager throws: RedoCard new to: 'GreenShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 21 in: zathura;
		assert: 'RedShip' isAtLocker: 17 in: zathura.
	self assert: 'GreenShip' isAtLocker: 19 in: zathura.
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndLosesOneOverloadCard [

	| zathura aDie cardManager |
	aDie := LoadedDie with: 4.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { OverloadCard new }.
	cardManager := zathura cardApplicator.
	zathura playTurn.
	zathura playTurn.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura playTurn.
	zathura playTurn.
	self assert: (zathura  cardsOf: 'BlueShip') size equals: 1
]

{ #category : #overloadCard }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesBackwards [

	|   zathura aDie cardManager |
	aDie := SequencialLoadedDie with: { 4. 4. 1. 1 }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { OverloadCard new }.
	cardManager := zathura cardApplicator.
	zathura playTurn.
	zathura playTurn.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip' isAtLocker: 5 in: zathura;
		assert: 'RedShip' isAtLocker: 3 in: zathura
]

{ #category : #overloadCard }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesRolledNumberMinusTwoAllGame [

	| diceCup zathura   cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { OverloadCard new }.
	cardManager := zathura cardApplicator.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 5 in: zathura.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 10 in: zathura
]

{ #category : #cancellationCard }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipThenRedShipsThrowsACancellationCardWhichCancelsTheOverLoadCard [

	| diceCup zathura   cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           CancellationCard new }.
	cardManager := zathura cardApplicator.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 5 in: zathura.
	cardManager
		throws: CancellationCard new
		to: 'RedShip'
		removing: OverloadCard new
		from: 'RedShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 12 in: zathura
]

{ #category : #redoCard }
ZathuraTest >> testBlueShipThrowsAnOverloadsCardsToRedShipAndGreenShipThrowsACancellationCardAndARedoCardToRedShipThrowsError [

	| diceCup zathura    cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           OverloadCard new.
				           OverloadCard new.
				           OverloadCard new.
				           CancellationCard new.
				           RedoCard new }.

	cardManager := zathura cardApplicator.

	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.

	cardManager
		throws: CancellationCard new
		to: 'RedShip'
		removing: OverloadCard new
		from: 'GreenShip'.

	self
		should: [ 
			cardManager
				throws: RedoCard new
				to: 'RedShip'
				removing: OverloadCard new
				from: 'GreenShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #accelerationCard }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnAccelerationCardAndItIsNotItsTurn [

	| die ships boardStructure zathura  cardManager |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { AccelerationCard new }.

	cardManager := zathura cardApplicator.
	zathura playTurn.

	self
		should: [ 
		cardManager throws: AccelerationCard new toAllShipsFrom: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #overloadCard }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnOverloadCardAndItIsNotItsTurn [

	| die ships boardStructure zathura  cardManager |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	cardManager := zathura cardApplicator.

	self
		should: [ 
		cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #speedCard }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnSpeedCardAndItIsNotItsTurn [

	| die ships boardStructure zathura cardManager |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { SpeedCard new }.
	zathura playTurn.
	cardManager := zathura cardApplicator.

	self
		should: [ 
		cardManager throws: SpeedCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #redoCard }
ZathuraTest >> testBlueShipThrowsTwoOverloadsCardsToRedShipAndGreenShipThrowsACancellationCardAndARedoCardToRedShip [

	| diceCup zathura    cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           OverloadCard new.
				           OverloadCard new.
				           OverloadCard new.
				           CancellationCard new.
				           RedoCard new }.
	cardManager := zathura cardApplicator.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 7 in: zathura.
	self assert: 'GreenShip' isAtLocker: 7 in: zathura.

	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 10 in: zathura.
	self assert: 'GreenShip' isAtLocker: 14 in: zathura.
	cardManager
		throws: CancellationCard new
		to: 'RedShip'
		removing: OverloadCard new
		from: 'GreenShip'.
	cardManager
		throws: RedoCard new
		to: 'RedShip'
		removing: OverloadCard new
		from: 'GreenShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 21 in: zathura;
		assert: 'RedShip' isAtLocker: 17 in: zathura.
	self assert: 'GreenShip' isAtLocker: 21 in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testBoardCanBeInitializedWithLightyears [

	| board |
	board := self
		         boardDefinitionWithNoEffectsOf: 20
		         and: (LightYear with: 60)
		         played: 3.

	self assert: board parsecsPerLocker equals: 1
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanTwoLockers [

	self
		should: [ 
		BoardDefinition with: { LockerNoEffect new } and: 20 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than two lockers'
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanZeroLaps [

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: (Parsec with: 10)
				played: 0 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero laps'.

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: (Parsec with: 10)
				played: -3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero laps'
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanZeroParsecs [

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: (Parsec with: 0)
				played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero parsecs'.

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: (Parsec with: -5)
				played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero parsecs'
]

{ #category : #tests }
ZathuraTest >> testGreenShipWinsAndFinishesInPositionZeroWithOneLapCompleted [

	| zathura die ships boardStructure |
	die := LoadedDie with: 7.
	ships := OrderedCollection
		         with: 'GreenShip'
		         with: 'RedShip'
		         with: 'BlueShip'.

	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.

	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'GreenShip'
		isAt: 7
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 7
		with: 0
		in: zathura.
	self
		assert: 'BlueShip'
		isAt: 7
		with: 0
		in: zathura.
	zathura playTurn.
	self
		assert: 'GreenShip'
		isAt: 0
		with: 1
		in: zathura.
	self assert: zathura winner  equals: 'GreenShip'
]

{ #category : #boardTests }
ZathuraTest >> testHyperJumpUnderstandBothLightYearsAndParsecsInTheSameSequence [

	| sequence die ships boardDefinition zathura |
	die := LoadedDie with: 1.

	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	sequence := { 
		            (Parsec with: 6).
		            (LightYear with: 3) }.

	boardDefinition := self
		                   boardDefinitionWithOnly:
		                   (HyperJumpEffect with: sequence)
		                   at: 2
		                   of: 10
		                   andParsec: 10
		                   played: 3.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die
		           withCards: { OverloadCard new }.

	zathura playTurn.
		self
		assert: 'BlueShip' isAtLocker: 7 in: zathura.

	zathura playTurn.
		self
		assert: 'RedShip' isAtLocker: 2 in: zathura.
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testHyperjumpCannotHaveANullParsecSequence [

	self
		should: [ HyperJumpEffect with: {  } ]
		raise: Error
		withMessage: 'Hyperjump cannot have a null parsec sequence'
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testHyperjumpCannotHaveLessThanZeroParsecsInTheSequence [

	self
		should: [ HyperJumpEffect with: { (Parsec with: 5). (Parsec with: -2). (Parsec with: 10) } ]
		raise: Error
		withMessage:
		'Hyperjump cannot have less than zero parsecs in the sequence'
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testMoonwalkCannotHaveLessThanZeroLockers [

	self
		should: [ MoonWalkEffect with: 0 ]
		raise: Error
		withMessage:
		'MoonWalk cannot be created with less than zero lockers'.

	self
		should: [ MoonWalkEffect with: -3 ]
		raise: Error
		withMessage:
		'MoonWalk cannot be created with less than zero lockers'
]

{ #category : #boardTests }
ZathuraTest >> testRedShipsFallsIntoaCardGetterLockerAndGetsARandomCard [

	| redShipCardHand die ships boardStructure zathura cardManager |
	die := LoadedDie with: 1.
	ships := #( 'RedShip' 'BlueShip' ).
	boardStructure := self
		                  boardDefinitionWithOnly: CardEffect new
		                  at: 2
		                  of: 10
		                  andParsec: 100
		                  played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	redShipCardHand := zathura  cardsOf: 'RedShip'.
	self assert: redShipCardHand size equals: 3
]

{ #category : #redoCard }
ZathuraTest >> testRedoCardThrowsErrorWhenBlueShipThrowsItBeforeAnyOtherCardHasBeenThrownInTheGame [

	| diceCup zathura cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           SpeedCard new.
				           RedoCard new }.

	cardManager := zathura cardApplicator.

	self
		should: [ 
		cardManager throws: RedoCard new to: 'RedShip' from: 'RedShip' ]
		raise: Error
		withMessage: 'Redo card must be thrown before another card has been played'
]

{ #category : #cancellationCard }
ZathuraTest >> testShipCantThrowCancellationCardToCancelACardToTheWrongShip [

	| diceCup zathura lockersOfBlueShip lockersOfRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           CancellationCard new }.
	cardManager := zathura cardApplicator.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 5 in: zathura.

	self
		should: [ 
			cardManager
				throws: CancellationCard new
				to: 'BlueShip'
				removing: OverloadCard new
				from: 'RedShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #boardTests }
ZathuraTest >> testShipLandsOnAWormholeEffectAndGoesBackOneLap [

	| zathura sequencialDie ships boardStructure |
	sequencialDie := SequencialLoadedDie with: { 11. 11. 1 }.
	boardStructure := self
		                  boardDefinitionWithOnly: WormHoleEffect new
		                  at: 3
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: sequencialDie
		           withCards: { OverloadCard new }.

	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 8
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 1
		with: 1
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testShipsFallIntoAHyperJumpLockerAndMovesByTheLightYearsInASequence [

	| die ships zathura boardStructure  sequence |
	die := LoadedDie with: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	sequence := { 
		            (LightYear with: 75).
		            (LightYear with: 93).
		            (LightYear with: 33) }.
	boardStructure := self
		                  boardDefinitionWithOnly:
		                  (HyperJumpEffect with: sequence)
		                  at: 2
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 4
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 3
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testShipsFallIntoAHyperJumpLockerAndMovesByTheParsecsInASequence [

	| die ships zathura boardStructure sequence |
	die := LoadedDie with: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	sequence := { 
		            (Parsec with: 25).
		            (Parsec with: 31).
		            (Parsec with: 11) }.
	boardStructure := self
		                  boardDefinitionWithOnly:
		                  (HyperJumpEffect with: sequence)
		                  at: 2
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 4
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 3
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #tests }
ZathuraTest >> testThePositionOfEachShipCanBeKnownWhenTheGameIsFinished [

	| zathura diceCup ships boardStructure |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 6).
			           (LoadedDie with: 2) }.
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup
		           withCards: { OverloadCard new }.

	zathura play.
	self
		assert: 'BlueShip'
		isAt: 0
		with: 1
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 8
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 8
		with: 0
		in: zathura
]

{ #category : #tests }
ZathuraTest >> testWhenShipGoesBackwardsInTheFirstLapItStayesAtTheLapZero [

	| zathura diceCup ships boardStructure |
	diceCup := LoadedDie with: 1.
	boardStructure := self
		                  boardDefinitionWithOnly: WormHoleEffect new
		                  at: 2
		                  of: 10
		                  andParsec: 50
		                  played: 3.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup
		           withCards: { OverloadCard new }.

	zathura playTurn.
	zathura playTurn.

		self
		assert: 'BlueShip' isAt: 0 with: 0 in: zathura . 
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraCannotBePlayedMoreThanOnce [

	| ships aDie zathura boardStructure |
	aDie := LoadedDie with: 8.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 5
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: aDie
		           withCards: { OverloadCard new }.
	zathura play.

	self
		should: [ zathura play ]
		raise: Error
		withMessage: 'Zathura cannot be played more than once'
]

{ #category : #tests }
ZathuraTest >> testZathuraGamePlaysATurnAndDoNotFinish [

	| ships aDie zathura boardStructure |
	aDie := RandomDie with: 3.
	ships := OrderedCollection
		         with: 'GreenShip'
		         with: 'RedShip'
		         with: 'BlueShip'.
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 5
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: aDie
		           withCards: { OverloadCard new }.
	zathura playTurn.
	self deny: zathura hasFinished
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraInitializedWithLessThanTwoShipsThrowsError [

	| die ships |
	die := LoadedDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.

	self
		should: [ 
			ZathuraGame
				playBy: ships
				movedInBoardOf: 10
				rolling: die
				withCards: { OverloadCard new } ]
		raise: Error
		withMessage: 'Zathura cannot be played with less than two ships'
]

{ #category : #tests }
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionZeroAndLapZero [

	| die ships zathura boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 5
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	self
		assert: 'BlueShip'
		isAt: 0
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 0
		with: 0
		in: zathura
]

{ #category : #tests }
ZathuraTest >> testZathuraKnowsTheRankingOfAShip [

	| die ships zathura faces boardStructure |
	faces := OrderedCollection with: 5 with: 8 with: 9.
	die := SequencialLoadedDie with: faces.
	ships := OrderedCollection
		         with: 'RedShip'
		         with: 'GreenShip'
		         with: 'BlueShip'.

	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 7
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.

	zathura playTurn.
	zathura playTurn.

	self assert: (zathura rankingOf: 'BlueShip') equals: 3.
	self assert: (zathura rankingOf: 'GreenShip') equals: 1.
	self assert: (zathura rankingOf: 'RedShip') equals: 2.

	zathura playTurn.
	self assert: (zathura rankingOf: 'GreenShip') equals: 2.
	self assert: (zathura rankingOf: 'BlueShip') equals: 1.
	self assert: (zathura rankingOf: 'RedShip') equals: 3
]

{ #category : #repeatCard }
ZathuraTest >> testZathuraRedShipThrowsRepeatCardToBlueShip [

	|  zathura aDie  cardManager |
	aDie := LoadedDie with: 2.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf: (self
				            boardDefinitionWithOnly: SpeedUpEffect new
				            at: 3
				            of: 12
				            andParsec: 100
				            played: 1)
		           rolling: aDie
		           withCards: { RepeatCard new }.

	zathura playTurn.
	zathura playTurn.

	self
		assert: 'BlueShip'
		isAt: 6
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 6
		with: 0
		in: zathura.

	cardManager := zathura cardApplicator.
	cardManager throws: RepeatCard new to: 'RedShip' from: 'RedShip'.

	self
		assert: 'RedShip'
		isAt: 10
		with: 0
		in: zathura.
	self
		assert: 'BlueShip'
		isAt: 6
		with: 0
		in: zathura
]

{ #category : #repeatCard }
ZathuraTest >> testZathuraRedShipThrowsRepeatCardToHimselfWhenTheLastLockerWasANoEffectLockerAndNothingHappens [

	| zathura aDie cardManager |
	aDie := LoadedDie with: 2.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 12
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { RepeatCard new }.

	zathura playTurn.
	zathura playTurn.

	self
		assert: 'BlueShip'
		isAt: 2
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 2
		with: 0
		in: zathura.

	cardManager := zathura cardApplicator.
	cardManager throws: RepeatCard new to: 'RedShip' from: 'RedShip'.

	self
		assert: 'RedShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testZathuraShipFallsIntoASpeedUpMovesFourLockersAndStaysThere [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 1.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	lockers := { 
		           LockerNoEffect new.
		           SpeedUpEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           WormHoleEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition
		                  with: lockers
		                  and: (Parsec with: 100)
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 6
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testZathuraWhenCrossingTheLastLockerTheShipsStartsAnotherLap [

	| die ships zathura boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'RedShip'
		isAt: 6
		with: 0
		in: zathura.
	self
		assert: 'BlueShip'
		isAt: 2
		with: 1
		in: zathura
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraWhileItHasNotFinishedAsksWinnerThrowsError [

	| die ships zathura boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'GreenShip' with: 'BlueShip'.
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 3
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.

	self
		should: [ zathura winner ]
		raise: Error
		withMessage: 'Zathura has not finished yet'
]
