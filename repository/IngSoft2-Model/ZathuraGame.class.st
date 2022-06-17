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
		'shipsHand',
		'cardManager',
		'thrownCardsStack'
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
ZathuraGame >> addCardToTable: aCard [

	cardsOnTable add: aCard.
]

{ #category : #adding }
ZathuraGame >> addIntoGame: aCollectionOfShips [

	ships := aCollectionOfShips asOrderedCollection asSequence
]

{ #category : #actions }
ZathuraGame >> applyLastEffectOn: aShip [ 
	board lastEffectOn: (aShip).
]

{ #category : #asserting }
ZathuraGame >> assertIsOnTable: aCard [
		aCard ifEmpty: [ Error signal: 'This card is not active in the table' ].
]

{ #category : #'as yet unclassified' }
ZathuraGame >> assertThrownCardStackIsNotEmpty [

	thrownCardsStack ifEmpty: [ 
		Error signal:
			'Redo card must be thrown before another card has been played' ]
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

{ #category : #attributes }
ZathuraGame >> cardManager [
	^ cardManager
]

{ #category : #'accessing - attributes' }
ZathuraGame >> cardsOnTableOf: aCard [

	| cards |
	cards := cardsOnTable select: [ :card | card hasEqualClass: aCard ].
	^ cards size
]

{ #category : #private }
ZathuraGame >> checkIfWon: aShip [

	(board hasCrossFinishLine: aShip ) ifFalse: [ ^ self ].
	timesPlayed := 1.
	finished := true
]

{ #category : #asserting }
ZathuraGame >> findCardOnTable: aCard [

	| theCard |
	theCard := cardsOnTable select: [ :card | card = aCard ].
	self assertIsOnTable: theCard.
	^ theCard first
]

{ #category : #actions }
ZathuraGame >> giveCard [

	^ aDeck next
]

{ #category : #state }
ZathuraGame >> hasFinished [

	^ finished
]

{ #category : #initalization }
ZathuraGame >> initializePlayingBy: aCollectionOfShips movedInBoardOf: boardStructure rolling: aDiceCup withCards: aCollectionOfCards [

	diceCup := aDiceCup.
	aDeck := Sequence withAll: aCollectionOfCards.
	ships := aCollectionOfShips asOrderedCollection asSequence.
	cardManager := CardApplicator intializeIn: self.
	board := Board
		         of: boardStructure
		         withAll: ships
		         withCards: aCollectionOfCards
		         andCardManager: cardManager.
	cardsOnTable := OrderedCollection new.
	finished := false.
	timesPlayed := 0.
	thrownCardsStack := OrderedCollection new.
]

{ #category : #testing }
ZathuraGame >> isTurnOf: aShip [

	^ ((ships first) == aShip)
]

{ #category : #accessing }
ZathuraGame >> lastCardThrownOnTheGame [

	thrownCardsStack ifEmpty: [ Error signal: 'Redo card must be thrown before another card has been played' ].
	^ thrownCardsStack last
]

{ #category : #'as yet unclassified' }
ZathuraGame >> methodSelectorAndArgumentNames [

thrownCardsStack ifEmpty: [ 
		Error signal:
			'Redo card must be thrown before another card has been played' ].
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

	^ board rankingOf: aShip.
]

{ #category : #set }
ZathuraGame >> removeFromCardsOnTable: aCard [

	| theCard |
	theCard := self findCardOnTable: aCard.
	cardsOnTable remove: theCard.
]

{ #category : #accessing }
ZathuraGame >> ships [

	^ ships
]

{ #category : #adding }
ZathuraGame >> throw: aCard [

	thrownCardsStack add: aCard
]

{ #category : #ending }
ZathuraGame >> winner [

	| winner |
	self assertZathuraHasFinished.
	winner := ships select: [ :ship | 
		          (self rankingOf: (ship)) == 1].
	^ winner at: 1
]
