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
DiceTest >> testDiceCupRollResultIsTheSumOfTheResultsOfEachIndividualDie [

	| die1 die2 die3 aDiceCup rollResult |
	die1 := LoadedDie with: 4.
	die2 := LoadedDie with: 7.
	die3 := LoadedDie with: 2.

	aDiceCup := DiceCup witAll: { 
			        die1.
			        die2.
			        die3 }.
	rollResult := aDiceCup roll.
	self assert: rollResult equals: 13
]

{ #category : #'tests - LoadedDice' }
DiceTest >> testLoadedDieCannotBeLoadedWithResultLowerThanOne [

	| error errorMessage createLoadedDie |
	error := Error.
	errorMessage := 'Die should be loaded with number greater than 0'.
	createLoadedDie := [ LoadedDie with: -1 ].
	self should: createLoadedDie raise: error withMessage: errorMessage
]

{ #category : #'tests - LoadedDice' }
DiceTest >> testLoadedDieRollsFiveWhenLoadedWithFive [

	| loadedDie rollResult |
	loadedDie := LoadedDie with: 5.
	rollResult := loadedDie roll.
	self assert: rollResult equals: 5
]

{ #category : #'tests - RandomDice' }
DiceTest >> testRandomDieCannotBeCreatedWithNumberOfFacesSmallerThanThree [

	| createRandomDie error errorMessage |
	createRandomDie := [ RandomDie with: 2 ].
	error := Error.
	errorMessage := 'Die cannot be created with a number of faces smaller than 3'.
	self should: createRandomDie raise: error withMessage: errorMessage
]

{ #category : #'tests - RandomDice' }
DiceTest >> testRandomDieIsThrownAndReturnsANumberBetweenOneAndNumberOfDiceFacesIsValid [

	| aDie aRollResutl aNumberOfFaces |
	aNumberOfFaces := 4.
	aDie := RandomDie with: aNumberOfFaces.
	aRollResutl := aDie roll.

	self assert: (aRollResutl between: 1 and: aNumberOfFaces)
]

{ #category : #'tests - RandomDice' }
DiceTest >> testRandomDieIsThrownAndReturnsANumberBetweenOneAndSixIsValid [

	| aDie aRollResult |
	aDie := RandomDie with: 6.
	aRollResult := aDie roll.

	self assert: (aRollResult between: 1 and: 6)
]

{ #category : #'tests - RandomDice' }
DiceTest >> testRandomDieIsThrownAndReturnsANumberBiggerThanNumberOfFacesIsNotValid [

	| aDie aRollResult |
	aDie := RandomDie with: 10.
	aRollResult := aDie roll.

	self deny: aRollResult > 10
]

{ #category : #'tests - RandomDice' }
DiceTest >> testRandomDieIsThrownAndReturnsANumberBiggerThanSixIsNotValid [

	| aDie aRollResult |
	aDie := RandomDie with: 6.
	aRollResult := aDie roll.

	self deny: aRollResult > 6
]

{ #category : #'tests - RandomDice' }
DiceTest >> testRandomDieIsThrownAndReturnsANumberIsValid [

	| aDie |
	aDie := RandomDie with: 6.

	self assert: aDie roll isInteger
]

{ #category : #'tests - RandomDice' }
DiceTest >> testRandomDieIsThrownAndReturnsANumberSmallerThanOneIsNotValid [

	| aDie aRollResult |
	aDie := RandomDie with: 6.
	aRollResult := aDie roll.

	self deny: aRollResult < 1
]
