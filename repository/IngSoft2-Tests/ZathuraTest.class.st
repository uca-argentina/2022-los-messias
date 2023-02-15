Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
ZathuraTest >> assert: aShip isAt: locker with: lap in: aGame [

	self assert: (aGame numberOfLockerOf: aShip) equals: locker.
	self assert: (aGame numberOfLapOf: aShip) equals: lap.
]

{ #category : #asserting }
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
ZathuraTest >> boardDefinitionWithOnly: effect at: effectLockerNumber of: numberOfLockers andLightYears: lightyears played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	lockers at: effectLockerNumber put: effect.

	^ BoardDefinition
		  with: lockers
		  and: (LightYear with: lightyears)
		  played: laps
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

{ #category : #'test-cancellationCard' }
ZathuraTest >> testBlueShipCantThrowCancellationCardIfNoCardsHaveBeenPlayed [

	| diceCup zathura  |
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
	self
		should: [ 
			zathura
				throws: CancellationCard new
				to: 'RedShip'
				removing: OverloadCard new
				from: 'BlueShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #'test-cancellationCard' }
ZathuraTest >> testBlueShipCantThrowCancellationCardToOverloadCardIfNoOverloadCardsHaveBeenPlayed [

	| diceCup zathura  |
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
	zathura throws: SpeedCard new to: 'RedShip' from: 'BlueShip'.
	self
		should: [ 
			zathura
				throws: CancellationCard new
				to: 'RedShip'
				removing: OverloadCard new
				from: 'BlueShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #'test-shipWithHandOfCards' }
ZathuraTest >> testBlueShipCantThrowOverloadCardIfNotInHand [

	| zathura aDie  |
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
	self
		should: [ 
		zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Card is not in Hand'
]

{ #category : #'test-board' }
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

{ #category : #'test-board' }
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

{ #category : #'test-board' }
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

{ #category : #'test-board' }
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

{ #category : #'test-redoCard' }
ZathuraTest >> testBlueShipThrowsARedoCardAfterARepeatCardHasBeenPlayed [

	| diceCup zathura  |
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


	zathura playTurn.

	zathura throws: RepeatCard new to: 'BlueShip' from: 'BlueShip'.
	zathura throws: RedoCard new to: 'GreenShip' from: 'GreenShip'.

	self
		assert: 'GreenShip'
		isAt: 4
		with: 0
		in: zathura
]

{ #category : #'test-redoCard' }
ZathuraTest >> testBlueShipThrowsARedoCardToAPermanentCardWhenItsNotHisTurn [

	| diceCup zathura  |
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

	zathura throws: SpeedCard new to: 'BlueShip' from: 'BlueShip'.

	self
		should: [ 
		zathura throws: RedoCard new to: 'BlueShip' from: 'GreenShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #'test-redoCard' }
ZathuraTest >> testBlueShipThrowsARedoCardToRepeatAnotherRedoCardThrownToASpeedCard [

	| diceCup zathura  |
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

	zathura throws: SpeedCard new to: 'BlueShip' from: 'BlueShip'.

	zathura playTurn.
	zathura throws: RedoCard new to: 'RedShip' from: 'RedShip'.

	zathura playTurn.
	zathura throws: RedoCard new to: 'GreenShip' from: 'GreenShip'.
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

{ #category : #'test-speedCard' }
ZathuraTest >> testBlueShipThrowsASpeedCardToRedShipAndRedShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura  |
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
	zathura throws: SpeedCard new to: 'RedShip' from: 'BlueShip'.
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

{ #category : #'test-cancellationCard' }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAfterTwoRoundsThrowsACancellationCard [

	| diceCup zathura  |
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
	zathura throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
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
	zathura
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

{ #category : #'test-redoCard' }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAfterTwoRoundsThrowsARedoCard [

	| diceCup zathura  |
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
	zathura throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
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
	zathura throws: RedoCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 25 in: zathura;
		assert: 'RedShip' isAtLocker: 25 in: zathura
]

{ #category : #'test-accelerationCard' }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAllShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura lockersOfBlueShip lockersOfRedShip  |
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
	zathura throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
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
		assert: 'RedShip' isAtLocker: 16 in: zathura
]

{ #category : #'test-redoCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndAfterTwoRoundsThrowsARedoCardToGreenShip [

	| diceCup zathura  |
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
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 7 in: zathura.
	self assert: 'GreenShip' isAtLocker: 7 in: zathura.

	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 12 in: zathura.
	self assert: 'GreenShip' isAtLocker: 14 in: zathura.
	zathura throws: RedoCard new to: 'GreenShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 21 in: zathura;
		assert: 'RedShip' isAtLocker: 17 in: zathura.
	self assert: 'GreenShip' isAtLocker: 19 in: zathura
]

{ #category : #'test-overloadCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesBackwards [

	| zathura aDie  |
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
	zathura playTurn.
	zathura playTurn.
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip' isAtLocker: 5 in: zathura;
		assert: 'RedShip' isAtLocker: 3 in: zathura
]

{ #category : #'test-overloadCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesRolledNumberMinusTwoAllGame [

	| diceCup zathura  |
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
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
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

{ #category : #'test-cancellationCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipThenRedShipsThrowsACancellationCardWhichCancelsTheOverLoadCard [

	| diceCup zathura  |
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
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 5 in: zathura.
	zathura
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

{ #category : #'test-redoCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadsCardsToRedShipAndGreenShipThrowsACancellationCardAndARedoCardToRedShipThrowsError [

	| diceCup zathura  |
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


	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.

	zathura
		throws: CancellationCard new
		to: 'RedShip'
		removing: OverloadCard new
		from: 'GreenShip'.

	self
		should: [ 
			zathura
				throws: RedoCard new
				to: 'RedShip'
				removing: OverloadCard new
				from: 'GreenShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #'test-accelerationCard' }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnAccelerationCardAndItIsNotItsTurn [

	| die ships boardStructure zathura  |
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

	zathura playTurn.

	self
		should: [ 
		zathura throws: AccelerationCard new toAllShipsFrom: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #'test-overloadCard' }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnOverloadCardAndItIsNotItsTurn [

	| die ships boardStructure zathura  |
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

	self
		should: [ 
		zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #'test-speedCard' }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnSpeedCardAndItIsNotItsTurn [

	| die ships boardStructure zathura  |
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

	self
		should: [ 
		zathura throws: SpeedCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #'test-redoCard' }
ZathuraTest >> testBlueShipThrowsTwoOverloadsCardsToRedShipAndGreenShipThrowsACancellationCardAndARedoCardToRedShip [

	| diceCup zathura  |
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
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 7 in: zathura.
	self assert: 'GreenShip' isAtLocker: 7 in: zathura.

	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 10 in: zathura.
	self assert: 'GreenShip' isAtLocker: 14 in: zathura.
	zathura
		throws: CancellationCard new
		to: 'RedShip'
		removing: OverloadCard new
		from: 'GreenShip'.
	zathura
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

{ #category : #'test-board' }
ZathuraTest >> testBlueShipsFallsIntoaCardGetterLockerAndGetsAnOverLoadCard [

	| die ships boardDefinition zathura  |
	die := LoadedDie with: 1.
	ships := #( 'BlueShip' 'RedShip' ).
	boardDefinition := self
		                   boardDefinitionWithOnly: CardEffect new
		                   at: 2
		                   of: 10
		                   andParsec: 100
		                   played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura playTurn.
	zathura playTurn.
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'
]

{ #category : #'test-board' }
ZathuraTest >> testBoardCanBeInitializedWithLightyears [

	| board |
	board := self
		         boardDefinitionWithNoEffectsOf: 20
		         and: (LightYear with: 60)
		         played: 3.

	self assert: board distancePerLockerAsParsecs equals: 1.
]

{ #category : #'test-boardDefinitionAssertion' }
ZathuraTest >> testBoardStructureCannotHaveLessThanTwoLockers [

	self
		should: [ 
		BoardDefinition with: { LockerNoEffect new } and: 20 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than two lockers'
]

{ #category : #'test-boardDefinitionAssertion' }
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

{ #category : #'test-boardDefinitionAssertion' }
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

{ #category : #'test-shipWithHandOfCards' }
ZathuraTest >> testCardHandThrowsErrorWhenThrownTheThirdCardBeacauseItStartsTheGameWithTwoCard [

	| die ships boardStructure zathura |
	die := LoadedDie with: 2.
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
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	self
		should: [ 
		zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Card is not in Hand'
]

{ #category : #'test-zathuraGame' }
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

{ #category : #'test-board' }
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
		                   andLightYears: 30
		                   played: 3.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die
		           withCards: { OverloadCard new }.

	zathura playTurn.
	self assert: 'BlueShip' isAtLocker: 7 in: zathura.

	zathura playTurn.
	self assert: 'RedShip' isAtLocker: 2 in: zathura
]

{ #category : #'test-boardDefinitionAssertion' }
ZathuraTest >> testHyperjumpCannotHaveANullParsecSequence [

	self
		should: [ HyperJumpEffect with: {  } ]
		raise: Error
		withMessage: 'Hyperjump cannot have a null parsec sequence'
]

{ #category : #'test-boardDefinitionAssertion' }
ZathuraTest >> testHyperjumpCannotHaveLessThanZeroParsecsInTheSequence [

	self
		should: [ HyperJumpEffect with: { (Parsec with: 5). (Parsec with: -2). (Parsec with: 10) } ]
		raise: Error
		withMessage:
		'Hyperjump cannot have less than zero parsecs in the sequence'
]

{ #category : #'test-boardDefinitionAssertion' }
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

{ #category : #'test-redoCard' }
ZathuraTest >> testRedoCardThrowsErrorWhenBlueShipThrowsItBeforeAnyOtherCardHasBeenThrownInTheGame [

	| diceCup zathura  |
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


	self
		should: [ 
		zathura throws: RedoCard new to: 'RedShip' from: 'RedShip' ]
		raise: Error
		withMessage:
		'Redo card must be thrown before another card has been played'
]

{ #category : #'test-cancellationCard' }
ZathuraTest >> testShipCantThrowCancellationCardToCancelACardToTheWrongShip [

	| diceCup zathura  |
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
	zathura throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 5 in: zathura.

	self
		should: [ 
			zathura
				throws: CancellationCard new
				to: 'BlueShip'
				removing: OverloadCard new
				from: 'RedShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #'test-board' }
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

{ #category : #'test-board' }
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

{ #category : #'test-board' }
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

{ #category : #'test-zathuraGame' }
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

{ #category : #'test-zathuraGame' }
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

{ #category : #'test-zathuraAssertion' }
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

{ #category : #'test-zathuraGame' }
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

{ #category : #'test-zathuraAssertion' }
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

{ #category : #'test-zathuraGame' }
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

{ #category : #'test-zathuraGame' }
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

{ #category : #'test-repeatCard' }
ZathuraTest >> testZathuraRedShipThrowsRepeatCardToBlueShip [

	| zathura aDie  |
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

	zathura throws: RepeatCard new to: 'RedShip' from: 'RedShip'.

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

{ #category : #'test-repeatCard' }
ZathuraTest >> testZathuraRedShipThrowsRepeatCardToHimselfWhenTheLastLockerWasANoEffectLockerAndNothingHappens [

	| zathura aDie  |
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

	zathura throws: RepeatCard new to: 'RedShip' from: 'RedShip'.

	self
		assert: 'RedShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #'test-board' }
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

{ #category : #'test-board' }
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

{ #category : #'test-zathuraAssertion' }
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
