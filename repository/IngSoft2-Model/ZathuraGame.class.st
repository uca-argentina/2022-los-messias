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
		'cardGenerator',
		'aDeck',
		'cardsOnTable',
		'ships',
		'shipsHand'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ZathuraGame class >> assertNumberOfShipsIsValid: aCollectionOfShips [

	aCollectionOfShips size >= 2 ifFalse: [ Error signal: 'Zathura cannot be played with less than two ships' ]
]

{ #category : #'instance creation' }
ZathuraGame class >> playBy: ships movedInBoardOf: boardStructure rolling: die [

	self assertNumberOfShipsIsValid: ships.
	^ self new
		  initializePlayingBy: ships
		  movedInBoardOf: boardStructure
		  rolling: die
		  withCards: { OverloadCard new }.
]

{ #category : #'class initialization' }
ZathuraGame class >> playBy: ships movedInBoardOf: boardStructure rolling: die withCards: aCollectionOfCards [

	self assertNumberOfShipsIsValid: ships.
	^ self new
		  initializePlayingBy: ships
		  movedInBoardOf: boardStructure
		  rolling: die withCards: aCollectionOfCards
]

{ #category : #adding }
ZathuraGame >> addCardToBoard: aCard [

	cardsOnTable add: aCard
]

{ #category : #adding }
ZathuraGame >> addIntoGame: aCollectionOfShips [

	shipsHand := Sequence new.
	ships:= (aCollectionOfShips asOrderedCollection) asSequence   .
	aCollectionOfShips do: [ :ship | 
		shipsHand add: (CardHand of: ship with: { 
					 aDeck next.
					 aDeck next }) ]
]

{ #category : #actions }
ZathuraGame >> applyLastEffectOn: aShip [ 
	board lastEffectOn: (self zathuraShip: aShip).
]

{ #category : #asserting }
ZathuraGame >> assertCardsOnTable: card [

	(cardsOnTable anySatisfy: [ :aCard | aCard card hasEqualClass: card ]) 
		ifFalse: [ Error signal: 'This card is not active in the table' ]
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
ZathuraGame >> cardsOf: spaceship [

	^ (self zathuraShip: spaceship) cardsOf
]

{ #category : #'accessing - attributes' }
ZathuraGame >> cardsOnTableOf: aCard [ 
	| cards |
	cards:= cardsOnTable select: [:card | card isMemberOf: (aCard class)].
	^(cards size)
]

{ #category : #private }
ZathuraGame >> checkIfWon: aShip [

	(board hasCrossFinishLine: aShip ) ifFalse: [ ^ self ].
	timesPlayed := 1.
	finished := true
]

{ #category : #accesing }
ZathuraGame >> getCardHandOf: aShip [ 
	^(shipsHand select: [ :aCardHand | aCardHand ship = aShip ]) first
	
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initalization }
ZathuraGame >> initializePlayingBy: aCollectionOfShips movedInBoardOf: boardStructure rolling: aDiceCup withCards: aCollectionOfCards [

	diceCup := aDiceCup.
	aDeck := Sequence withAll: aCollectionOfCards.
	self addIntoGame: aCollectionOfShips.
	board := Board
		         of: boardStructure
		         withAll: ships
		         withCards: aCollectionOfCards.
	cardsOnTable := OrderedCollection new.
	finished := false.
	timesPlayed := 0
]

{ #category : #testing }
ZathuraGame >> isTurnOf: aShip [

	^ ships first ship == aShip
]

{ #category : #accessing }
ZathuraGame >> lastCardThrewOnTable [

	^ cardsOnTable first
]

{ #category : #positioning }
ZathuraGame >> numberOfLapOf: aShip [

	^ (board positionOf: (self zathuraShip: aShip)) numberOfLap 
]

{ #category : #positioning }
ZathuraGame >> numberOfLockerOf: aShip [

	^ board numberOfLockerOf: (self zathuraShip: aShip)
]

{ #category : #playing }
ZathuraGame >> play [

	self assertZathuraHasNotBeenPlayed.

	[ finished ] whileFalse: [ self playTurn ]
]

{ #category : #playing }
ZathuraGame >> playTurn [

	| aShip cardsThatApplyEffectOnShip changeOfRoll |
	self assertZathuraHasNotBeenPlayed.
	aShip := ships next.
	cardsThatApplyEffectOnShip := cardsOnTable select: [ :aCard | 
		                              aCard ship includes: aShip ].
	changeOfRoll := cardsThatApplyEffectOnShip sum: [ :aCard | 
		                aCard changeOfRoll ].
	board changePositionOf: aShip by: diceCup roll + changeOfRoll.
	self checkIfWon: aShip
]

{ #category : #positioning }
ZathuraGame >> rankingOf: aShip [

	^ board rankingOf: (self zathuraShip: aShip).
]

{ #category : #set }
ZathuraGame >> removeFromCardsOnTable: aCard [

	| theCard |
	theCard := 0.
	self assertCardsOnTable: aCard.
	cardsOnTable do: [ :card | 
	(aCard = card card) ifTrue: [ theCard := card ] ].
	cardsOnTable remove: theCard
]

{ #category : #accessing }
ZathuraGame >> ships [

	^ ships
]

{ #category : #ending }
ZathuraGame >> winner [

	| winner |
	self assertZathuraHasFinished.
	winner := ships select: [ :ship | 
		          (self rankingOf: (ship ship)) == 1].
	^ winner at: 1
]

{ #category : #accesing }
ZathuraGame >> zathuraShip: aShip [

	| zathuraShip |
	zathuraShip := ships select: [ :zShip | 
		               (zShip) = aShip ].
	^ zathuraShip first
]
