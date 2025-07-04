"
I'm a blog I have a title and a layout.
I'm build from a folder. 
I generate a Blog page overview and a list of posts.
"
Class {
	#name : 'FOBlog',
	#superclass : 'FOWebFolder',
	#instVars : [
		'layout',
		'title'
	],
	#category : 'Foliage-Core-Blog',
	#package : 'Foliage-Core',
	#tag : 'Blog'
}

{ #category : 'visiting' }
FOBlog >> acceptFOVisitor: aFOVisitor [ 
	^ aFOVisitor visitBlog: self 
]

{ #category : 'accessing' }
FOBlog >> defaultLayout [

	^ 'blog'
]

{ #category : 'accessing' }
FOBlog >> document [
	self shouldBeImplemented.
]

{ #category : 'converting' }
FOBlog >> emitSlots [

	^ #(title layout)
]

{ #category : 'accessing' }
FOBlog >> layout [

	^ layout ifNil: [ self defaultLayout ]
]

{ #category : 'accessing' }
FOBlog >> layout: aString [

	layout := aString
]

{ #category : 'accessing' }
FOBlog >> overviewPage [

	^ FOBlogOverviewBuilder new 
		blog: self;
		numberOfCharacters: 100; 
		buildSummary
]

{ #category : 'accessing' }
FOBlog >> postAfter: aFOPillarPage [ 
	| list index |
	list := self sortedByPublishDate.
	index := list indexOf: aFOPillarPage.
	^ (index < list size)
		ifTrue: [ list at: index + 1 ]
		ifFalse: [ nil ]
]

{ #category : 'accessing' }
FOBlog >> postBefore: aFOPillarPage [ 
	| list index |
	list := self sortedByPublishDate.
	index := list indexOf: aFOPillarPage.
	^ index > 1
		ifTrue: [ list at: index - 1 ]
		ifFalse: [ nil ]
]

{ #category : 'accessing' }
FOBlog >> posts [
	^ items values select: [:each | each isPost ]
]

{ #category : 'sorting' }
FOBlog >> publishedPosts [
	^ self posts select: [ :each | each isPublished ]
]

{ #category : 'rendering' }
FOBlog >> renderContextClass [

	^ FORenderContext
]

{ #category : 'resolving' }
FOBlog >> resolvePath: aRelativePath [ 
	aRelativePath isEmpty ifTrue: [ 
		^ self ].
	^ items 
		at: aRelativePath segments first
		ifAbsent: [ 
			Error signal: 'no child with name ', aRelativePath segments first ].

]

{ #category : 'sorting' }
FOBlog >> sortedByPublishDate [

	^ self publishedPosts sorted: #publishDate ascending
]

{ #category : 'accessing' }
FOBlog >> title [

	^ title ifNil: [ 'Untitled' ]
]

{ #category : 'accessing' }
FOBlog >> title: aString [

	title := aString
]
