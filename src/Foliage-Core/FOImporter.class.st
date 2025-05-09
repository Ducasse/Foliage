"
I use the file reader hierarchy (subclasses of `FOAbstractReader`) to read and create a model of files. 
Most of the file kinds (images, html,...) are represented as a simple reference. 
Microdown files are however parsed and represented a document tree that can then later be converted to HTML.

The method readFile: file path: aPath is the most important: it parses, builds and store the corresponding entity. 
This entity will be stored in the root structure of the website. 

```
	model := (reader file: file) model.
```
"
Class {
	#name : 'FOImporter',
	#superclass : 'Object',
	#instVars : [
		'website'
	],
	#category : 'Foliage-Core-Base',
	#package : 'Foliage-Core',
	#tag : 'Base'
}

{ #category : 'accessing' }
FOImporter class >> path: aString [
	^ self new
		path: aString asFileReference 
]

{ #category : 'accessing' }
FOImporter >> extensionsToIgnore [
	^ #( swp DS_Store)
]

{ #category : 'generation' }
FOImporter >> readAll: files [
	files do: [ :file | 
		self readFile: file ]
]

{ #category : 'generation' }
FOImporter >> readFile: file [

	self 
		readFile: file
		path: (website relativeRawPath: file)
]

{ #category : 'generation' }
FOImporter >> readFile: file path: aPath [
	"Create a model  (file, resources,... object) for the file at the path.
	The model is stored in the site root."
	
	|  model |
	[ (self readerForExtension: file extension) ifNotNil: [ :reader | 
		model := (reader file: file) createModelEntity.
		
		"Set the parent (which is used to compute the root) 
		of the model based on the tree structure."
		(website resolvePath: aPath parent)
			at: aPath basename
			put: model ] ]
			on: STONReaderError 
			do: [ :error |  ('Could not read in ', file asString) emit ]
	
	
]

{ #category : 'accessing' }
FOImporter >> readerForExtension: aString [ 
	(self extensionsToIgnore includes: aString) ifTrue: [ 
		^ nil ].
	(FOAbstractReader forFileExtension: aString)
		ifNotNil: [ :cls | ^ cls ].
	
	"just copy it"
	^  FOFileReader
]

{ #category : 'accessing' }
FOImporter >> website [
	^ website
]

{ #category : 'accessing' }
FOImporter >> website: aWebsite [ 
	website := aWebsite 
]
