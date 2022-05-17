Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasFinishedReturnsTrue [

	| zathura die ships lockers boardStructure |
	die := RandomDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	ships addLast: 'GreenShip'.
	lockers := { 
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
		boardStructure := BoardStructure with: lockers and: 100 played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasOnlyOneWinnerOfTheShips [

	| zathura diceCup ships aWinner notWinner lockers boardStructure |
	diceCup := RandomDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'RedShip'.
	ships addLast: 'BlueShip'.
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
		boardStructure := BoardStructure with: lockers and: 100 played: 3.
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
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	ships addLast: 'GreenShip'.
	boardStructure := LockerFactory new
		                  generatesWith: 100
		                  and: 1000
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	zathura play.
	self assert: zathura hasFinished
]
