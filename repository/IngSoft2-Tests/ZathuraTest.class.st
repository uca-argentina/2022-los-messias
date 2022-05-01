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

	| aQuantityLockers aBoard aBlueShip aRedShip ships |
	aQuantityLockers := 3.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.
	aBoard := Board of: aQuantityLockers withAll: ships.
	aBoard move: aRedShip by: 5.
	self assert: (aBoard didShipCrossFinishLine: aRedShip )
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
	aBoard := Board of: aQuantityLockers withAll: ships.

	aBoard move: aRedShip by: 5.
	self
		assert: (aBoard positionOfShip: aRedShip) equals: aQuantityLockers
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
	aBoard := Board of: aQuantityLockers withAll: ships.
	aBoard move: aRedShip by: 1.
	self deny: (aBoard didShipCrossFinishLine: aRedShip )
]

{ #category : #tests }
ZathuraTest >> testZathuraAfterBeingPlayedHasFinishedReturnsTrue [

	| zathura diceCup ships |
	diceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip'}.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraTest >> testZathuraAfterTheGameIsPlayedCanGetThePositionOfEachShip [

	| zathura diceCup ships |
	diceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	self assert: (zathura positionOfShip: 'BlueShip') equals: 10.
	self assert: (zathura positionOfShip: 'RedShip') equals: 6.
	self assert: (zathura positionOfShip: 'GreenShip') equals: 6.
]

{ #category : #tests }
ZathuraTest >> testZathuraInitializedWithLessThanTwoShipsThrowsError [

	| diceCup creationOfZathura error errorMessage ships |
	diceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	ships := { 'BlueShip' }.
	creationOfZathura := [ 
	                     ZathuraGame
		                     withShips: ships
		                     withNumberOfLockers: 10
		                     withDiceCup: diceCup ].
	error := Error.
	errorMessage := 'Zathura cannot be played with less than two ships'.

	self should: creationOfZathura raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testZathuraIsInitializedWithLessThanTwoLockersThrowsError [

	| error errorMessage die ships creationOfZathura |
	die := LoadedDie with: 6.
	ships := { 'BlueShip'. 'RedShip' }.
	creationOfZathura := [ 
	                     ZathuraGame
		                     withShips: ships
		                     withNumberOfLockers: 1
		                     withDiceCup: die ].
	error := Error.
	errorMessage := 'Zathura cannot be played with a board with less than two lockers'.
	self should: creationOfZathura raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testZathuraIsPlayedAndTheWinnerIsTheGreenShip [

	| zathura diceCup ships |
	diceCup := DiceCup withAll: { (LoadedDie with: 5) }.
	ships := { 'GreenShip'. 'RedShip'. 'BlueShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	self assert: zathura winner equals: 'GreenShip'
]
