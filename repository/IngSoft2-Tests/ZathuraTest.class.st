Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraTest >> testZathuraAfterTheGameIsPlayedCanGetThePositionOfEachShip [

	| zathura diceCup ships lockers |
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
	"ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }."
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	ships addLast: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 1
		           rolling: diceCup.

	zathura play.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 0.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 8.
	self assert: (zathura positionOfShipOnBoard: 'GreenShip') equals: 8
]

{ #category : #boardTests }
ZathuraTest >> testZathuraBlueShipFallsIntoASpeedUpLockerAndTheResultIsItAdvancesFourLockersMore [

	| die ships zathura lockers |
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
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 5
		           rolling: die.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 7
]

{ #category : #tests }
ZathuraTest >> testZathuraCannotBePlayedMoreThanOnceBANANA [

	| ships aDie zathura lockers |
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
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 1
		           rolling: aDie.
	zathura play.

	Asserting new
		should: [ zathura play ]
		raise: Error
		withMessage: 'Zathura cannot be played more than once'
]

{ #category : #tests }
ZathuraTest >> testZathuraCreatedWithLessThanTwoLockersThrowsError [

	| ships aDie |
	aDie := LoadedDie with: 2.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.

	Asserting new
		should: [ 
			ZathuraGame
				playBy: ships
				movedInBoardOf: { LockerNoEffect new }
				and: 1
				rolling: aDie ]
		raise: Error
		withMessage: 'Board cannot be created with less than two lockers'
]

{ #category : #tests }
ZathuraTest >> testZathuraGamePlaysATurnAndDoNotFinish [

	| ships aDie zathura lockers |
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
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 1
		           rolling: aDie.
	zathura playTurn.
	self deny: zathura hasFinished
]

{ #category : #tests }
ZathuraTest >> testZathuraInitializedWithLessThanTwoShipsThrowsError [

	| die ships |
	die := LoadedDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.

	Asserting new
		should: [ 
			ZathuraGame
				playBy: ships
				movedInBoardOf: 10
				and: 1
				rolling: die ]
		raise: Error
		withMessage: 'Zathura cannot be played with less than two ships'
]

{ #category : #tests }
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionZero [

	| die ships zathura lockers |
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
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers 
		           and: 1
		           rolling: die.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 0.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 0
]

{ #category : #tests }
ZathuraTest >> testZathuraIsPlayedAndTheWinnerIsTheGreenShip [

	| zathura die ships lockers |
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
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 1
		           rolling: die.

	zathura play.
	self assert: zathura winner equals: 'GreenShip'
]

{ #category : #tests }
ZathuraTest >> testZathuraKnowsTheRankingOfAShip [

	| die ships zathura faces lockers |
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
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	die := SequencialDie with: faces.
	ships := OrderedCollection new.
	ships addLast: 'RedShip'.
	ships addLast: 'GreenShip'.
	ships addLast: 'BlueShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 5
		           rolling: die.

	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	"self assert: (zathura rankingOf: 'BlueShip') equals: 1.
	self assert: (zathura rankingOf: 'GreenShip') equals: 2.
	self assert: (zathura rankingOf: 'RedShip') equals: 3."

	self assert: (zathura rankingOf: 'GreenShip') equals: 2.
	self assert: (zathura rankingOf: 'BlueShip') equals: 1.
	self assert: (zathura rankingOf: 'RedShip') equals: 3
]

{ #category : #boardTests }
ZathuraTest >> testZathuraWhenCrossingTheLastLockerTheShipsStartsAnotherLap [

	| die ships zathura lockers |
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
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 5
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: (zathura positionOfShipOnBoard: 'BlueShip') equals: 2.
	self assert: (zathura positionOfShipOnBoard: 'RedShip') equals: 6.
	self assert: (zathura numberOfLapsOf: 'BlueShip') equals: 1.
	self assert: (zathura numberOfLapsOf: 'RedShip') equals: 0
]

{ #category : #tests }
ZathuraTest >> testZathuraWhileItHasNotFinishedAsksWinnerThrowsError [

	| die ships zathura lockers |
	die := LoadedDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'GreenShip'.
	ships addLast: 'BlueShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new. }.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 1
		           rolling: die.

	Asserting new
		should: [ zathura winner ]
		raise: Error
		withMessage: 'Zathura has not finished yet'
]
