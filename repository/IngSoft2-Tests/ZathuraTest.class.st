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
ZathuraTest >> testZathuraFirstShipWinsWhenPlayingWithALoadedDie [

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

{ #category : #tests }
ZathuraTest >> testZathuraHasFinisheDWhenPlaysWithThreeShipsAndABoardAndACupDiceUntilTheEnd [

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
ZathuraTest >> testZathuraKnowsThePositionOfShipNumberOneAfterCrossingTheFinaLocker [

	| zathura diceCup ships |
	diceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           withShips: ships
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura play.
	self assert: (zathura positionOfShip: 'BlueShip') equals: 10
]
