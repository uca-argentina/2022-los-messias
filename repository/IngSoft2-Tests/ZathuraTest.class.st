Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
ZathuraTest >> assert: aShip isAt: locker with: lap in: aGame [

	self assert: (aGame positionOfShipOnBoard: aShip) equals: locker.
	self assert: (aGame numberOfLapOf: aShip) equals: lap.
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAAtomicBombAndAllShipsGoToFirstLockerOfTheSameLap [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 8.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip' with: 'GreenShip'.

	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           AtomicBombEffect new.
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
	self assert: 'GreenShip' isAt: 0 with:0 in: zathura .
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAHyperJumpLockerAndMovesMParsecs [

	| die ships zathura lockers parsecs boardStructure |
	die := LoadedDie with: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	parsecs := OrderedCollection with: 31 with: 25 with: 11.

	lockers := { 
		           LockerNoEffect new.
		           (HyperJumpEffect with: parsecs).
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
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
	self
		assert: 'BlueShip'
		isAt: 4
		with: 0
		in: zathura.
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAMoonWalkLockerAndTheResultIsItMovesAllOtherShipsBackwards [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           (MoonWalkEffect with: 2).
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
	zathura playTurn .
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

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           SpeedUpEffect new.
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
	self assert: 'BlueShip' isAt: 7 with: 0 in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAWormHoleLockerAndTheResultIsItAdvancesFourLockersBackwards [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 5.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           WormHoleEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	self assert: 'BlueShip' isAt: 1 with: 0 in: zathura
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanTwoLockers [

	Asserting new
		should: [ BoardDefinition with: {  } and: 20 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than two lockers'.

	Asserting new
		should: [ BoardDefinition with: { LockerNoEffect new } and: 20 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than two lockers'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanZeroLaps [

	Asserting new
		should: [ BoardDefinition with: { LockerNoEffect new. LockerNoEffect new } and: 10 played: 0 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero laps'.

	Asserting new
		should: [ 
		BoardDefinition with: { LockerNoEffect new. LockerNoEffect new } and: 10 played: -3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero laps'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanZeroParsecs [

	Asserting new
		should: [ 
		BoardDefinition with: { LockerNoEffect new. LockerNoEffect new } and: 0 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero parsecs'.

	Asserting new
		should: [ 
		BoardDefinition with: { LockerNoEffect new. LockerNoEffect new } and: -5 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero parsecs'
]

{ #category : #tests }
ZathuraTest >> testGreenShipWinsAndFinishesInPositionZeroWithOneLapCompleted [

	| zathura die ships lockers boardStructure |
	die := LoadedDie with: 7.
	ships := OrderedCollection
		         with: 'GreenShip'
		         with: 'RedShip'
		         with: 'BlueShip'.

	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: 100 played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

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
	self assert: zathura winner equals: 'GreenShip'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testHyperjumpCannotHaveANullParsecSequence [

	Asserting new
		should: [ HyperJumpEffect with: {  } ]
		raise: Error
		withMessage:
		'Hyperjump cannot have a null parsec sequence'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testHyperjumpCannotHaveLessThanZeroParsecsInTheSequence [

	Asserting new
		should: [ HyperJumpEffect with: { 5. -2. 10 } ]
		raise: Error
		withMessage: 'Hyperjump cannot have less than zero parsecs in the sequence'
]

{ #category : #boardStructureAssertionTests }
ZathuraTest >> testMoonwalkCannotHaveLessThanZeroLockers [

	Asserting new
		should: [ MoonWalkEffect with: 0]
		raise: Error
		withMessage: 'MoonWalk cannot be created with less than zero lockers'.

	Asserting new
		should: [ MoonWalkEffect with: -3]
		raise: Error
		withMessage: 'MoonWalk cannot be created with less than zero lockers'.
]

{ #category : #tests }
ZathuraTest >> testShipLandsOnAWormholeEffectAndGoesBackOneLap [

	| zathura sequencialDie ships lockers boardStructure |
	sequencialDie := SequencialDie with: { 11. 11. 1 }.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           WormHoleEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: sequencialDie.

	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: 'BlueShip' isAt: 8 with: 0 in: zathura.
	self assert: 'RedShip' isAt: 1 with: 1 in: zathura.
]

{ #category : #boardTests }
ZathuraTest >> testShipsFallIntoAHyperJumpLockerAndMovesMParsecsInASequence [

	| die ships zathura lockers parsecs boardStructure |
	die := LoadedDie with: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	parsecs := OrderedCollection with: 31 with: 25 with: 11.

	lockers := { 
		           LockerNoEffect new.
		           (HyperJumpEffect with: parsecs).
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
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
	self
		assert: 'BlueShip'
		isAt: 4
		with: 0
		in: zathura.
	zathura playTurn.
	self
		assert: 'RedShip'
		isAt: 3
		with: 0
		in: zathura.
	zathura playTurn.
	self
		assert: 'GreenShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #tests }
ZathuraTest >> testThePositionOfEachShipCanBeKnownWhenTheGameIsFinished [

	| zathura diceCup ships lockers boardStructure |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 6).
			           (LoadedDie with: 2) }.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: 100 played: 1.
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

	| zathura diceCup ships lockers boardStructure |
	diceCup := LoadedDie with: 1.
	lockers := { 
		           LockerNoEffect new.
		           WormHoleEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: 100 played: 1.
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

	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 0.
	self assert: (zathura numberOfLapOf: 'BlueShip') equals: 0
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraCannotBePlayedMoreThanOnce [

	| ships aDie zathura lockers boardStructure |
	aDie := LoadedDie with: 8.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		        .
	
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	
	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: aDie.
	zathura play.

	Asserting new
		should: [ zathura play ]
		raise: Error
		withMessage: 'Zathura cannot be played more than once'
]

{ #category : #tests }
ZathuraTest >> testZathuraGamePlaysATurnAndDoNotFinish [

	| ships aDie zathura lockers boardStructure |
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	aDie := RandomDie with: 3.
	ships := OrderedCollection
		         with: 'GreenShip'
		         with: 'RedShip'
		         with: 'BlueShip'.
	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
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

	Asserting new
		should: [ ZathuraGame playBy: ships movedInBoardOf: 10 rolling: die ]
		raise: Error
		withMessage: 'Zathura cannot be played with less than two ships'
]

{ #category : #tests }
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionZeroAndLapZero [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.

	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	self assert: 'BlueShip' isAt: 0 with: 0 in: zathura.
	self assert: 'RedShip' isAt: 0 with: 0 in: zathura
]

{ #category : #tests }
ZathuraTest >> testZathuraIsPlayedAndTheWinnerIsTheGreenShip [

	| zathura die ships lockers boardStructure |
	die := LoadedDie with: 7.
	ships := OrderedCollection
		         with: 'GreenShip'
		         with: 'RedShip'
		         with: 'BlueShip'.

	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: 100 played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

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
	self assert: zathura winner equals: 'GreenShip'
]

{ #category : #tests }
ZathuraTest >> testZathuraKnowsTheRankingOfAShip [

	| die ships zathura faces lockers boardStructure |
	faces := OrderedCollection with: 5 with: 8 with: 9.
	faces addLast: 5.
	faces addLast: 8.
	faces addLast: 9.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	die := SequencialDie with: faces.
	ships := OrderedCollection
		         with: 'RedShip'
		         with: 'GreenShip'
		         with: 'BlueShip'.

	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
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

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
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
	self assert: 'RedShip' isAt: 6 with: 0 in: zathura.
	self assert: 'BlueShip' isAt: 2 with: 1 in: zathura.
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraWhileItHasNotFinishedAsksWinnerThrowsError [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'GreenShip' with: 'BlueShip'.
	
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	Asserting new
		should: [ zathura winner ]
		raise: Error
		withMessage: 'Zathura has not finished yet'
]
