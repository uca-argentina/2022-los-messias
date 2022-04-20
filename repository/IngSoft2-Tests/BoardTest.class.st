Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: createBoard raise: error withMessage: errorMessage [

	self
		should: createBoard
		raise: error
		whoseDescriptionIncludes: errorMessage
		description: 'Test did not failed as expected'
]

{ #category : #tests }
BoardTest >> testBoardKnowsThatAShipCrossFinishLine [

	| aQuantityLockers aBoard aBlueShip aRedShip ships |
	aQuantityLockers := 3.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { 
		         aRedShip.
		         aBlueShip }.
	aBoard := Board withLockers: aQuantityLockers withShips: ships.

	self assert: (aBoard movesShip: aRedShip lockers: 5)
]

{ #category : #tests }
BoardTest >> testBoardKnowsThePositionOfAShip [

	| aQuantityLockers aBoard aRedShip ships aBlueShip |
	aQuantityLockers := 3.
	aBlueShip := 'BlueShip'.
	aRedShip := 'RedShip'.
	ships := { aRedShip. aBlueShip }.
	aBoard := Board withLockers: aQuantityLockers withShips: ships.
	self assert: (aBoard positionOfShip: aRedShip) equals: 0
]

{ #category : #tests }
BoardTest >> testBoardMovesThePositionOfShipToLastLockerWhenPassingThroughTheGoal [

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
		assert: (aBoard positionOfShip: aRedShip)
		equals: aQuantityLockers
]

{ #category : #tests }
BoardTest >> testBoardWithNumberOfLockersSmallerThanTwoThrowsError [

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
BoardTest >> testDidShipCrossFinishLineWithShipPositionLessThanFinishLineIsFalse [

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
BoardTest >> testNumberOfLockersPostiveIsValid [

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
