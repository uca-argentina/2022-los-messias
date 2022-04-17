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
BoardTest >> testDidShipCrossFinishLineWithShipPositionGreaterThanFinishLineIsTrue [

	| aQuantityLockers aBoard aShip |
	aQuantityLockers := 3.
	aShip := 4.
	aBoard := Board with: aQuantityLockers.
	self assert: (aBoard didShipCrossFinishLine: aShip)
]

{ #category : #tests }
BoardTest >> testDidShipCrossFinishLineWithShipPositionLessThanFinishLineIsFalse [

	| aQuantityLockers aBoard aShip |
	aQuantityLockers := 3.
	aShip := 1.
	aBoard := Board with: aQuantityLockers.
	self deny: (aBoard didShipCrossFinishLine: aShip)
]

{ #category : #tests }
BoardTest >> testNegativeLengthOfNumberOfLockersIsInvalid [

	self
		should: [ Board with: -3 ]
		raise: Error
		withMessage: 'Number of Lockers should be positive'
]

{ #category : #tests }
BoardTest >> testNumberOfLockersPostiveAndIntegerIsValid [

	| aQuantityLockers aBoard |
	aQuantityLockers := 3.
	aBoard := Board with: aQuantityLockers.
	self assert: aQuantityLockers > 0
]

{ #category : #tests }
BoardTest >> testShipStartsAtPositionCeroIsValid [

	| aBoard positionShip |
	aBoard := Board with: 3.
	positionShip := aBoard getPositionShip: 0.
	self assert: positionShip equals: 0
]
