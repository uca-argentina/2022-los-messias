Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasFinishedReturnsTrue [

	| zathura die ships |
	die := RandomDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.
	ships addLast: 'RedShip'.
	ships addLast: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: 10
		           and: 1
		           rolling: die.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasOnlyOneWinnerOfTheShips [

	| zathura diceCup ships aWinner notWinner |
	diceCup := RandomDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'RedShip'.
	ships addLast: 'BlueShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: 10
		           and: 1
		           rolling: diceCup.

	zathura play.
	aWinner := ships select: [ :aShip | aShip == zathura winner ].
	notWinner := ships select: [ :aShip | aShip ~= zathura winner ].
	self assert: (aWinner at: 1) equals: zathura winner.
	self deny: (notWinner at: 1) equals: zathura winner
]
