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
	self deny: (aBoard didShipCrossFinishLine: aRedShip).
]

{ #category : #tests }
ZathuraTest >> testZathuraAfterBeingPlayedHasFinishedReturnsTrue [

	| zathura die ships |
	die := (RandomDie with: 6).
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: die.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraTest >> testZathuraAfterBeingPlayedHasOnlyOneWinnerOfTheShips [

	| zathura diceCup ships aWinner notWinner |
	diceCup := RandomDie with: 6.
	ships := { 'BlueShip'. 'RedShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	aWinner := ships select: [ :aShip | aShip == zathura winner ].
	notWinner := ships select: [ :aShip | aShip ~= zathura winner ].
	self assert: (aWinner at: 1) equals: zathura winner.
	self deny: (notWinner at: 1) equals: zathura winner
]

{ #category : #tests }
ZathuraTest >> testZathuraAfterTheGameIsPlayedCanGetThePositionOfEachShip [

	| zathura diceCup ships |
	diceCup := DiceCup withAll: { (LoadedDie with: 6). (LoadedDie with: 2) }.
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	self assert: (zathura positionOfShip: 'BlueShip') equals: 10.
	self assert: (zathura positionOfShip: 'RedShip') equals: 8.
	self assert: (zathura positionOfShip: 'GreenShip') equals: 8
]

{ #category : #tests }
ZathuraTest >> testZathuraCreatedWithLessThanTwoLockersThrowsError [

	| aBlueShip aRedShip ships aDie zathura error errorMessage |
	aDie := LoadedDie with: 2.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.
	zathura := [ZathuraGame withShips: ships withNumberOfLockers: 1 withDiceCup: aDie].
	error := Error.
	errorMessage := 'Zathura cannot be played with a board with less than two lockers'.

	(Asserting new) should: zathura raise: error withMessage: errorMessage
	
		
]

{ #category : #tests }
ZathuraTest >> testZathuraInitializedWithLessThanTwoShipsThrowsError [

	| die creationOfZathura error errorMessage ships |
	die := (LoadedDie with: 6).
	ships := { 'BlueShip' }.
	creationOfZathura := [ 
	                     ZathuraGame
		                     withShips: ships
		                     withNumberOfLockers: 10
		                     withDiceCup: die ].
	error := Error.
	errorMessage := 'Zathura cannot be played with less than two ships'.

	(Asserting new) should: creationOfZathura raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionZero [
	| die ships zathura |
	die := LoadedDie with: 6.
	ships := { 'BlueShip'. 'RedShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: die.
	self assert: (zathura positionOfShip: 'BlueShip') equals: 0.
	self assert: (zathura positionOfShip: 'RedShip') equals: 0
]

{ #category : #tests }
ZathuraTest >> testZathuraIsPlayedAndTheWinnerIsTheGreenShip [

	| zathura die ships |
	die := (LoadedDie with: 5).
	ships := { 'GreenShip'. 'RedShip'. 'BlueShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: die.

	zathura play.
	self assert: zathura winner equals: 'GreenShip'
]
