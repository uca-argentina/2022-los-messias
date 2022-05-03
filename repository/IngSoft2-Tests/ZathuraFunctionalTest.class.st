Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasFinishedReturnsTrue [

	| zathura die ships |
	die := (RandomDie with: 6).
	ships := { 'BlueShip'. 'RedShip'. 'GreenShip' }.
	zathura := ZathuraGame
		           with: ships
		           movedInBoardOf: 10
		           by: die.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasOnlyOneWinnerOfTheShips [

	| zathura diceCup ships aWinner notWinner |
	diceCup := RandomDie with: 6.
	ships := { 'BlueShip'. 'RedShip' }.
	zathura := ZathuraGame
		           with: ships
		           movedInBoardOf: 10
		           by: diceCup.

	zathura play.
	aWinner := ships select: [ :aShip | aShip == zathura winner ].
	notWinner := ships select: [ :aShip | aShip ~= zathura winner ].
	self assert: (aWinner at: 1) equals: zathura winner.
	self deny: (notWinner at: 1) equals: zathura winner
]
