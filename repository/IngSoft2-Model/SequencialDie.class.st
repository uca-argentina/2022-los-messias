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
	numbers:		<Object>


    Implementation Points
"
Class {
	#name : #SequencialDie,
	#superclass : #Object,
	#instVars : [
		'numbers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SequencialDie class >> with: anArrayOfNumbers [

	^ self new initializeWith: anArrayOfNumbers
]

{ #category : #initialization }
SequencialDie >> initializeWith: aCollectionOfNumbers [

	numbers := OrderedCollection new.
	aCollectionOfNumbers do: [ :number | numbers add: number ]
]

{ #category : #rolling }
SequencialDie >> roll [

	| result |
	result  := numbers removeFirst.
	numbers addLast: result .
	^ result
]
