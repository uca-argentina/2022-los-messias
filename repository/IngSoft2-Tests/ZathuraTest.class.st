Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraTest >> testDidShipCrossFinishLineWithShipPositionLessThanFinishLineIsFalse [

	| aQuantityLockers aBoard aBlueShip aRedShip ships |
	aQuantityLockers := 3.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.
	aBoard := Board of: aQuantityLockers withAll: ships.
	aBoard move: aRedShip by: 1.
	self deny: (aBoard hasCrossFinishLine: aRedShip).
]

{ #category : #tests }
ZathuraTest >> testZathuraAfterTheGameIsPlayedCanGetThePositionOfEachShip [

	| zathura diceCup ships |
	diceCup := DiceCup withAll: { (LoadedDie with: 6). (LoadedDie with: 2) }.
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           with: ships
		           movedInBoardOf: 10
		           by: diceCup.

	zathura play.
	self assert: (zathura positionOfShip: 'BlueShip') equals: 10.
	self assert: (zathura positionOfShip: 'RedShip') equals: 8.
	self assert: (zathura positionOfShip: 'GreenShip') equals: 8
]

{ #category : #tests }
ZathuraTest >> testZathuraCannotBePlayedMoreThanOnceBANANA [

	| aBlueShip aRedShip ships aDie zathura |
	aDie := LoadedDie with: 8.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.

	zathura := ZathuraGame
		           with: ships
		           movedInBoardOf: 50
		           by: aDie.
zathura play.

	Asserting new
		should: [ zathura play ]
		raise: Error
		withMessage: 'Zathura cannot be played more than once'
]

{ #category : #tests }
ZathuraTest >> testZathuraCreatedWithLessThanTwoLockersThrowsError [

	| aBlueShip aRedShip ships aDie |
	aDie := LoadedDie with: 2.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.

	Asserting new
		should: [ 
			ZathuraGame
				with: ships
				movedInBoardOf: 1
				by: aDie ]
		raise: Error
		withMessage:
		'Board cannot be created with less than two lockers'
]

{ #category : #tests }
ZathuraTest >> testZathuraInitializedWithLessThanTwoShipsThrowsError [

	| die ships |
	die := LoadedDie with: 6.
	ships := { 'BlueShip' }.

	Asserting new
		should: [ 
			ZathuraGame
				with: ships
				movedInBoardOf: 10
				by: die ]
		raise: Error
		withMessage: 'Zathura cannot be played with less than two ships'
]

{ #category : #tests }
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionZero [
	| die ships zathura |
	die := LoadedDie with: 6.
	ships := { 'BlueShip'. 'RedShip' }.
	zathura := ZathuraGame
		           with: ships
		           movedInBoardOf: 10
		           by: die.
	self assert: (zathura positionOfShip: 'BlueShip') equals: 0.
	self assert: (zathura positionOfShip: 'RedShip') equals: 0
]

{ #category : #tests }
ZathuraTest >> testZathuraIsPlayedAndTheWinnerIsTheGreenShip [

	| zathura die ships |
	die := (LoadedDie with: 5).
	ships := { 'GreenShip'. 'RedShip'. 'BlueShip' }.
	zathura := ZathuraGame
		           with: ships
		           movedInBoardOf: 10
		           by: die.

	zathura play.
	self assert: zathura winner equals: 'GreenShip'
]

{ #category : #tests }
ZathuraTest >> testZathuraWhileItHasNotFinishedAsksWinnerThrowsError [

	| die ships zathura |
	die := LoadedDie with: 6.
	ships := { 'BlueShip'. 'GreenShip' }.

	zathura := ZathuraGame with: ships movedInBoardOf: 10 by: die.

	Asserting new
		should: [ zathura winner ]
		raise: Error
		withMessage: 'Zathura has not finished yet'
]
