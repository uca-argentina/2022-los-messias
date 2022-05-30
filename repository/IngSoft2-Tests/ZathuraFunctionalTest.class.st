Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasOnlyOneWinnerOfTheShips [

	| zathura diceCup ships aWinner notWinner lockers boardStructure |
	diceCup := RandomDie with: 6.
	ships := OrderedCollection with: 'RedShip' with: 'BlueShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup.

	zathura play.
	aWinner := ships select: [ :aShip | aShip == zathura winner ].
	notWinner := ships select: [ :aShip | aShip ~= zathura winner ].
	self assert: (aWinner at: 1) equals: zathura winner.
	self deny: (notWinner at: 1) equals: zathura winner
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraIsPlayedWithGeneratedLockers [

	| zathura die ships lockers boardStructure |
	die := DiceCup withAll: { 
			       (RandomDie with: 6).
			       (RandomDie with: 8).
			       (RandomDie with: 3) }.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	boardStructure := LockerFactory new
		                  generatesWith: 100
		                  and: 50
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraIsPlayedWithRandomDiceOfSixFacesAndABoardWithRandomEffectDistribution [

	| zathura die ships lockers boardStructure |
	die := RandomDie with: 6.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	boardStructure := (LockerFactory new) generatesWith: 5 and: 100  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	zathura play.
	self assert: zathura hasFinished
]
