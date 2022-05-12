Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasFinishedReturnsTrue [

	| zathura die ships lockers |
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
		           LockerNoEffect new.}.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 1
		           rolling: die.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasOnlyOneWinnerOfTheShips [

	| zathura diceCup ships aWinner notWinner lockers |
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
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: lockers
		           and: 1
		           rolling: diceCup.

	zathura play.
	aWinner := ships select: [ :aShip | aShip == zathura winner ].
	notWinner := ships select: [ :aShip | aShip ~= zathura winner ].
	self assert: (aWinner at: 1) equals: zathura winner.
	self deny: (notWinner at: 1) equals: zathura winner
]
