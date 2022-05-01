Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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

{ #category : #'real tests' }
ZathuraTest >> testZathuraAfterBeingPlayedHasFinishedReturnsTrue [

	| zathura diceCup ships |
	diceCup := RandomDie with: 6.
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #'real tests' }
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
	diceCup := LoadedDie with: 6.
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	self assert: (zathura positionOfShip: 'BlueShip') equals: 10.
	self assert: (zathura positionOfShip: 'RedShip') equals: 6.
	self assert: (zathura positionOfShip: 'GreenShip') equals: 6
]

{ #category : #tests }
ZathuraTest >> testZathuraInitializedWithLessThanTwoShipsThrowsError [

	| diceCup creationOfZathura error errorMessage ships asserting |
	diceCup := LoadedDie with: 6.
	ships := { 'BlueShip' }.
	creationOfZathura := [ 
	                     ZathuraGame
		                     withShips: ships
		                     withNumberOfLockers: 10
		                     withDiceCup: diceCup ].
	error := Error.
	errorMessage := 'Zathura cannot be played with less than two ships'.

	(Asserting new)
		should: creationOfZathura
		raise: error
		withMessage: errorMessage
]

{ #category : #'real tests' }
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionCero [

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
	errorMessage := 'The board cannot be used with less than two lockers'.
	Asserting new
		should: creationOfZathura
		raise: error
		withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testZathuraIsPlayedAndTheWinnerIsTheGreenShip [

	| zathura diceCup ships |
	diceCup := LoadedDie with: 5.
	ships := { 'GreenShip'. 'RedShip'. 'BlueShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	self assert: zathura winner equals: 'GreenShip'
]
