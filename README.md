# VCContainmentInStackView
Showing how ViewControllers can be contained within items in a stack view, linked together using ReactiveKit

An example of an architecture built on a UIStackView (as an alternative to using UITableView)

- items are positioned on top of each other
- VCs can be contained in an `ContainerStackItem` item
- the `ContainerStackItem` gives us control over the presentation of that VC within the stack
- this demo shows how they can be bound together to affect one another, using [ReactiveKit](https://github.com/ReactiveKit/ReactiveKit).

This basic example has two sliders, one which controls the height of the bottom item (which shows a scrollView full of rectanges), the other which controls the number of coloured rectangles present in the scrollView. 

<img src="http://f.cl.ly/items/3Q3C2L1Z441v2X053U2k/Image%202016-02-11%20at%2012.32.14%20am.png" />
