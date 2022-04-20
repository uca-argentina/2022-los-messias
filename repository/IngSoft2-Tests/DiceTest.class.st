Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DiceTest >> should: createRandomDie raise: error withMessage: errorMessage [

	self
		should: createRandomDie
		raise: error
		whoseDescriptionIncludes: errorMessage
		description: 'Test did not failed as expected'
]

{ #category : #'tests  - DiceCup' }
DiceTest >> testDiceCupIsInitializedWithLessThanOneDieThrowsError [

	| error errorMessage createLoadedDie |
	error := Error.
	errorMessage := 'Dice Cup should be initialized with at least one die'.
	createLoadedDie := [ DiceCup withAll: {  } ].
	self should: createLoadedDie raise: error withMessage: errorMessage
]

{ #category : #'tests  - DiceCup' }
DiceTest >> testDiceCupRollResultIsTheSumOfTheResultsOfEachIndividualDie [

	| aDiceCup rollResult |
	aDiceCup := DiceCup withAll: { 
			            (LoadedDie with: 4).
			            (LoadedDie with: 7).
			            (LoadedDie with: 2) }.
	rollResult := aDiceCup roll.
	self assert: rollResult equals: 13
]

{ #category : #'tests - LoadedDie' }
DiceTest >> testLoadedDieCannotBeLoadedWithResultLowerThanOne [

	| error errorMessage createLoadedDie |
	error := Error.
	errorMessage := 'Die should be loaded with number greater than 0'.
	createLoadedDie := [ LoadedDie with: -1 ].
	self should: createLoadedDie raise: error withMessage: errorMessage
]

{ #category : #'tests - LoadedDie' }
DiceTest >> testLoadedDieRollsFiveWhenLoadedWithFive [

	| loadedDie rollResult |
	loadedDie := LoadedDie with: 5.
	rollResult := loadedDie roll.
	self assert: rollResult equals: 5
]

{ #category : #'tests - RandomDie' }
DiceTest >> testRandomDieCannotBeCreatedWithNumberOfFacesSmallerThanThree [

	| createRandomDie error errorMessage |
	createRandomDie := [ RandomDie with: 2 ].
	error := Error.
	errorMessage := 'Die cannot be created with a number of faces smaller than 3'.
	self should: createRandomDie raise: error withMessage: errorMessage
]

{ #category : #'tests - RandomDie' }
DiceTest >> testRandomDieRollsAndTheResultANumberSmallerThanOneIsNotValid [

	| aDie aRollResult |
	aDie := RandomDie with: 6.
	aRollResult := aDie roll.

	self deny: aRollResult < 1
]

{ #category : #'tests - RandomDie' }
DiceTest >> testRandomDieRollsAndTheResultIsANumberBetweenOneAndNumberOfDiceFacesIsValid [

	| aDie aRollResutl aNumberOfFaces |
	aNumberOfFaces := 4.
	aDie := RandomDie with: aNumberOfFaces.
	aRollResutl := aDie roll.

	self assert: (aRollResutl between: 1 and: aNumberOfFaces)
]

{ #category : #'tests - RandomDie' }
DiceTest >> testRandomDieRollsAndTheResultIsANumberBiggerThanNumberOfFacesIsNotValid [

	| aDie aRollResult |
	aDie := RandomDie with: 10.
	aRollResult := aDie roll.

	self deny: aRollResult > 10
]
