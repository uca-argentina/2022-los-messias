Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraAfterBeingPlayedHasOnlyOneWinnerOfTheShips [

	| zathura diceCup ships aWinner notWinner  boardStructure |
	diceCup := RandomDie with: 6.
	ships := OrderedCollection with: 'RedShip' with: 'BlueShip'.
	boardStructure := BoardDefinition
		                  withNoEffectsOf: 9
		                  and: 100
		                  played: 3.
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

	| zathura die ships boardStructure effects probabilityDistribution boardDefinition |
	die := DiceCup withAll: { 
			       (RandomDie with: 6).
			       (RandomDie with: 8).
			       (RandomDie with: 3) }.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           SpeedUpEffect new.
		           WormHoleEffect new }.
	probabilityDistribution := ProbabilityDistribution with:
		                           { 40. 2. 8. 10. 20. 20 }.
	boardDefinition := (BoardDefinitionGenerator with:
		                    (LockerGenerator
			                     with: effects
			                     distributedBy: probabilityDistribution))
		                   generatesWith: 100
		                   and: 50
		                   played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die.

	zathura play.
	self assert: zathura hasFinished
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraIsPlayedWithRandomDiceOfSixFacesAndABoardWithRandomEffectDistribution [

	| zathura die ships effects probabilityDistribution boardDefinition |
	die := RandomDie with: 6.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           SpeedUpEffect new.
		           WormHoleEffect new }.
	probabilityDistribution := ProbabilityDistribution with:
		                           { 40. 2. 8. 10. 20. 20 }.
	boardDefinition := (BoardDefinitionGenerator with:
		                    (LockerGenerator
			                     with: effects
			                     distributedBy: probabilityDistribution))
		                   generatesWith: 100
		                   and: 50
		                   played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die.

	zathura play.
	self assert: zathura hasFinished
]
