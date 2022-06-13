Class {
	#name : #ZathuraFunctionalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraFunctionalTest >> boardDefinitionWithRandomEffects [

	| boardDefinition probabilityDistribution points sequence |
	sequence := { 
		            (Parsec with: 2).
		            (Parsec with: 4).
		            (Parsec with: 8) }.
	points := { 
		          (PointProbability withX: LockerNoEffect new andY: 30).
		          (PointProbability withX: AtomicBombEffect new andY: 2).
		          (PointProbability
			           withX: (HyperJumpEffect with: sequence)
			           andY: 8).
		          (PointProbability
			           withX: (MoonWalkEffect with: 10)
			           andY: 10).
		          (PointProbability withX: SpeedUpEffect new andY: 20).
		          (PointProbability withX: WormHoleEffect new andY: 20).
		          (PointProbability withX: CardEffect new andY: 10) }.

	probabilityDistribution := ProbabilityDistribution withPoints: points.
	boardDefinition := (BoardDefinitionGenerator with:
		                    (RandomGenerator distributedBy:
			                     probabilityDistribution))
		                   generatesWith: 10
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
	aWinner := ships select: [ :aShip | aShip == zathura winner ship ].
	notWinner := ships select: [ :aShip | aShip ~= zathura winner ship ].
	self assert: (aWinner at: 1) equals: zathura winner ship.
	self deny: (notWinner at: 1) equals: zathura winner ship
]

{ #category : #tests }
ZathuraFunctionalTest >> testZathuraIsPlayedWithGeneratedLockers [

	| zathura die ships    |
	die := DiceCup withAll: { 
			       (RandomDie with: 6).
			       (RandomDie with: 8).
			       (RandomDie with: 3) }.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: self boardDefinitionWithRandomEffects
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
