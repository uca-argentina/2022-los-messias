Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> boardDefinitionWithRandomEffects [

	| boardDefinition lockers |
	lockers := (RandomGeneratorTest new)
		           generateWithTheOrdinaryDistributionACollectionOfLockersOf:
		           10.
	boardDefinition := BoardDefinition
		                   with: lockers
		                   and: (Parsec with: 50)
		                   played: 3.
	^ boardDefinition
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasOnlyOneWinnerOfTheShips [

	| zathura diceCup ships aWinner notWinner boardDefinition |
	diceCup := RandomDie with: 6.
	ships := OrderedCollection with: 'RedShip' with: 'BlueShip'.
	boardDefinition := self boardDefinitionWithRandomEffects.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: diceCup
		           withCards: { OverloadCard new }.

	zathura play.
	aWinner := ships select: [ :aShip | aShip == zathura winner  ].
	notWinner := ships select: [ :aShip | aShip ~= zathura winner  ].
	self assert: (aWinner at: 1) equals: zathura winner .
	self deny: (notWinner at: 1) equals: zathura winner 
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraIsPlayedWithRandomDiceOfSixFacesAndABoardWithRandomEffectDistribution [

	| zathura die |
	die := RandomDie with: 6.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf: self boardDefinitionWithRandomEffects
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraIsPlayedWithRandomGeneratedLockersAndCards [

	| zathura die ships deck |
	die := DiceCup withAll: { 
			       (RandomDie with: 6).
			       (RandomDie with: 8).
			       (RandomDie with: 3) }.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	deck := (RandomGeneratorTest new) generateWithTheOrdinaryDistributionADeckOf: 50.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: self boardDefinitionWithRandomEffects
		           rolling: die
		           withCards: deck.

	zathura play.
	self assert: zathura hasFinished
]
