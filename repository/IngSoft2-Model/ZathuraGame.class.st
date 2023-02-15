"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
!
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	board:		<Object>
	diceCup:		<Object>
	finished:		<Object>
	ships:		<Object>
	winner:		<Object>


    Implementation Points
"
Class {
	#name : #ZathuraGame,
	#superclass : #Object,
	#instVars : [
		'finished',
		'diceCup',
		'board',
		'timesPlayed',
		'ships',
		'cardManager',
		'cardHands',
		'cardThrower'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ZathuraGame class >> assertNumberOfShipsIsValid: aCollectionOfShips [

	aCollectionOfShips size >= 2 ifFalse: [ Error signal: 'Zathura cannot be played with less than two ships' ]
]

{ #category : #'instance creation' }
ZathuraGame class >> playBy: ships movedInBoardOf: boardStructure rolling: die withCards: cards [

	self assertNumberOfShipsIsValid: ships.
	^ self new
		  initializePlayingBy: ships
		  movedInBoardOf: boardStructure
		  rolling: die
		  withCards: cards
]

{ #category : #actions }
ZathuraGame >> addCardToTable: aCard [ 
	cardManager addCardToTable: aCard.
]

{ #category : #resendingToBoard }
ZathuraGame >> applyLastEffectOn: aShip [ 
	board applyLastEffectOn: (aShip).
]

{ #category : #actions }
ZathuraGame >> applyLastEffectOn: aShip with: aRepeatCard [

	board applyLastEffectOn: aShip.
	cardManager addToTheCardsStack: aRepeatCard
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasFinished [

	finished ifFalse: [ Error signal: 'Zathura has not finished yet' ]
]

{ #category : #asserting }
ZathuraGame >> assertZathuraHasNotBeenPlayed [

	(timesPlayed == 1) ifTrue: [ 
		Error signal: 'Zathura cannot be played more than once' ]
]

{ #category : #accessing }
ZathuraGame >> cardApplicator [

	^ cardApplicator
]

{ #category : #accessing }
ZathuraGame >> checkIfWon: aShip [

	(board hasCrossFinishLine: aShip) ifFalse: [ ^ self ].
	timesPlayed := 1.
	finished := true
]

{ #category : #actions }
ZathuraGame >> giveCardTo: aShip [ 
	cardHands giveCard: (cardManager giveCard ) to: aShip.
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initalization }
ZathuraGame >> initializePlayingBy: aCollectionOfShips movedInBoardOf: boardStructure rolling: aDiceCup withCards: aCollectionOfCards [

	diceCup := aDiceCup.
	cardManager := CardsInZathura
		               with: aCollectionOfShips
		               and: aCollectionOfCards
		               from: self.
	ships := aCollectionOfShips asOrderedCollection asSequence.

	board := Board
		         of: boardStructure
		         withAll: ships
		         andCardManager: cardManager.
cardHands := CardHandsInGame with: aCollectionOfShips.
cardThrower := CardThrower createNewWith: cardHands  in: self.
aCollectionOfShips do: [ :ship | 
		self  giveCardTo: ship.
		self  giveCardTo: ship ].
	finished := false.
	timesPlayed := 0
]

{ #category : #accessing }
ZathuraGame >> isTurnOf: aShip [

	^ ((ships first) == aShip)
]

{ #category : #accessing }
ZathuraGame >> lastCardThrownOnTheGame [
	^cardManager lastCardThrownOnTheGame .
]

{ #category : #positioning }
ZathuraGame >> numberOfLapOf: aShip [

	^ (board positionOf: aShip) numberOfLap 
]

{ #category : #positioning }
ZathuraGame >> numberOfLockerOf: aShip [

	^ board numberOfLockerOf: aShip
]

{ #category : #playing }
ZathuraGame >> play [
	self assertZathuraHasNotBeenPlayed.
	[ finished ] whileFalse: [ self playTurn ]
]

{ #category : #playing }
ZathuraGame >> playTurn [

	| aShip |
	self assertZathuraHasNotBeenPlayed.
	aShip := ships next.
	board
		changePositionOf: aShip
		by: diceCup roll + (cardManager findChangeOfRoll: aShip).
	self checkIfWon: aShip
]

{ #category : #positioning }
ZathuraGame >> rankingOf: aShip [

	^ board rankingOf: aShip.
]

{ #category : #actions }
ZathuraGame >> removeFromCardsOnTable: aCard with: aCancellationCard [ 
	cardManager removeFromCardsOnTable: aCard with: aCancellationCard 
]

{ #category : #'accessing - attributes' }
ZathuraGame >> ships [
	| nameShips |
	nameShips := OrderedCollection new.
	ships do: [ :aShip | nameShips add: aShip ].
	^nameShips.
]

{ #category : #'card - actions' }
ZathuraGame >> throws: aCancellationCard removing: aCard from: aShip [

	cardThrower   throws: aCancellationCard removing: aCard from: aShip
]

{ #category : #'card - actions' }
ZathuraGame >> throws: aCard to: aTargetShip from: aShip [

	cardThrower   throws: aCard to: aTargetShip from: aShip
]

{ #category : #'card - actions' }
ZathuraGame >> throws: aCancellationCard to: aTargetShip removing: aCard from: aShip [

	cardThrower  
		throw: aCancellationCard
		to: aTargetShip
		removing: aCard
		from: aShip
]

{ #category : #'card - actions' }
ZathuraGame >> throws: aCard toAllShipsFrom: aShip [

	cardThrower  throw: aCard toAllShipsFrom: aShip
]

{ #category : #accessing }
ZathuraGame >> winner [

	self assertZathuraHasFinished.
	^ (ships detect: [ :ship | (self rankingOf: ship) == 1 ]).
]
