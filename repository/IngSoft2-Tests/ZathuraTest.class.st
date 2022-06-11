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

{ #category : #jvbfjdvfjvk }
ZathuraTest >> boardDefinitionWithNoEffectsOf: numberOfLockers and: parsecs played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	^ BoardDefinition with: lockers and: parsecs played: laps
]

{ #category : #'as yet unclassified' }
ZathuraTest >> boardDefinitionWithOnly: effect at: effectLockerNumber of: numberOfLockers and: parsecs played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	lockers at: effectLockerNumber put: effect.

	^ BoardDefinition with: lockers and: parsecs  played: laps
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipAndRedShipStartsTheGameWithTwoCards [

	| redShipCardHand blueShipCardHand die ships boardStructure zathura |
	die := LoadedDie with: 7.
	ships := #( 'RedShip' 'BlueShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  and: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.

	redShipCardHand := zathura cardsOf: 'RedShip'.
	self assert: redShipCardHand size equals: 2.
	blueShipCardHand := zathura cardsOf: 'BlueShip'.
	self assert: blueShipCardHand size equals: 2
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipCantThrowOverloadCardIfNotInHand [

	| zathura aDie blueShip |
	aDie := LoadedDie with: 1.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            and: 100
			            played: 1)
		           rolling: aDie
		           withCards: { AccelerationCard new }.
	blueShip := zathura zathuraShip: 'BlueShip'.
	self
		should: [ 
		blueShip using: OverloadCard new to: 'RedShip' in: zathura ]
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

	boardDefinition := self boardDefinitionWithOnly: AtomicBombEffect new
		                  at: 7
		                  of: 10
		                  and: 50
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die.
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
	boardStructure := self boardDefinitionWithOnly: (MoonWalkEffect with: 2)
		                  at: 7
		                  of: 10
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
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
	boardStructure := self boardDefinitionWithOnly: SpeedUpEffect new
		                  at: 4
		                  of: 8
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
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
	boardStructure := self boardDefinitionWithOnly: WormHoleEffect new
		                  at: 6
		                  of: 9
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 1
		with: 0
		in: zathura
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsASpeedCardToRedShipAndRedShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 20
			            and: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { SpeedCard new }.
	zBlueShip := zathura zathuraShip: 'BlueShip'.
	zBlueShip using: SpeedCard new to: 'RedShip' in: zathura.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 7;
		assert: lockersOfRedShip equals: 8.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 14;
		assert: lockersOfRedShip equals: 16
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardToRedShipAndAllShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 20
			            and: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { AccelerationCard new }.
	zBlueShip := zathura zathuraShip: 'BlueShip'.
	zBlueShip using: AccelerationCard new toAllShipsin: zathura.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 8;
		assert: lockersOfRedShip equals: 8.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 16;
		assert: lockersOfRedShip equals: 16
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndLosesOneOverloadCard [

	| zathura aDie blueShip |
	aDie := LoadedDie with: 4.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            and: 100
			            played: 1)
		           rolling: aDie
		           withCards: { OverloadCard new }.
	blueShip := zathura zathuraShip: 'BlueShip'.
	zathura playTurn.
	zathura playTurn.
	blueShip using: OverloadCard new to: 'RedShip' in: zathura.
	zathura playTurn.
	zathura playTurn.
	self assert: (blueShip cardsOf: OverloadCard new) equals: 1
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesBackwards [

	| positionOfBlueShip positionOfRedShip zathura aDie blueShip |
	aDie := SequencialLoadedDie with: { 4. 4. 1. 1 }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            and: 100
			            played: 1)
		           rolling: aDie
		           withCards: { OverloadCard new }.
	blueShip := zathura zathuraShip: 'BlueShip'.
	zathura playTurn.
	zathura playTurn.
	blueShip using: OverloadCard new to: 'RedShip' in: zathura.
	zathura playTurn.
	zathura playTurn.
	positionOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	positionOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self assert: positionOfBlueShip equals: 5.
	self assert: positionOfRedShip equals: 3
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesRolledNumberMinusTwoAllGame [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self boardDefinitionWithNoEffectsOf: 15 and: 100 played: 1)
		           rolling: diceCup
		           withCards: { OverloadCard new }.
	zBlueShip := zathura zathuraShip: 'BlueShip'.
	zBlueShip using: OverloadCard new to: 'RedShip' in: zathura.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 7;
		assert: lockersOfRedShip equals: 5.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 14;
		assert: lockersOfRedShip equals: 10
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipThenRedShipsThrowsACancellationCardWhichCancelsTheOverLoadCard [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip zRedShip |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            and: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           CancellationCard new }.
	zBlueShip := zathura zathuraShip: 'BlueShip'.
	zBlueShip using: OverloadCard new to: 'RedShip' in: zathura.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 7;
		assert: lockersOfRedShip equals: 5.
	zRedShip := zathura zathuraShip: 'BlueShip'.
	zRedShip
		using: CancellationCard new
		toCard: OverloadCard new
		in: zathura.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 14;
		assert: lockersOfRedShip equals: 12
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnAccelerationCardAndItIsNotItsTurn [

	| die ships boardStructure zathura blueShip |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  and: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { AccelerationCard new }.
	zathura playTurn.
	blueShip := zathura zathuraShip: 'BlueShip'.

	self
		should: [ 
		blueShip using: AccelerationCard new toAllShipsin: zathura ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnOverloadCardAndItIsNotItsTurn [

	| die ships boardStructure zathura blueShip |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  and: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	blueShip := zathura zathuraShip: 'BlueShip'.

	self
		should: [ 
		blueShip using: OverloadCard new to: 'RedShip' in: zathura ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnSpeedCardAndItIsNotItsTurn [

	| die ships boardStructure zathura blueShip |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  and: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { SpeedCard new }.
	zathura playTurn.
	blueShip := zathura zathuraShip: 'BlueShip'.

	self
		should: [ 
		blueShip using: SpeedCard new to: 'RedShip' in: zathura ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanTwoLockers [

	self
		should: [ 
		BoardDefinition with: { LockerNoEffect new } and: 20 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than two lockers'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanZeroLaps [

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: 10
				played: 0 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero laps'.

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: 10
				played: -3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero laps'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanZeroParsecs [

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: 0
				played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero parsecs'.

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: -5
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
		                  and: 100
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
	self assert: zathura winner ship equals: 'GreenShip'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testHyperjumpCannotHaveANullParsecSequence [

	self
		should: [ HyperJumpEffect with: {  } ]
		raise: Error
		withMessage: 'Hyperjump cannot have a null parsec sequence'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testHyperjumpCannotHaveLessThanZeroParsecsInTheSequence [

	self
		should: [ HyperJumpEffect with: { 5. -2. 10 } ]
		raise: Error
		withMessage:
		'Hyperjump cannot have less than zero parsecs in the sequence'
]

{ #category : #boardStructureAssertionTests }
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

{ #category : #tests }
ZathuraTest >> testShipLandsOnAWormholeEffectAndGoesBackOneLap [

	| zathura sequencialDie ships boardStructure |
	sequencialDie := SequencialLoadedDie with: { 11. 11. 1 }.
	boardStructure := self boardDefinitionWithOnly: WormHoleEffect new
		                  at: 3
		                  of: 10
		                  and: 100
		                  played: 3.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: sequencialDie.

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
ZathuraTest >> testShipsFallIntoAHyperJumpLockerAndMovesByTheParsecsInASequence [

	| die ships zathura parsecs boardStructure |
	die := LoadedDie with: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	parsecs := OrderedCollection with: 25 with: 31 with: 11.
	boardStructure := self boardDefinitionWithOnly: (HyperJumpEffect with: parsecs)
		                  at: 2
		                  of: 10
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
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
	boardStructure := self boardDefinitionWithNoEffectsOf: 10
		                  and: 100
		                  played: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup.

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
	boardStructure := self boardDefinitionWithOnly: WormHoleEffect new
		                  at: 2
		                  of: 10
		                  and: 50
		                  played: 3.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup.

	zathura playTurn.
	zathura playTurn.

	self assert: (zathura numberOfLockerOf: 'BlueShip') equals: 0.
	self assert: (zathura numberOfLapOf: 'BlueShip') equals: 0
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraCannotBePlayedMoreThanOnce [

	| ships aDie zathura lockers boardStructure |
	aDie := LoadedDie with: 8.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self boardDefinitionWithNoEffectsOf: 5
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: aDie.
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
	boardStructure := self boardDefinitionWithNoEffectsOf: 5
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: aDie.
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
		should: [ ZathuraGame playBy: ships movedInBoardOf: 10 rolling: die ]
		raise: Error
		withMessage: 'Zathura cannot be played with less than two ships'
]

{ #category : #tests }
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionZeroAndLapZero [

	| die ships zathura boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self boardDefinitionWithNoEffectsOf: 5
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
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

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testZathuraKnowsTheNameOfShipWithHandOfCards [

	| aShipWithHandOfCards aShip effects probabilityDistribution boardDefinition die ships zathura |
	aShip := 'RedShip'.
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           WormHoleEffect new.
		           CardEffect new.
		           SpeedUpEffect new }.
	probabilityDistribution := ProbabilityDistribution withX: effects  andY: { 30. 2. 8. 10. 20. 10. 20 }.

	boardDefinition := (BoardDefinitionGenerator with:
		                    (RandomGenerator distributedBy:
			                     probabilityDistribution))
		                   generatesWith: 100
		                   and: 50
		                   played: 3.

	die := RandomDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die
		           withCards: { OverloadCard new }.

	aShipWithHandOfCards := zathura zathuraShip: aShip.

	self assert: aShipWithHandOfCards ship equals: aShip
]

{ #category : #tests }
ZathuraTest >> testZathuraKnowsTheRankingOfAShip [

	| die ships zathura faces boardStructure |
	faces := OrderedCollection with: 5 with: 8 with: 9.
	faces addLast: 5.
	faces addLast: 8.
	faces addLast: 9.
	die := SequencialLoadedDie with: faces.
	ships := OrderedCollection
		         with: 'RedShip'
		         with: 'GreenShip'
		         with: 'BlueShip'.

	boardStructure := self boardDefinitionWithNoEffectsOf: 7
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

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

{ #category : #tests }
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
	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: 'BlueShip' isAt: 6 with: 0 in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testZathuraWhenCrossingTheLastLockerTheShipsStartsAnotherLap [

	| die ships zathura boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self boardDefinitionWithNoEffectsOf: 10
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
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

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'GreenShip' with: 'BlueShip'.
	boardStructure := self boardDefinitionWithNoEffectsOf: 3
		                  and: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	self
		should: [ zathura winner ]
		raise: Error
		withMessage: 'Zathura has not finished yet'
]
