Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #assertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessParsecsThanNumberOfLockers [

	| boardStructure |
	Asserting new
		should: [ 
			boardStructure := LockerFactory new
				                  generatesWith: 50
				                  and: 20
				                  played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less parsecs than lockers'
]

{ #category : #tests }
ZathuraTest >> testWhenShipGoesBackwardsInTheFirstLapItStayesAtTheLapZero [

	| zathura diceCup ships lockers boardStructure |
	diceCup := LoadedDie with: 1.
	lockers := { 
		           LockerNoEffect new.
		           (WormHole new).
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 1.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	ships addLast: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup.

	zathura playTurn.
	zathura playTurn.

	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 0.
	self assert: (zathura numberOfLapOf: 'BlueShip') equals: 0
]

{ #category : #tests }
ZathuraTest >> testWhenShipGoesOneLapBackwardsTheNumberOfLapsIsReduced [

	| zathura sequencialDie ships lockers boardStructure |
	sequencialDie := SequencialDie with: { 11. 11. 1 }.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           WormHole new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: sequencialDie.

	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 8.
	self assert: (zathura numberOfLapOf: 'BlueShip') equals: 0.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 1.
	self assert: (zathura numberOfLapOf: 'RedShip') equals: 1
]

{ #category : #tests }
ZathuraTest >> testZathuraAfterTheGameIsPlayedCanGetThePositionOfEachShip [

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
	boardStructure := BoardStructure with: lockers and: 100 played: 1.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	ships addLast: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup.

	zathura play.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 0.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 8.
	self assert: (zathura positionOfShipOnBoard: 'GreenShip') equals: 8
]

{ #category : #boardTests }
ZathuraTest >> testZathuraBlueShipFallsIntoAAtomicBombAndAllShipsGoToFirstLocker [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           AtomicBomb new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 0.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 0
]

{ #category : #boardTests }
ZathuraTest >> testZathuraBlueShipFallsIntoAHyperJumpLockerAndMovesMParsecs [

	| die ships zathura lockers parsecs boardStructure |
	die := LoadedDie with: 1.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	parsecs := OrderedCollection new.
	parsecs add: 31.
	parsecs add: 25.
	parsecs add: 11.
	lockers := { 
		           LockerNoEffect new.
		           (HyperJump with: parsecs).
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 4
]

{ #category : #boardTests }
ZathuraTest >> testZathuraBlueShipFallsIntoAMoonWalkLockerAndTheResultIsItMovesAllShipsBackwards [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           (MoonWalk with: 2).
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 6.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 1
]

{ #category : #boardTests }
ZathuraTest >> testZathuraBlueShipFallsIntoASpeedUpLockerAndTheResultIsItAdvancesFourLockersMore [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           SpeedUp new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 7
]

{ #category : #boardTests }
ZathuraTest >> testZathuraBlueShipFallsIntoAWormHoleLockerAndTheResultIsItAdvancesFourLockersBackwards [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 5.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           WormHole new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 1
]

{ #category : #assertionTests }
ZathuraTest >> testZathuraCannotBePlayedMoreThanOnce [

	| ships aDie zathura lockers boardStructure |
	aDie := LoadedDie with: 8.
	ships := OrderedCollection new.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
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

{ #category : #assertionTests }
ZathuraTest >> testZathuraCreatedWithLessThanTwoLockersThrowsError [

	| ships aDie boardStructure |
	aDie := LoadedDie with: 2.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	boardStructure := BoardStructure with: { LockerNoEffect new } and: 100 played: 3.
	Asserting new
		should: [ 
			ZathuraGame
				playBy: ships
				movedInBoardOf: boardStructure
				rolling: aDie ]
		raise: Error
		withMessage: 'Board cannot be created with less than two lockers'
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
	ships := OrderedCollection new.
	ships addLast: 'GreenShip'.
	ships addLast: 'RedShip'.
	ships addLast: 'BlueShip'.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: aDie.
	zathura playTurn.
	self deny: zathura hasFinished
]

{ #category : #assertionTests }
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
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionZero [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection new.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 0.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 0
]

{ #category : #tests }
ZathuraTest >> testZathuraIsPlayedAndTheWinnerIsTheGreenShip [

	| zathura die ships lockers boardStructure |
	die := LoadedDie with: 5.
	ships := OrderedCollection new.
	ships addLast: 'GreenShip'.
	ships addLast: 'RedShip'.
	ships addLast: 'BlueShip'.
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
		boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	zathura play.
	self assert: zathura winner equals: 'GreenShip'
]

{ #category : #tests }
ZathuraTest >> testZathuraKnowsTheRankingOfAShip [

	| die ships zathura faces lockers boardStructure |
	faces := OrderedCollection new.
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
		           LockerNoEffect new.}.
	die := SequencialDie with: faces.
	ships := OrderedCollection new.
	ships addLast: 'RedShip'.
	ships addLast: 'GreenShip'.
	ships addLast: 'BlueShip'.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
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
ZathuraTest >> testZathuraShipFallsIntoASpeedUpAndStaysThere [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 1.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	lockers := { 
		           LockerNoEffect new.
		           SpeedUp new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           WormHole new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 6
]

{ #category : #boardTests }
ZathuraTest >> testZathuraWhenCrossingTheLastLockerTheShipsStartsAnotherLap [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
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
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 2.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 6.
	self assert: (zathura numberOfLapOf: 'BlueShip') equals: 1.
	self assert: (zathura numberOfLapOf: 'RedShip') equals: 0
]

{ #category : #assertionTests }
ZathuraTest >> testZathuraWhileItHasNotFinishedAsksWinnerThrowsError [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'GreenShip'.
	ships addLast: 'BlueShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	Asserting new
		should: [ zathura winner ]
		raise: Error
		withMessage: 'Zathura has not finished yet'
]
