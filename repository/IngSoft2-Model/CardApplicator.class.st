Class {
	#name : #CardApplicator,
	#superclass : #Object,
	#instVars : [
		'deck',
		'cardHands',
		'cardsOnTable',
		'thrownCardsStack',
		'turnEffectApplicator',
		'board'
	],
	#classInstVars : [
		'cardHands',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardApplicator class >> with: aCollectionOfShips and: aCollectionOfCards [

	^ self new
		  initializeWith: aCollectionOfShips
		  and: aCollectionOfCards
]

{ #category : #adding }
CardApplicator >> addCardToTable: aCard [

	cardsOnTable add: aCard
]

{ #category : #adding }
CardApplicator >> addTheNextCardToHandCardOf: aShip [

	| cardHand |
	cardHand := self cardHandOf: aShip.
	cardHand add: (self giveCard )
]

{ #category : #resendingToBoard }
CardApplicator >> applyLastEffectOn: aShip [

	board applyLastEffectOn: aShip
]

{ #category : #permanentCard }
CardApplicator >> applyPermanentCardEffectOf: aCard thrownBy: sourceShip [

	self assertIsYourTurn: sourceShip.
	self addCardToTable: (ActiveCard with: aCard appliedTo: self ships)
]

{ #category : #permanentCard }
CardApplicator >> applyPermanentCardEffectOf: aCard to: aShip thrownBy: sourceShip [

	self assertIsYourTurn: sourceShip.
	self addCardToTable:
		(ActiveCard with: aCard appliedTo: {aShip})
]

{ #category : #asserting }
CardApplicator >> assertCardHasBeenThrown [

	thrownCardsStack ifEmpty: [ 
		Error signal:
			'Redo card must be thrown before another card has been played' ]
]

{ #category : #asserting }
CardApplicator >> assertIsYourTurn: aShip [

	(self isTurnOf: aShip) ifFalse: [ 
		Error signal: 'Permanent cards can only be used when its your turn' ]
]

{ #category : #private }
CardApplicator >> cardHandOf: aShip [

	^ cardHands detect: [ :aCardHand | aCardHand ship = aShip ]
]

{ #category : #private }
CardApplicator >> cardsAffecting: aShip [

	^ cardsOnTable select: [ :aCard | aCard ship includes: aShip ]
]

{ #category : #resendingToTurnApplicator }
CardApplicator >> doubleTurn [

	turnEffectApplicator doubleTurn
]

{ #category : #accessing }
CardApplicator >> findCardOnTable: aCard [

	^ cardsOnTable detect: [ :card | card = aCard ] ifNone:[ Error signal: 'This card is not active in the table' ].
]

{ #category : #playing }
CardApplicator >> findChangeOfRoll: aShip [

	^ (self cardsAffecting: aShip) sum: [ :aCard | aCard changeOfRoll ]
]

{ #category : #private }
CardApplicator >> giveCard [

	^ deck next
]

{ #category : #initialization }
CardApplicator >> initializeCardHandsBy: aCollectionOfShips [

	^ aCollectionOfShips collect: [ :aShip | 
		  CardHand of: aShip with: { 
				  self giveCard.
				  self giveCard } ]
]

{ #category : #initialization }
CardApplicator >> initializeWith: aTurnEffectApplicator and: aCollectionOfCards [

	deck := aCollectionOfCards asOrderedCollection asSequence.
	cardHands := self initializeCardHandsBy: aTurnEffectApplicator ships.
	cardsOnTable := OrderedCollection new.
	thrownCardsStack := OrderedCollection new.
	turnEffectApplicator := aTurnEffectApplicator
]

{ #category : #resendingToTurnApplicator }
CardApplicator >> isTurnOf: aShip [

	^ (turnEffectApplicator isTurnOf: aShip)
]

{ #category : #accessing }
CardApplicator >> lastCardThrownOnTheGame [

	self assertCardHasBeenThrown.
	^ thrownCardsStack last
]

{ #category : #initialization }
CardApplicator >> load: aBoard [

	board := aBoard
]

{ #category : #resendingToTurnApplicator }
CardApplicator >> loseTheTurn [
	
	turnEffectApplicator skipTurnOfActualShip
]

{ #category : #resendingToBoard }
CardApplicator >> releaseFromJail: aShip [

	board releaseFromJail: aShip
]

{ #category : #removing }
CardApplicator >> removeFromCardsOnTable: aCard [

	| theCard |
	theCard := self findCardOnTable: aCard.
	cardsOnTable remove: theCard.
]

{ #category : #resendingToTurnApplicator }
CardApplicator >> reverseTheOrderOfTurns [
	
	turnEffectApplicator reverseTheOrderOfTurns
]

{ #category : #accessing }
CardApplicator >> ships [

	^ cardHands collect: [ :cardHand | cardHand ship ]
]

{ #category : #throwing }
CardApplicator >> throws: aCard [

	| cardHand sourceShip |
	sourceShip := aCard sourceShip.
	cardHand := self cardHandOf: sourceShip.
	cardHand assertCardIsInHand: aCard.
	
	aCard effectOn: self.
	
	cardHand remove: aCard.
	thrownCardsStack add: aCard
]
