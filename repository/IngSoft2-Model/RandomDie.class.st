"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

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
	numberOfFaces:		<Object>


    Implementation Points
"
Class {
	#name : #RandomDie,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
RandomDie class >> assertValid: aNumberOfFaces [

	aNumberOfFaces >= 3 ifFalse: [ 
		Error signal: 'Die cannot be created with a number of faces smaller than 3' ]
]

{ #category : #'instance creation' }
RandomDie class >> with: aNumberOfFaces [

	self assertValid: aNumberOfFaces.
	^ self new initializeWith: aNumberOfFaces
]

{ #category : #initialization }
RandomDie >> initializeWith: aNumberOfFaces [ 
	numberOfFaces := aNumberOfFaces.
]

{ #category : #rolling }
RandomDie >> maxNumberOfRoll [

	^ numberOfFaces
]

{ #category : #rolling }
RandomDie >> roll [

	^ numberOfFaces atRandom.
]
