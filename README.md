# AnimatedTransitions
Animated transitions tutorials from mathewsanders.com

Part 1 Notes (http://mathewsanders.com/animated-transitions-in-swift/):

- The samples I’ve given have created a transition that only uses the views of the screens that we’re transitioning from and to, but remember that the container view that the animation is performed in is just a regular UIView and we can add anything we want to it.

- Also, the animations have all been 2D transforms but 3D transforms can be created when you animate the views layer object.

- We’ve looked specifically at a modal transition, there are some differences when creating a transition for a push navigation or a changing screens in a tab bar but the general approach is the same.

Part 2 Notes (http://mathewsanders.com/custom-menu-transitions-in-swift/):

- Remember that you can set the alpha of the background color, instead of having to set the alpha of the actual view itself.
