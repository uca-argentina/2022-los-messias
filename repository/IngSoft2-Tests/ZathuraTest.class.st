Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
ZathuraTest >> should: creationOfZathura raise: error withMessage: errorMessage [

	self
		should: creationOfZathura
		raise: error
		whoseDescriptionIncludes: errorMessage
		description: 'Test did not failed as expected'
]

{ #category : #tests }
ZathuraTest >> testBoardKnowsThatAShipCrossFinishLine [

	| aQuantityLockers aBoard aRedShip ships aBlueShip |
	aQuantityLockers := 3.
	aRedShip := 'RedShip'.
	aBlueShip := 'BlueShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.
	aBoard := Board withLockers: aQuantityLockers withShips: ships.

	self assert: (aBoard movesShip: aRedShip lockers: 5)
]

{ #category : #tests }
ZathuraTest >> testBoardMovesThePositionOfShipToLastLockerWhenPassingThroughTheGoal [

	| aQuantityLockers aBoard aBlueShip aRedShip ships |
	aQuantityLockers := 3.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.
	aBoard := Board withLockers: aQuantityLockers withShips: ships.

	aBoard movesShip: aRedShip lockers: 5.
	self
		assert: (aBoard positionOfShip: aRedShip) equals: aQuantityLockers
]

{ #category : #tests }
ZathuraTest >> testBoardWithNumberOfLockersSmallerThanTwoThrowsError [

	| createBoard error errorMessage |
	createBoard := [ 
	               Board
		               withLockers: -3
		               withShips: { 'RedShip'. 'BlueShip' } ].
	error := Error.
	errorMessage := 'Zathura cannot be played with a board with less than two lockers'.
	self should: createBoard raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testDidShipCrossFinishLineWithShipPositionLessThanFinishLineIsFalse [

	| aQuantityLockers aBoard aBlueShip aRedShip ships |
	aQuantityLockers := 3.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.
	aBoard := Board withLockers: aQuantityLockers withShips: ships.

	self deny: (aBoard movesShip: aRedShip lockers: 1)
]

{ #category : #tests }
ZathuraTest >> testNumberOfLockersPostiveIsValid [

	| aQuantityLockers aBoard aBlueShip aRedShip ships |
	aQuantityLockers := 3.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.
	aBoard := Board withLockers: aQuantityLockers withShips: ships.
	self assert: aQuantityLockers > 0
]

{ #category : #tests }
ZathuraTest >> testZathuraHasFinishedAfterBlueShipReachesTheEndOfTheBoard [

	| zathura die ships |
	die := (LoadedDie with: 6).
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: die.

	zathura play.
	self assert: zathura hasFinished
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

	self should: creationOfZathura raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testZathuraKnowsThePositionOfShipsAfterTheGameFinishes [

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
ZathuraTest >> testZathuraPlayingGameWithShipsAndGreenShipWins [

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
