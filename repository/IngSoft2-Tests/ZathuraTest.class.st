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

	| zathura diceCup |
	diceCup := DiceCup withAll: { (LoadedDie with: 5) }.
	zathura := ZathuraGame
		           withShips: 5
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura start.
	self assert: zathura getWinner getId equals: 1
]

{ #category : #tests }
ZathuraTest >> testZathuraHasFinishedReturnsTrueWhenStartPlayingWithFiveShipsAndABoardAndACupDice [

	| zathura diceCup |
	diceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	zathura := ZathuraGame
		           withShips: 5
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura start.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraTest >> testZathuraInitializeWithABoardWithLessThanTwoLockersThrowsError [

	| diceCup creationOfZathura error errorMessage |
	diceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	creationOfZathura := [ 
	                     ZathuraGame
		                     withShips: 5
		                     withNumberOfLockers: 1
		                     withDiceCup: diceCup ].
	error := Error.
	errorMessage := 'Zathura cannot be played with a board with less than two lockers'.

	self should: creationOfZathura raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testZathuraInitializeWithAnEmptyDiceCupThrowsError [

	| diceCup creationOfZathura error errorMessage |
	diceCup := DiceCup withAll: {  }.
	creationOfZathura := [ 
	                     ZathuraGame
		                     withShips: 5
		                     withNumberOfLockers: 10
		                     withDiceCup: diceCup ].
	error := Error.
	errorMessage := 'Zathura cannot be played with an empty dice cup'.

	self should: creationOfZathura raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testZathuraInitializeWithLessThanTwoPlayersThrowsError [

	| diceCup creationOfZathura error errorMessage |
	diceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	creationOfZathura := [ 
	                     ZathuraGame
		                     withShips: 1
		                     withNumberOfLockers: 10
		                     withDiceCup: diceCup ].
	error := Error.
	errorMessage := 'Zathura cannot be played with less than two players'.
	
	self should: creationOfZathura raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> testZathuraReturnsTheResultOfShipNumberOne [

	| zathura diceCup |
	diceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	zathura := ZathuraGame
		           withShips: 5
		           withNumberOfLockers: 10
		           withDiceCup: diceCup.

	zathura start.
	self assert: (zathura getPositionOfShip: 1) equals: 10
]
