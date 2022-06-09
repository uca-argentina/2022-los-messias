Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> boardDefinitionWithRandomEffects [

	| effects boardDefinition probabilityDistribution |
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 5).
		           SpeedUpEffect new.
		           WormHoleEffect new }.
	probabilityDistribution := ProbabilityDistribution with:
		                           { 40. 2. 8. 10. 20. 20 }.
	boardDefinition := (BoardDefinitionGenerator with:
		                    (RandomGenerator
			                     with: effects
			                     distributedBy: probabilityDistribution))
		                   generatesWith: 100
		                   and: 50
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
	aWinner := ships select: [ :aShip | aShip == zathura winner ship ].
	notWinner := ships select: [ :aShip | aShip ~= zathura winner ship ].
	self assert: (aWinner at: 1) equals: zathura winner ship.
	self deny: (notWinner at: 1) equals: zathura winner ship
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraIsPlayedWithGeneratedLockers [

	| zathura die ships effects probabilityDistribution boardDefinition |
	die := DiceCup withAll: { 
			       (RandomDie with: 6).
			       (RandomDie with: 8).
			       (RandomDie with: 3) }.
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           WormHoleEffect new.
		           CardEffect new.
		           SpeedUpEffect new }.
	probabilityDistribution := ProbabilityDistribution with:
		                           { 30. 2. 8. 10. 20. 10. 20 }.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	boardDefinition := (BoardDefinitionGenerator with:
		                    (RandomGenerator
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

	| zathura die |
	die := RandomDie with: 6.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf: self boardDefinitionWithRandomEffects
		           rolling: die.
	zathura play.
	self assert: zathura hasFinished
]
