"
I m the root of a virtual folder to keep the model of the website. 
My leaves are for example instances of FOPillarPage, FOFileObject, or FOWebImage.
"
Class {
	#name : 'FOWebsiteRoot',
	#superclass : 'FOWebFolder',
	#category : 'Foliage-Core-Model',
	#package : 'Foliage-Core',
	#tag : 'Model'
}

{ #category : 'visiting' }
FOWebsiteRoot >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitWebsiteRoot: self 
]

{ #category : 'accessing' }
FOWebsiteRoot >> defaultLayout [

	^ 'page'
]

{ #category : 'testing' }
FOWebsiteRoot >> isRoot [
	^ true
]

{ #category : 'accessing' }
FOWebsiteRoot >> name [ 
	^ #/
]

{ #category : 'accessing' }
FOWebsiteRoot >> path [ 
	^ Path root
]

{ #category : 'accessing' }
FOWebsiteRoot >> root [ 	
	^ self 
]

{ #category : 'accessing' }
FOWebsiteRoot >> website [ 
	^ parent 
]
