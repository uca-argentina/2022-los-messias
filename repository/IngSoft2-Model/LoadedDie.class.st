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
	loadedFace:		<Object>


    Implementation Points
"
Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'loadedFace'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LoadedDie class >> assertValid: aLoadedFace [
	aLoadedFace > 0 ifFalse: [ Error signal: 'Die should be loaded with number greater than 0' ] 
]

{ #category : #'instance creation' }
LoadedDie class >> with: aLoadedFace [

	self assertValid: aLoadedFace.
	^ self new initializeWith: aLoadedFace
]

{ #category : #initialization }
LoadedDie >> initializeWith: aLoadedFace [

	loadedFace := aLoadedFace
]

{ #category : #rolling }
LoadedDie >> maxNumberOfRoll [

	^ loadedFace
	
]

{ #category : #rolling }
LoadedDie >> roll [
	^ loadedFace .
]
