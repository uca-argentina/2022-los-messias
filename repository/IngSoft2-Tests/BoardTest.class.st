Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

	| tmp2 tmp3 |
	aBlock
		on: anError
		do: [ :error | 
			tmp2 := true.
			tmp3 := error messageText ].
	self
		assert: tmp2;
		assert: tmp3 equals: anErrorMessage
]

{ #category : #tests }
BoardTest >> testBoardUpdatesPositionOfShipToLastLockerWhenPassingThroughTheGoal [
	| aQuantityLockers aBoard aShip |
	aQuantityLockers := 3.
	aShip := Ship with: 1.
	aShip advances: 5.
	aBoard := Board with: aQuantityLockers.
	aBoard didShipCrossFinishLine: aShip.
	self assert: (aShip isInPosition == aQuantityLockers )
]

{ #category : #tests }
BoardTest >> testBoardWithNumberOfLockersSmallerThanTwoIsNotValid [

	self
		should: [ Board with: -3 ]
		raise: Error
		withMessage: 'Zathura cannot be played with a board with less than two lockers'
]

{ #category : #tests }
BoardTest >> testDidShipCrossFinishLineWithShipPositionGreaterThanFinishLineIsTrue [

	| aQuantityLockers aBoard aShip |
	aQuantityLockers := 3.
	aShip := Ship with: 1.
	aShip advances: 4.
	aBoard := Board with: aQuantityLockers.
	self assert: (aBoard didShipCrossFinishLine: aShip)
]

{ #category : #tests }
BoardTest >> testDidShipCrossFinishLineWithShipPositionLessThanFinishLineIsFalse [

	| aQuantityLockers aBoard aShip |
	aQuantityLockers := 3.
	aShip := Ship with: 1.
	aBoard := Board with: aQuantityLockers.
	self deny: (aBoard didShipCrossFinishLine: aShip)
]

{ #category : #tests }
BoardTest >> testNumberOfLockersPostiveAndIntegerIsValid [

	| aQuantityLockers aBoard |
	aQuantityLockers := 3.
	aBoard := Board with: aQuantityLockers.
	self assert: aQuantityLockers > 0
]
