Class {
	#name : #BoardDefinitionGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardDefinitionGeneratorTest >> testBoardDefinitionGeneratorGeneratesABoardDefinition [

	| boardDefinition effects probabilityDistribution |
	effects := { 
		           LockerNoEffect new.
		           AtomicBombEffect new.
		           (HyperJumpEffect with: { 2. 4. 8 }).
		           (MoonWalkEffect with: 10).
		           SpeedUpEffect new.
		           WormHoleEffect new }.
	probabilityDistribution := ProbabilityDistribution with: { 40. 2. 8. 10. 20. 20 }.
	boardDefinition := (BoardDefinitionGenerator with:
		                    (RandomGenerator
			                     with: effects
			                     distributedBy: probabilityDistribution))
		                   generatesWith: 10
		                   and: 100
		                   played: 3.

	self assert: boardDefinition lockers size equals: 10.
	self assert: boardDefinition laps equals: 3.
	self assert: boardDefinition parsecsPerLocker equals: 0.1
]
