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
		          (ProbabilityPoint initializeEvent: LockerNoEffect new withProbability: 30).
		          (ProbabilityPoint initializeEvent: AtomicBombEffect new withProbability: 2).
		          (ProbabilityPoint
			           initializeEvent: (HyperJumpEffect with: sequence)
			           withProbability: 8).
		          (ProbabilityPoint
			           initializeEvent: (MoonWalkEffect with: 10)
			           withProbability: 10).
		          (ProbabilityPoint initializeEvent: SpeedUpEffect new withProbability: 20).
		          (ProbabilityPoint initializeEvent: WormHoleEffect new withProbability: 20).
		          (ProbabilityPoint initializeEvent: CardEffect new withProbability: 10) }.

	probabilityDistribution := ProbabilityDistribution with: points.
	boardDefinition := BoardDefinition with:
		                    ((RandomGenerator distributedBy:
			                     probabilityDistribution) generateRandomObjectsWith: 10)
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
ZathuraFunctionalTest >> testZathuraIsPlayedWithGeneratedLockers [

	| zathura die ships |
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
		           rolling: die
		           withCards: { OverloadCard new }.

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
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura play.
	self assert: zathura hasFinished
]
