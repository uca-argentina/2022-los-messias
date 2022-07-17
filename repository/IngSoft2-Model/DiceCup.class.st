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
	dice:		<Object>


    Implementation Points
"
Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
DiceCup class >> assertValid: aDice [

	aDice ifEmpty: [ 
		Error signal: 'Dice Cup should be initialized with at least one die' ]
]

{ #category : #'instance creation' }
DiceCup class >> withAll: dice [
	self assertValid: dice.
	^ self new initializeWithAll: dice
]

{ #category : #initialization }
DiceCup >> initializeWithAll: aDice [ 
	dice := aDice.
]

{ #category : #rolling }
DiceCup >> maxNumberOfRoll [

	^ dice sum: [ :aDie | aDie maxNumberOfRoll ]
]

{ #category : #rolling }
DiceCup >> roll [

	^ dice sum: [ :aDie | aDie roll ]
]
