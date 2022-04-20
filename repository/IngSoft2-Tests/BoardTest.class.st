Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

	| blockFail errorMessage |
	blockFail := false.
	aBlock
		on: anError
		do: [ :error | 
			blockFail := true.
			errorMessage := error messageText ].
	self
		assert: blockFail;
		assert: errorMessage equals: anErrorMessage
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
BoardTest >> testBoardWithNumberOfLockersSmallerThanTwoIsNotValid [

	self
		should: [ Board withLockers: -3 withShips: { 'RedShip'. 'BlueShip' } ]
		raise: Error
		withMessage:
		'Zathura cannot be played with a board with less than two lockers'
]

{ #category : #tests }
BoardTest >> testDidShipCrossFinishLineWithShipPositionGreaterThanFinishLineIsTrue [

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
BoardTest >> testNumberOfLockersPostiveAndIntegerIsValid [

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
