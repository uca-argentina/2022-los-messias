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
ZathuraTest >> boardDefinitionWithOnly: effect at: effectLockerNumber of: numberOfLockers andParsec: parsec played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	lockers at: effectLockerNumber put: effect.

	^ BoardDefinition with: lockers and: (Parsec with: parsec) played: laps
]

{ #category : #'test - cancellationCard' }
ZathuraTest >> testBlueShipCantThrowCancellationCardIfNoCardsHaveBeenPlayed [

	| diceCup zathura |
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
			zathura throws: (CancellationCard
					 with: (OverloadCard thrownBy:'RedShip'  to: 'RedShip')
					 thrownBy: 'BlueShip') ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #'test - cancellationCard' }
ZathuraTest >> testBlueShipCantThrowCancellationCardToOverloadCardIfNoOverloadCardsHaveBeenPlayed [

	| diceCup zathura |
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
	zathura throws: (SpeedCard thrownBy: 'BlueShip' to: 'RedShip').
	self
		should: [ 
			zathura throws: (CancellationCard
					 with: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip')
					 thrownBy: 'BlueShip') ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #'test - shipWithHandOfCards' }
ZathuraTest >> testBlueShipCantThrowOverloadCardIfNotInHand [

	| zathura aDie |
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
		zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip') ]
		raise: Error
		withMessage: 'Card is not in Hand'
]

{ #category : #'test - board' }
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

{ #category : #'test - board' }
ZathuraTest >> testBlueShipFallsIntoAJailLockerAndItDoesNotAdvanceUntilItThrowsTheMaxNumber [

	| die ships zathura boardDefinition |
	die := SequencialLoadedDie with: { 3. 10 . 3 . 10 . 10 }.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardDefinition := self
		                   boardDefinitionWithOnly: JailEffect new
		                   at: 4
		                   of: 100
		                   andParsec: 50
		                   played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 3
		with: 0
		in: zathura.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 3
		with: 0
		in: zathura.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 13
		with: 0
		in: zathura.

]

{ #category : #'test - board' }
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

{ #category : #'test - board' }
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

{ #category : #'test - board' }
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

{ #category : #'test - redoCard' }
ZathuraTest >> testBlueShipThrowsARedoCardAfterARepeatCardHasBeenPlayed [

	| diceCup zathura |
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

	zathura throws: (RepeatCard thrownBy: 'RedShip' to: 'BlueShip').
	zathura throws: (RedoCard thrownBy: 'RedShip' to: 'GreenShip').

	self
		assert: 'GreenShip'
		isAt: 4
		with: 0
		in: zathura
]

{ #category : #'test - redoCard' }
ZathuraTest >> testBlueShipThrowsARedoCardToAPermanentCardWhenItsNotHisTurn [

	| diceCup zathura |
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

	zathura throws: (SpeedCard thrownBy: 'BlueShip' to: 'BlueShip').

	self
		should: [ 
		zathura throws: (RedoCard thrownBy: 'RedShip' to: 'BlueShip')]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #'test - redoCard' }
ZathuraTest >> testBlueShipThrowsARedoCardToRepeatAnotherRedoCardThrownToASpeedCard [

	| diceCup zathura |
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

	zathura throws: (SpeedCard thrownBy: 'BlueShip' to: 'BlueShip').

	zathura playTurn.
	zathura throws: (RedoCard thrownBy: 'RedShip' to: 'RedShip').

	zathura playTurn.
	zathura throws: (RedoCard thrownBy: 'GreenShip' to: 'GreenShip').
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

{ #category : #'test - speedCard' }
ZathuraTest >> testBlueShipThrowsASpeedCardToRedShipAndRedShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura |
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
	zathura throws: (SpeedCard thrownBy: 'BlueShip' to: 'RedShip').
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

{ #category : #'test - cancellationCard' }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAfterTwoRoundsThrowsACancellationCard [

	| diceCup zathura |
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
	zathura throws: (AccelerationCard thrownBy: 'BlueShip').
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
	zathura throws:
		(CancellationCard with: (AccelerationCard thrownBy: 'BlueShip') thrownBy: 'BlueShip').
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 23 in: zathura;
		assert: 'RedShip' isAtLocker: 23 in: zathura
]

{ #category : #'test - redoCard' }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAfterTwoRoundsThrowsARedoCard [

	| diceCup zathura |
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
	zathura throws: (AccelerationCard thrownBy: 'BlueShip').
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 8 in: zathura;
		assert: 'RedShip' isAtLocker: 8 in: zathura.
	zathura throws: (RedoCard thrownBy: 'BlueShip' to: 'allShips').
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 17 in: zathura;
		assert: 'RedShip' isAtLocker: 17 in: zathura
]

{ #category : #'test - accelerationCard' }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAllShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura |
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
	zathura throws: (AccelerationCard thrownBy: 'BlueShip').
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
		assert: 'RedShip' isAtLocker: 16 in: zathura
]

{ #category : #'test - redoCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndAfterTwoRoundsThrowsARedoCardToGreenShip [

	| diceCup zathura |
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

	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 12 in: zathura.
	self assert: 'GreenShip' isAtLocker: 14 in: zathura.
	zathura throws: (RedoCard thrownBy: 'BlueShip' to: 'GreenShip').
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 21 in: zathura;
		assert: 'RedShip' isAtLocker: 17 in: zathura.
	self assert: 'GreenShip' isAtLocker: 19 in: zathura
]

{ #category : #'test - overloadCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesBackwards [

	| zathura aDie |
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
	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip' isAtLocker: 5 in: zathura;
		assert: 'RedShip' isAtLocker: 3 in: zathura
]

{ #category : #'test - overloadCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesRolledNumberMinusTwoAllGame [

	| diceCup zathura |
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
	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
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

{ #category : #'test - cancellationCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipThenRedShipsThrowsACancellationCardWhichCancelsTheOverLoadCard [

	| diceCup zathura |
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
	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 5 in: zathura.
	zathura throws: (CancellationCard
			 with: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip')
			 thrownBy: 'RedShip').
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 12 in: zathura
]

{ #category : #'test - redoCard' }
ZathuraTest >> testBlueShipThrowsAnOverloadsCardsToRedShipAndGreenShipThrowsACancellationCardAndARedoCardToRedShipThrowsError [

	| diceCup zathura |
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

	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'BlueShip').

	zathura throws:
		(CancellationCard with: (OverloadCard thrownBy: 'BlueShip' to: 'BlueShip') thrownBy: 'GreenShip').

	self
		should: [ 
			zathura throws: (RedoCardWithACard
					 with: OverloadCard new
					 thrownBy: 'GreenShip') ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #'test - accelerationCard' }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnAccelerationCardAndItIsNotItsTurn [

	| die ships boardStructure zathura |
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
		zathura throws: (AccelerationCard thrownBy: 'BlueShip') ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #'test - overloadCard' }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnOverloadCardAndItIsNotItsTurn [

	| die ships boardStructure zathura |
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
		zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip') ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #'test - speedCard' }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnSpeedCardAndItIsNotItsTurn [

	| die ships boardStructure zathura |
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
		should: [ zathura throws: (SpeedCard thrownBy: 'BlueShip'  to: 'BlueShip') ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #'test - redoCard' }
ZathuraTest >> testBlueShipThrowsTwoOverloadsCardsToRedShipAndGreenShipThrowsACancellationCardAndARedoCardToRedShip [

	| diceCup zathura |
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

	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 14 in: zathura;
		assert: 'RedShip' isAtLocker: 10 in: zathura;
		assert: 'GreenShip' isAtLocker: 14 in: zathura.
	zathura throws: (CancellationCard
			 with: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip')
			 thrownBy: 'GreenShip').
	zathura throws: (RedoCardWithACard
			 with: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip')
			 thrownBy: 'GreenShip').
	zathura
		playTurn;
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 21 in: zathura;
		assert: 'RedShip' isAtLocker: 17 in: zathura.
	self assert: 'GreenShip' isAtLocker: 21 in: zathura
]

{ #category : #'test - board' }
ZathuraTest >> testBlueShipsFallsIntoaCardGetterLockerAndGetsAnOverLoadCard [

	| die ships boardDefinition zathura |
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
		           withCards: { SpeedCard new }.
	zathura playTurn.
	zathura playTurn.
	zathura throws: (SpeedCard thrownBy: 'BlueShip' to: 'BlueShip').
	zathura throws: (SpeedCard thrownBy: 'BlueShip' to: 'BlueShip').
	zathura throws: (SpeedCard thrownBy: 'BlueShip' to: 'BlueShip')
]

{ #category : #'test - board' }
ZathuraTest >> testBoardCanBeInitializedWithLightyears [

	| board |
	board := self
		         boardDefinitionWithNoEffectsOf: 20
		         and: (LightYear with: 60)
		         played: 3.

	self assert: board unitPerLocker equals: 1
]

{ #category : #'test - boardDefinitionAssertion' }
ZathuraTest >> testBoardStructureCannotHaveLessThanTwoLockers [

	self
		should: [ 
		BoardDefinition with: { LockerNoEffect new } and: 20 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than two lockers'
]

{ #category : #'test - boardDefinitionAssertion' }
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

{ #category : #'test - boardDefinitionAssertion' }
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

{ #category : #'test - shipWithHandOfCards' }
ZathuraTest >> testCardHandThrowsErrorWhenThrownTheThirdCardBeacauseItStartsTheGameWithTwoCard [

	| die ships boardDefinition zathura |
	die := LoadedDie with: 2.
	ships := #( 'BlueShip' 'RedShip' ).
	boardDefinition := self
		                   boardDefinitionWithNoEffectsOf: 10
		                   andParsec: 100
		                   played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
	self
		should: [ zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip') ]
		raise: Error
		withMessage: 'Card is not in Hand'
]

{ #category : #'test - zathura' }
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

{ #category : #'test - board' }
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

{ #category : #'test - boardDefinitionAssertion' }
ZathuraTest >> testHyperjumpCannotHaveANullParsecSequence [

	self
		should: [ HyperJumpEffect with: {  } ]
		raise: Error
		withMessage: 'Hyperjump cannot have a null parsec sequence'
]

{ #category : #'test - boardDefinitionAssertion' }
ZathuraTest >> testHyperjumpCannotHaveLessThanZeroParsecsInTheSequence [

	self
		should: [ HyperJumpEffect with: { (Parsec with: 5). (Parsec with: -2). (Parsec with: 10) } ]
		raise: Error
		withMessage:
		'Hyperjump cannot have less than zero parsecs in the sequence'
]

{ #category : #'test - boardDefinitionAssertion' }
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

{ #category : #'test - redoCard' }
ZathuraTest >> testRedoCardThrowsErrorWhenBlueShipThrowsItBeforeAnyOtherCardHasBeenThrownInTheGame [

	| diceCup zathura |
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
		should: [ zathura throws: (RedoCard thrownBy: 'RedShip' to: 'BlueShip') ]
		raise: Error
		withMessage:
		'Redo card must be thrown before another card has been played'
]

{ #category : #'test - cancellationCard' }
ZathuraTest >> testShipCantThrowCancellationCardToCancelACardToTheWrongShip [

	| diceCup zathura |
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
	zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip').
	zathura
		playTurn;
		playTurn.
	self
		assert: 'BlueShip' isAtLocker: 7 in: zathura;
		assert: 'RedShip' isAtLocker: 5 in: zathura.

	self
		should: [ 
			zathura throws: (CancellationCard
					 with: (OverloadCard thrownBy: 'BlueShip' to: 'BlueShip')
					 thrownBy: 'RedShip') ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #'test - board' }
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

{ #category : #'test - board' }
ZathuraTest >> testShipsFallIntoAHyperJumpLockerAndMovesByTheLightYearsInASequence [

	| die ships zathura boardDefinition  sequence |
	die := LoadedDie with: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	sequence := { 
		            (LightYear with: 75).
		            (LightYear with: 93).
		            (LightYear with: 33) }.
	boardDefinition := self
		                  boardDefinitionWithOnly:
		                  (HyperJumpEffect with: sequence)
		                  at: 2
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
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

{ #category : #'test - board' }
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

{ #category : #'test - zathura' }
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

{ #category : #'test - zathura' }
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

{ #category : #'test - doubleCard' }
ZathuraTest >> testZathuraBlueShipThrowsADoubleCardAndPlayTurnTwice [

	| zathura aDie |
	aDie := LoadedDie with: 5.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { DoubleCard new }.
	
	zathura throws: (DoubleCard thrownBy: 'BlueShip').
	zathura playTurn.
	zathura playTurn.

	self
		assert: 'BlueShip'
		isAt: 10
		with: 0
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

{ #category : #'test - freedomCard' }
ZathuraTest >> testZathuraBlueShipThrowsFreedomCardToReleaseHimself [

	| zathura aDie |
	aDie := SequencialLoadedDie with: { 2. 2. 2. 2. 2. 10 }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf: (self
				            boardDefinitionWithOnly: JailEffect new
				            at: 3
				            of: 12
				            andParsec: 100
				            played: 1)
		           rolling: aDie
		           withCards: { FreedomCard new }.

	zathura playTurn.
	zathura playTurn.
	zathura playTurn.

	self
		assert: 'BlueShip'
		isAt: 2
		with: 0
		in: zathura.

	zathura throws: (FreedomCard thrownBy: 'BlueShip' to: 'BlueShip').

	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 4
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #'test - reverseCard' }
ZathuraTest >> testZathuraBlueShipThrowsReverseCardAndAsAResultItChangeTheOrderOfTurns [

	| zathura aDie |
	aDie := LoadedDie with: 5.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { ReverseCard new }.

	zathura playTurn.
	zathura playTurn.

	zathura throws: (ReverseCard thrownBy: 'BlueShip').

	zathura playTurn.
	self
		assert: 'RedShip'
		isAt: 10
		with: 0
		in: zathura.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 10
		with: 0
		in: zathura.
	zathura playTurn.
	self
		assert: 'GreenShip'
		isAt: 5
		with: 0
		in: zathura
]

{ #category : #'test - reverseCard' }
ZathuraTest >> testZathuraBlueShipThrowsTwoReverseCardAndNothingHappens [

	| zathura aDie |
	aDie := LoadedDie with: 5.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { ReverseCard new }.

	zathura playTurn.
	zathura playTurn.

	zathura throws: (ReverseCard thrownBy: 'BlueShip').
	zathura throws: (ReverseCard thrownBy: 'BlueShip').

	zathura playTurn.

	self
		assert: 'RedShip'
		isAt: 5
		with: 0
		in: zathura.
	self
		assert: 'BlueShip'
		isAt: 5
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 5
		with: 0
		in: zathura
]

{ #category : #'test - skipCard' }
ZathuraTest >> testZathuraBlueShipThrowsTwoSkipCardsSoRedShipAndGreenShipLoseTheTurn [

	| zathura aDie |
	aDie := LoadedDie with: 5.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { SkipCard new }.

	zathura playTurn.

	zathura throws: (SkipCard thrownBy: 'BlueShip').
	zathura throws: (SkipCard thrownBy: 'BlueShip').

	zathura playTurn.

	self
		assert: 'BlueShip'
		isAt: 10
		with: 0
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

{ #category : #'test - zathuraAssertion' }
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
		withMessage: 'Zathura has been already played'
]

{ #category : #'test - zathuraAssertion' }
ZathuraTest >> testZathuraCannotThrowACardWhenTheGameHasFinished [

	| ships aDie zathura boardStructure |
	aDie := LoadedDie with: 8.
	ships := { 'BlueShip'. 'RedShip' }.

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
		should: [ zathura throws: (OverloadCard thrownBy: 'BlueShip' to: 'RedShip') ]
		raise: Error
		withMessage: 'Zathura has been already played'
]

{ #category : #'test - zathura' }
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

{ #category : #'test - zathuraAssertion' }
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

{ #category : #'test - zathura' }
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

{ #category : #'test - zathura' }
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

{ #category : #'test - repeatCard' }
ZathuraTest >> testZathuraRedShipThrowsRepeatCardToBlueShip [

	| zathura aDie |
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

	zathura throws: (RepeatCard thrownBy: 'BlueShip' to: 'RedShip' ).

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

{ #category : #'test - repeatCard' }
ZathuraTest >> testZathuraRedShipThrowsRepeatCardToHimselfWhenTheLastLockerWasANoEffectLockerAndNothingHappens [

	| zathura aDie |
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

	zathura throws: (RepeatCard thrownBy: 'BlueShip' to: 'RedShip').

	self
		assert: 'RedShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #'test - board' }
ZathuraTest >> testZathuraShipFallsIntoASpeedUpMovesFourLockersAndStaysThere [

	| die ships zathura lockers boardDefinition |
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
	boardDefinition := BoardDefinition
		                  with: lockers
		                  and: (Parsec with: 100)
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
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

{ #category : #'test - freedomCard' }
ZathuraTest >> testZathuraThrowsErrorWhenBlueShipThrowsFreedomCardToHimselfAndIsNotInJail [

	| zathura aDie |
	aDie := LoadedDie with: 2.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 12
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { FreedomCard new }.

	self
		should: [ 
		zathura throws: (FreedomCard thrownBy: 'BlueShip' to: 'BlueShip') ]
		raise: Error
		withMessage: 'The ship is not in a Jail Locker'
]

{ #category : #'test - board' }
ZathuraTest >> testZathuraWhenCrossingTheLastLockerTheShipsStartsAnotherLap [

	| die ships zathura boardDefinition |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardDefinition := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
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

{ #category : #'test - zathuraAssertion' }
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
