Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
ZathuraTest >> assert: aShip isAt: locker with: lap in: aGame [

	self assert: (aGame numberOfLockerOf: aShip) equals: locker.
	self assert: (aGame numberOfLapOf: aShip) equals: lap.
]

{ #category : #boardSpecificDefinitions }
ZathuraTest >> boardDefinitionWithNoEffectsOf: numberOfLockers and: unitMeasure played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	^ BoardDefinition
		  with: lockers
		  and: unitMeasure
		  played: laps
]

{ #category : #boardSpecificDefinitions }
ZathuraTest >> boardDefinitionWithNoEffectsOf: numberOfLockers andParsec: parsec played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	^ BoardDefinition with: lockers and: (Parsec with: parsec) played: laps
]

{ #category : #boardSpecificDefinitions }
ZathuraTest >> boardDefinitionWithOnly: effect at: effectLockerNumber of: numberOfLockers andParsec: parsec played: laps [

	| lockers |
	lockers := OrderedCollection new.
	1 to: numberOfLockers do: [ :number | 
	lockers add: LockerNoEffect new ].
	lockers at: effectLockerNumber put: effect.

	^ BoardDefinition with: lockers and: (Parsec with: parsec) played: laps
]

{ #category : #tests }
ZathuraTest >> testAnObjectIsEqualToAnotherObjectIfTheyHaveTheSameClass [

	| anOverloadCard anotherOverLoadCard |
	anOverloadCard := OverloadCard new.
	anotherOverLoadCard := OverloadCard new.
	self assert: (anOverloadCard hasEqualClass: anotherOverLoadCard)
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipAndRedShipStartsTheGameWithTwoCards [

	| redShipCardHand blueShipCardHand die ships boardStructure zathura cardManager |
	die := LoadedDie with: 2.
	ships := #( 'RedShip' 'BlueShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10 andParsec: 100  played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.

	cardManager:= CardManager intializeIn: zathura .
	redShipCardHand := cardManager cardsOf: 'RedShip'.
	blueShipCardHand := cardManager  cardsOf: 'BlueShip'.
	self assert: redShipCardHand size equals: 2.
	self assert: blueShipCardHand size equals: 2.
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipCantThrowCancellationCardIfNoCardsHaveBeenPlayed [

	| diceCup zathura  cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           CancellationCard new }.
	cardManager := zathura cardManager.
	self
		should: [ 
			cardManager
				throw: CancellationCard new
				to: 'RedShip'
				removing: OverloadCard new
				from: 'BlueShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipCantThrowCancellationCardToOverloadCardIfNoOverloadCardsHaveBeenPlayed [

	| diceCup zathura zBlueShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           SpeedCard new.
				           CancellationCard new }.
	cardManager := zathura cardManager.
	cardManager throws: SpeedCard new to: 'RedShip' from: 'BlueShip'.
	self
		should: [ 
			cardManager
				throw: CancellationCard new
				to: 'RedShip'
				removing: OverloadCard new
				from: 'BlueShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipCantThrowOverloadCardIfNotInHand [

	| zathura aDie blueShip cardManager |
	aDie := LoadedDie with: 1.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { AccelerationCard new }.
	cardManager := zathura cardManager.
	self
		should: [ 
		cardManager throws: OverloadCard new   to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Card is not in Hand'
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAAtomicBombAndAllShipsGoToFirstLockerOfTheSameLap [

	| die ships zathura boardDefinition |
	die := LoadedDie with: 8.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	boardDefinition := self boardDefinitionWithOnly: AtomicBombEffect new
		                  at: 7
		                  of: 10
		                  andParsec: 50
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 0
		with: 1
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 0
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 0
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAMoonWalkLockerAndTheResultIsItMovesAllOtherShipsBackwardsTwoLockers [

	| die ships zathura boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	boardStructure := self boardDefinitionWithOnly: (MoonWalkEffect with: 2)
		                  at: 7
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 6
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 1
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 1
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoASpeedUpLockerAndTheResultIsItAdvancesFourLockersMore [

	| die ships zathura boardStructure |
	die := LoadedDie with: 3.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	boardStructure := self boardDefinitionWithOnly: SpeedUpEffect new
		                  at: 4
		                  of: 8
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 7
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testBlueShipFallsIntoAWormHoleLockerAndTheResultIsItAdvancesFourLockersBackwards [

	| die ships zathura boardStructure |
	die := LoadedDie with: 5.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	boardStructure := self boardDefinitionWithOnly: WormHoleEffect new
		                  at: 6
		                  of: 9
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 1
		with: 0
		in: zathura
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsASpeedCardToRedShipAndRedShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 20
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { SpeedCard new }.
	cardManager := zathura cardManager.
	cardManager throws: SpeedCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 7;
		assert: lockersOfRedShip equals: 8.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 14;
		assert: lockersOfRedShip equals: 16
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAfterTwoRoundsThrowsACancellationCard [

	| diceCup zathura lockersOfBlueShip lockersOfRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           AccelerationCard new.
				           CancellationCard new }.
	cardManager := zathura cardManager.
	cardManager throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 8;
		assert: lockersOfRedShip equals: 8.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 16;
		assert: lockersOfRedShip equals: 16.
	cardManager
		throw: CancellationCard new
		removing: AccelerationCard new
		from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 23;
		assert: lockersOfRedShip equals: 23;
		assert: (zathura cardsOnTableOf: AccelerationCard new) equals: 0
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAfterTwoRoundsThrowsARedoCard [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           AccelerationCard new.
				           RedoCard new }.
	cardManager := zathura cardManager.
	cardManager throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 8;
		assert: lockersOfRedShip equals: 8.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 16;
		assert: lockersOfRedShip equals: 16.
	cardManager throws: RedoCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 25;
		assert: lockersOfRedShip equals: 25
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnAccelerationCardAndAllShipMovesRolledNumberPlusOneAllGame [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 20
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { AccelerationCard new }.
	cardManager := zathura cardManager.
	cardManager throws: AccelerationCard new toAllShipsFrom: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 8;
		assert: lockersOfRedShip equals: 8.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 16;
		assert: lockersOfRedShip equals: 16
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndAfterTwoRoundsThrowsARedoCardToGreenShip [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip lockersOfGreenShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 30
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           RedoCard new }.
	cardManager := zathura cardManager.
	zathura
		playTurn;
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	lockersOfGreenShip := zathura numberOfLockerOf: 'GreenShip'.
	self
		assert: lockersOfBlueShip equals: 7;
		assert: lockersOfRedShip equals: 7;
		assert: lockersOfGreenShip equals: 7.

	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	lockersOfGreenShip := zathura numberOfLockerOf: 'GreenShip'.
	self
		assert: lockersOfBlueShip equals: 14;
		assert: lockersOfRedShip equals: 12;
		assert: lockersOfGreenShip equals: 14.
	cardManager throws: RedoCard new to: 'GreenShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	lockersOfGreenShip := zathura numberOfLockerOf: 'GreenShip'.
	self
		assert: lockersOfBlueShip equals: 21;
		assert: lockersOfRedShip equals: 17;
		assert: lockersOfGreenShip equals: 19
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndLosesOneOverloadCard [

	| zathura aDie cardManager |
	aDie := LoadedDie with: 4.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { OverloadCard new }.
	cardManager := zathura cardManager.
	zathura playTurn.
	zathura playTurn.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura playTurn.
	zathura playTurn.
	self assert: (cardManager cardsOf: 'BlueShip') size equals: 1
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesBackwards [

	| positionOfBlueShip positionOfRedShip zathura aDie cardManager |
	aDie := SequencialLoadedDie with: { 4. 4. 1. 1 }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 10
			            andParsec: 100
			            played: 1)
		           rolling: aDie
		           withCards: { OverloadCard new }.
	cardManager := zathura cardManager.
	zathura playTurn.
	zathura playTurn.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura playTurn.
	zathura playTurn.
	positionOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	positionOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self assert: positionOfBlueShip equals: 5.
	self assert: positionOfRedShip equals: 3
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipAndRedShipMovesRolledNumberMinusTwoAllGame [

	| diceCup zathura lockersOfBlueShip lockersOfRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { OverloadCard new }.
	cardManager := zathura cardManager.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 7;
		assert: lockersOfRedShip equals: 5.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 14;
		assert: lockersOfRedShip equals: 10
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsAnOverloadCardToRedShipThenRedShipsThrowsACancellationCardWhichCancelsTheOverLoadCard [

	| diceCup zathura lockersOfBlueShip lockersOfRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           CancellationCard new }.
	cardManager := zathura cardManager.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 7;
		assert: lockersOfRedShip equals: 5.
	cardManager
		throw: CancellationCard new
		to: 'RedShip'
		removing: OverloadCard new
		from: 'RedShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 14;
		assert: lockersOfRedShip equals: 12
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnAccelerationCardAndItIsNotItsTurn [

	| die ships boardStructure zathura blueShip cardManager |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { AccelerationCard new }.

	cardManager := zathura cardManager.
	zathura playTurn.

	self
		should: [ 
		cardManager throws: AccelerationCard new toAllShipsFrom: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnOverloadCardAndItIsNotItsTurn [

	| die ships boardStructure zathura blueShip cardManager |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	cardManager := zathura cardManager.

	self
		should: [ 
		cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testBlueShipThrowsErrorWhenUsesAnSpeedCardAndItIsNotItsTurn [

	| die ships boardStructure zathura blueShip cardManager |
	die := LoadedDie with: 7.
	ships := #( 'BlueShip' 'RedShip' ).
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { SpeedCard new }.
	zathura playTurn.
	cardManager := zathura cardManager.

	self
		should: [ cardManager  throws: SpeedCard new to: 'RedShip' from: 'BlueShip' ]
		raise: Error
		withMessage: 'Permanent cards can only be used when its your turn'
]

{ #category : #boardTests }
ZathuraTest >> testBoardCanBeInitializedWithLightyears [

	| board |
	board := self
		         boardDefinitionWithNoEffectsOf: 20
		         and: (LightYear with: 60)
		         played: 3.

	self assert: board parsecsPerLocker equals: 1
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanTwoLockers [

	self
		should: [ 
		BoardDefinition with: { LockerNoEffect new } and: 20 played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than two lockers'
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanZeroLaps [

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: (Parsec with: 10)
				played: 0 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero laps'.

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: (Parsec with: 10)
				played: -3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero laps'
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testBoardStructureCannotHaveLessThanZeroParsecs [

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: (Parsec with: 0)
				played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero parsecs'.

	self
		should: [ 
			BoardDefinition
				with: { 
						LockerNoEffect new.
						LockerNoEffect new }
				and: (Parsec with: -5)
				played: 3 ]
		raise: Error
		withMessage: 'Board Structure cannot have less than zero parsecs'
]

{ #category : #tests }
ZathuraTest >> testGreenShipWinsAndFinishesInPositionZeroWithOneLapCompleted [

	| zathura die ships boardStructure |
	die := LoadedDie with: 7.
	ships := OrderedCollection
		         with: 'GreenShip'
		         with: 'RedShip'
		         with: 'BlueShip'.

	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.

	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'GreenShip'
		isAt: 7
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 7
		with: 0
		in: zathura.
	self
		assert: 'BlueShip'
		isAt: 7
		with: 0
		in: zathura.
	zathura playTurn.
	self
		assert: 'GreenShip'
		isAt: 0
		with: 1
		in: zathura.
	self assert: zathura winner  equals: 'GreenShip'
]

{ #category : #boardTests }
ZathuraTest >> testHyperJumpUnderstandBothLightYearsAndParsecsInTheSameSequence [

	| sequence die ships boardDefinition zathura |
	die := LoadedDie with: 1.

	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	sequence := { 
		            (Parsec with: 6).
		            (LightYear with: 3) }.

	boardDefinition := self
		                   boardDefinitionWithOnly:
		                   (HyperJumpEffect with: sequence)
		                   at: 2
		                   of: 10
		                   andParsec: 10
		                   played: 3.

	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardDefinition
		           rolling: die.

	zathura playTurn.
	self assert: (zathura numberOfLockerOf: 'BlueShip') equals: 7.

	zathura playTurn.
	self assert: (zathura numberOfLockerOf: 'RedShip') equals: 2
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testHyperjumpCannotHaveANullParsecSequence [

	self
		should: [ HyperJumpEffect with: {  } ]
		raise: Error
		withMessage: 'Hyperjump cannot have a null parsec sequence'
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testHyperjumpCannotHaveLessThanZeroParsecsInTheSequence [

	self
		should: [ HyperJumpEffect with: { (Parsec with: 5). (Parsec with: -2). (Parsec with: 10) } ]
		raise: Error
		withMessage:
		'Hyperjump cannot have less than zero parsecs in the sequence'
]

{ #category : #boardDefinitionAssertionTests }
ZathuraTest >> testMoonwalkCannotHaveLessThanZeroLockers [

	self
		should: [ MoonWalkEffect with: 0 ]
		raise: Error
		withMessage:
		'MoonWalk cannot be created with less than zero lockers'.

	self
		should: [ MoonWalkEffect with: -3 ]
		raise: Error
		withMessage:
		'MoonWalk cannot be created with less than zero lockers'
]

{ #category : #boardTests }
ZathuraTest >> testRedShipsFallsIntoaCardGetterLockerAndGetsARandomCard [

	| redShipCardHand die ships boardStructure zathura cardManager |
	die := LoadedDie with: 1.
	ships := #( 'RedShip' 'BlueShip' ).
	boardStructure := self
		                  boardDefinitionWithOnly: CardEffect
		                  at: 2
		                  of: 10
		                  andParsec: 100
		                  played: 1.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die
		           withCards: { OverloadCard new }.
	zathura playTurn.
	cardManager := zathura cardManager.
	redShipCardHand := cardManager cardsOf: 'RedShip'.
	self assert: redShipCardHand size equals: 3
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testShipCantThrowCancellationCardToCancelACardToTheWrongShip [

	| diceCup zathura zBlueShip lockersOfBlueShip lockersOfRedShip zRedShip cardManager |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 3).
			           (LoadedDie with: 4) }.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip'. 'GreenShip' }
		           movedInBoardOf:
		           (self
			            boardDefinitionWithNoEffectsOf: 15
			            andParsec: 100
			            played: 1)
		           rolling: diceCup
		           withCards: { 
				           OverloadCard new.
				           CancellationCard new }.
	cardManager := zathura cardManager.
	cardManager throws: OverloadCard new to: 'RedShip' from: 'BlueShip'.
	zathura
		playTurn;
		playTurn.
	lockersOfBlueShip := zathura numberOfLockerOf: 'BlueShip'.
	lockersOfRedShip := zathura numberOfLockerOf: 'RedShip'.
	self
		assert: lockersOfBlueShip equals: 7;
		assert: lockersOfRedShip equals: 5.

	self
		should: [ 
			cardManager throw: CancellationCard new to: 'BlueShip' removing: OverloadCard new from: 'RedShip' ]
		raise: Error
		withMessage: 'This card is not active in the table'
]

{ #category : #boardTests }
ZathuraTest >> testShipLandsOnAWormholeEffectAndGoesBackOneLap [

	| zathura sequencialDie ships boardStructure |
	sequencialDie := SequencialLoadedDie with: { 11. 11. 1 }.
	boardStructure := self boardDefinitionWithOnly: WormHoleEffect new
		                  at: 3
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: sequencialDie.

	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 8
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 1
		with: 1
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testShipsFallIntoAHyperJumpLockerAndMovesByTheLightYearsInASequence [

	| die ships zathura  boardStructure lightYears sequence |
	die := LoadedDie with: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	sequence := { LightYear with: 75. LightYear with: 93. LightYear with: 33 }.
	boardStructure := self
		                  boardDefinitionWithOnly:
		                  (HyperJumpEffect with: sequence)
		                  at: 2
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 4
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 3
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testShipsFallIntoAHyperJumpLockerAndMovesByTheParsecsInASequence [

	| die ships zathura boardStructure sequence |
	die := LoadedDie with: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.

	sequence := { 
		            (Parsec with: 25).
		            (Parsec with: 31).
		            (Parsec with: 11) }.
	boardStructure := self
		                  boardDefinitionWithOnly:
		                  (HyperJumpEffect with: sequence)
		                  at: 2
		                  of: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'BlueShip'
		isAt: 4
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 3
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 2
		with: 0
		in: zathura
]

{ #category : #tests }
ZathuraTest >> testThePositionOfEachShipCanBeKnownWhenTheGameIsFinished [

	| zathura diceCup ships boardStructure |
	diceCup := DiceCup withAll: { 
			           (LoadedDie with: 6).
			           (LoadedDie with: 2) }.
	boardStructure := self boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 1.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup.

	zathura play.
	self
		assert: 'BlueShip'
		isAt: 0
		with: 1
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 8
		with: 0
		in: zathura.
	self
		assert: 'GreenShip'
		isAt: 8
		with: 0
		in: zathura
]

{ #category : #tests }
ZathuraTest >> testWhenShipGoesBackwardsInTheFirstLapItStayesAtTheLapZero [

	| zathura diceCup ships boardStructure |
	diceCup := LoadedDie with: 1.
	boardStructure := self boardDefinitionWithOnly: WormHoleEffect new
		                  at: 2
		                  of: 10
		                  andParsec: 50
		                  played: 3.
	ships := OrderedCollection
		         with: 'BlueShip'
		         with: 'RedShip'
		         with: 'GreenShip'.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: diceCup.

	zathura playTurn.
	zathura playTurn.

	self assert: (zathura numberOfLockerOf: 'BlueShip') equals: 0.
	self assert: (zathura numberOfLapOf: 'BlueShip') equals: 0
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testZathuraBlueShipThrowsARepeatCardToRedShipWhenNobodyHasPlayedATurnWhichHasNoEffect [

	| zathura aDie blueShip cardManager |
	aDie := LoadedDie with: 2.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf: (self
				            boardDefinitionWithOnly: SpeedUpEffect new
				            at: 3
				            of: 12
				            andParsec: 100
				            played: 1)
		           rolling: aDie
		           withCards: { RepeatCard new }.
	cardManager := zathura cardManager.

	self should: [cardManager throws: RepeatCard new to: 'RedShip' from: 'BlueShip'  ] raise:Error  withMessage: 'Ship can not throw repeat card if no effects have been aplied'
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraCannotBePlayedMoreThanOnce [

	| ships aDie zathura  boardStructure |
	aDie := LoadedDie with: 8.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 5
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: aDie.
	zathura play.

	self
		should: [ zathura play ]
		raise: Error
		withMessage: 'Zathura cannot be played more than once'
]

{ #category : #tests }
ZathuraTest >> testZathuraGamePlaysATurnAndDoNotFinish [

	| ships aDie zathura boardStructure |
	aDie := RandomDie with: 3.
	ships := OrderedCollection
		         with: 'GreenShip'
		         with: 'RedShip'
		         with: 'BlueShip'.
	boardStructure := self boardDefinitionWithNoEffectsOf: 5
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: aDie.
	zathura playTurn.
	self deny: zathura hasFinished
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraInitializedWithLessThanTwoShipsThrowsError [

	| die ships |
	die := LoadedDie with: 6.
	ships := OrderedCollection new.
	ships addLast: 'BlueShip'.

	self
		should: [ ZathuraGame playBy: ships movedInBoardOf: 10 rolling: die ]
		raise: Error
		withMessage: 'Zathura cannot be played with less than two ships'
]

{ #category : #tests }
ZathuraTest >> testZathuraIsInitializedWithAllShipsInPositionZeroAndLapZero [

	| die ships zathura boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self boardDefinitionWithNoEffectsOf: 5
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	self
		assert: 'BlueShip'
		isAt: 0
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 0
		with: 0
		in: zathura
]

{ #category : #tests }
ZathuraTest >> testZathuraKnowsTheRankingOfAShip [

	| die ships zathura faces boardStructure |
	faces := OrderedCollection with: 5 with: 8 with: 9.
	die := SequencialLoadedDie with: faces.
	ships := OrderedCollection
		         with: 'RedShip'
		         with: 'GreenShip'
		         with: 'BlueShip'.

	boardStructure := self boardDefinitionWithNoEffectsOf: 7
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	zathura playTurn.
	zathura playTurn.

	self assert: (zathura rankingOf: 'BlueShip') equals: 3.
	self assert: (zathura rankingOf: 'GreenShip') equals: 1.
	self assert: (zathura rankingOf: 'RedShip') equals: 2.

	zathura playTurn.
	self assert: (zathura rankingOf: 'GreenShip') equals: 2.
	self assert: (zathura rankingOf: 'BlueShip') equals: 1.
	self assert: (zathura rankingOf: 'RedShip') equals: 3
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testZathuraRedShipThrowsRepeatCardToBlueShip [

	| positionOfBlueShip zathura aDie redShip cardManager |
	aDie := LoadedDie with: 2.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf: (self
				            boardDefinitionWithOnly: SpeedUpEffect new
				            at: 3
				            of: 12
				            andParsec: 100
				            played: 1)
		           rolling: aDie
		           withCards: { RepeatCard new }.
		
	zathura playTurn.
	zathura playTurn.
	
	self assert: 'BlueShip' isAt: 6 with: 0 in: zathura.
	self assert: 'RedShip' isAt: 6 with: 0 in: zathura.
	
	cardManager := zathura cardManager.
	cardManager throwsInstant: RepeatCard new to: 'RedShip' from: 'RedShip'.
	
	self assert: 'RedShip' isAt: 10 with: 0 in: zathura.
	self assert: 'BlueShip' isAt: 6 with: 0 in: zathura.
]

{ #category : #shipWithHandOfCardsTests }
ZathuraTest >> testZathuraRedShipThrowsRepeatCardToHimselfWhenTheLastLockerWasANoEffectLockerAndNothingHappens [

	| positionOfBlueShip zathura aDie redShip cardManager |
	aDie := LoadedDie with: 2.
	zathura := ZathuraGame
		           playBy: { 'BlueShip'. 'RedShip' }
		           movedInBoardOf: (self
				            boardDefinitionWithNoEffectsOf: 12
				            andParsec: 100
				            played: 1)
		           rolling: aDie
		           withCards: { RepeatCard new }.

	zathura playTurn.
	zathura playTurn.

	self
		assert: 'BlueShip'
		isAt: 2
		with: 0
		in: zathura.
	self
		assert: 'RedShip'
		isAt: 2
		with: 0
		in: zathura.

	cardManager := zathura cardManager.
	cardManager
		throwsInstant: RepeatCard new
		to: 'RedShip'
		from: 'RedShip'.

	self
		assert: 'RedShip'
		isAt: 2
		with: 0
		in: zathura.
]

{ #category : #boardTests }
ZathuraTest >> testZathuraShipFallsIntoASpeedUpMovesFourLockersAndStaysThere [

	| die ships zathura lockers boardStructure |
	die := LoadedDie with: 1.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	lockers := { 
		           LockerNoEffect new.
		           SpeedUpEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           WormHoleEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new.
		           LockerNoEffect new }.
	boardStructure := BoardDefinition with: lockers and: (Parsec with: 100) played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self assert: 'BlueShip' isAt: 6 with: 0 in: zathura
]

{ #category : #boardTests }
ZathuraTest >> testZathuraWhenCrossingTheLastLockerTheShipsStartsAnotherLap [

	| die ships zathura boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'BlueShip' with: 'RedShip'.

	boardStructure := self boardDefinitionWithNoEffectsOf: 10
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.
	zathura playTurn.
	zathura playTurn.
	zathura playTurn.
	self
		assert: 'RedShip'
		isAt: 6
		with: 0
		in: zathura.
	self
		assert: 'BlueShip'
		isAt: 2
		with: 1
		in: zathura
]

{ #category : #zathuraAssertionTests }
ZathuraTest >> testZathuraWhileItHasNotFinishedAsksWinnerThrowsError [

	| die ships zathura  boardStructure |
	die := LoadedDie with: 6.
	ships := OrderedCollection with: 'GreenShip' with: 'BlueShip'.
	boardStructure := self
		                  boardDefinitionWithNoEffectsOf: 3
		                  andParsec: 100
		                  played: 3.
	zathura := ZathuraGame
		           playBy: ships
		           movedInBoardOf: boardStructure
		           rolling: die.

	self
		should: [ zathura winner ]
		raise: Error
		withMessage: 'Zathura has not finished yet'
]
