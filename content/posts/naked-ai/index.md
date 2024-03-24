+++
title = 'Naked AI'
date = 2024-01-22T12:36:52-04:00
featured_image = "figure1.png"
+++

Way back in 1999, a new cooking show in the UK launched called [The Naked Chef](https://en.wikipedia.org/wiki/The_Naked_Chef) starring [Jamie Oliver](https://en.wikipedia.org/wiki/Jamie_Oliver). The name comes from the style of cooking where the methods were stripped down to the bare essentials.

I like the approach of getting down to the basics to begin the learning journey for something as complicated and seemingly magical as AI. I have used this approach successfully before to learn networking and the TCP/IP stack.

If we were to strip AI (artificial neural networks specifically) down to the bare essentials, what might we find? If we were to put AI under a microscope, what would we be looking at. If you are looking to better understand things like [ChatGPT](https://chat.openai.com/auth/login) under the covers, where do you even start? The field of AI began [approximately 80 years ago](https://archive.org/details/a-logical-calculus-of-ideas-immanent-in-nervous-activity/mode/2up) — who has time to study the history and read all the papers to understand how we got where we are today?

As I began my journey to learn this technology, I was not getting what I needed just by following [PyTorch](https://pytorch.org/) or [TensorFlow](https://www.tensorflow.org/) tutorials. Although I was able to get things working, I remained curious as to what is actually happening underneath the covers. I also felt initially overwhelmed and bored with the concepts, the theories and the dizzying amount of algorithms related to how machines learn. For me at least, I need to learn by doing.

The intent here is to provide you with a good yet very basic understanding of an [artificial neural network (ANN)](https://en.wikipedia.org/wiki/Neural_network_(machine_learning)). Consider it a place to start your learning. We will not cover training — we will assume the network is already trained. In fact, we won’t even go into neural networks at all — we will go deeper and see what a stand-alone artificial neuron does. This is focused on helping developer’s learn AI, and so I will be using code to demonstrate the concepts. Specifically, I’m using Python — if you are not familiar with Python, don’t worry — it should be fairly easier to understand if you are familiar with other programming languages. I use Python because it has emerged as the standard programming language for machine learning.

If you want to learn more, I recommend the [MIT Introduction to Deep Learning](https://www.youtube.com/watch?v=QDX-1M5Nj7s&list=PLtBw6njQRU-rwp5__7C0oIVt26ZgjG9NI) available for free available on the [Alexander Amini channel](https://www.youtube.com/@AAmini).

In addition, I strongly recommend the Introduction to Neural Networks section within the [Brilliant’s](https://brilliant.org/home) “CS & Programming” course.

Personally, I gain a lot more from doing rather than just reading alone, so I created a [Jupyter Notebook](https://jupyter.org/) available on [my GitHub page](https://github.com/jasondchambers/naked_ai) for you to follow along and run the code yourself.

So, let’s get started!

## The (artificial) neuron

In Figure 1, we have a neuron (loosely based on a [neuron nerve cell](https://en.wikipedia.org/wiki/Neuron) in the human brain). As an aside, in the human brain, there are [approximately 86 billion](https://www.youtube.com/watch?v=2kSl0xkq2lM&t=3987s) of these neuron nerve cells “wired” together. Artificial neurons are what (artificial) neural networks are built from. At the lowest level, it’s how ChatGPT works at the cellular level. There are potentially billions of these wired together to form a neural network. This may even look scary at first, but let’s see what is going on here. Basically, we have inputs coming in (denoted by X) to a neuron.

Not all inputs carry the same weight — some may be more important than others. It is these weights that are determined (learned) during the training of a neural network. By the way, the term weights is often used interchangeably with the term parameters.

{{< figure src="figure1.png" alt="Figure 1 — an artificial neuron showing inputs (X) corresponding weights (W) and activation function resulting in some output ŷ" caption="Figure 1 — an artificial neuron showing inputs (X) corresponding weights (W) and activation function resulting in some output ŷ" >}}

In this generic model of a neuron, we have an unspecified number of inputs denoted by m. Each input (X) has a corresponding weight (W).

The neuron produces a single output denoted by ŷ. Unless this is the final output , the output is fed into one or more downstream neurons hence the term “network”.

But what does a neuron do and how does it produce an output? It turns out, all it does is some quite simple math. Here is the equation:

{{< figure src="equation.png#center" >}}

This by itself may look a little daunting, so let’s break it down further with examples. Let’s start with the bit in the brackets:

{{< figure src="equation_in_brackets.png#center" >}}

In plain English we are multiplying each input (X) by it’s weight (W), and adding them all up together (summation).

Let’s assume we have 3 inputs X1, X2, X3 with the corresponding values of 10,14,-5. We have corresponding weights W1, W2, W3 with the corresponding values of 1,8,3:

    = (X1 x W1) + (X2 x W2) + (X3 x W3)
    = (10 x 1) + (14 x 8) + (-5 x 3)
    = 10 + 112 + (-15)
    = 107

For the purpose of simplicity, we are ignoring “bias” altogether here. Bias is simply an adjustable numerical term added to the sum.

Now, onto the next part — what is the weird g() in our formula and why do we need it? Can we not just say the output ŷ be set to 107 and be done? The answer is firmly no. We need to introduce some non-linearity into our network. The reason for this is real-world data is non-linear — roads and rivers have curves and bends — it turns out, so does data. In simplistic terms, if you were to plot the value of houses with 1, 2, 4, 8, 16 bedrooms, would it be a straight line? Most likely not. So, we have to introduce some non-linearity into the network to better reflect the real-world. We may also want to constrain the output to a nice range between 0 and 1 to represent things like probability.

There are many standard off-the-shelf non-linear activation functions to choose from. In our simple example below, we use a [sigmoid](https://en.wikipedia.org/wiki/Sigmoid_function) function which is simply a squashing function.

## g() — the activation function
Recall the value 107 produced earlier by our simple example above. We need to introduce some non-linearity and we decided we will use a sigmoid function which is simply a squashing function so that the value is mapped to some value between 0 and 1. We are going to leave the math formulae behind and instead jump straight into code. The only library I do use is [NumPy](https://numpy.org/) and I use it just to do some of the math for me in a succinct way. Here’s what it looks like in code:


{{< highlight python3 >}}
import numpy as np 

def sigmoid(x):
    return 1/(1 + np.exp(-x))
{{< / highlight >}}

So, if we were to run 107 through the sigmoid function, we see it returns 1.0 — meaning that it is fully activated.

    >>> sigmoid(107)
    1.0

And that is it. Our neuron is complete. See figure 2 below:

{{< figure src="figure2.png" alt="Figure 2 — plugging some example numbers into our neuron" caption="Figure 2 — plugging some example numbers into our neuron" >}}

In a more useful (artificial) neural network, the value 1.0 would typically be fed in as an input into one or more other neurons along with other outputs from other neurons until we reach the final output layer which yields the final output.

## Re-cap

At this point, we’ve stripped down AI to the basics and put it under a microscope. What we found is a thing called a neuron which is similar to a neuron in the human brain. We’ve introduced a bit of basic mathematics (Linear Algebra) and we have provided a concrete example and worked through the equation. Things may not be clicking at this point. It’s just a bunch of numbers you might have observed. You are absolutely right — it is indeed just a bunch of numbers and some simple math. You might be asking, “I don’t see any signs of intelligence” and you would also be completely correct in that observation.

The illusion of intelligence — the magic of AI, is really how it learns what those weights should be during the training phase. That is out of scope for this little tutorial.

Now it’s time to solidify our understanding by a) using code and b) an applied example.

This example is taken from the “Introduction to Neural Networks” which is part of [Brilliant’s](https://brilliant.org/home/) “CS & Programming” course. In the course, a cat called Chester is introduced, and we have to predict how Chester will respond when his human gives him attention. When Chester is happy, he purrs. Will Chester purr?

{{< figure src="chester.png" alt="Figure 3 — A neuron for predicting if Chester the cat will purr" caption="Figure 3 — A neuron for predicting if Chester the cat will purr" >}}

Below is what a neuron looks like in code. It’s surprisingly a small amount of code don’t you agree? We will define it here and use it later. It returns ŷ given the input values and corresponding weights. It doesn’t care what the numbers mean. It doesn’t care that the numbers may correspond to words (or tokens) in the case of a large language model such as [GPT-3](https://en.wikipedia.org/wiki/GPT-3). It doesn’t care if the numbers refer to pixels in an image. It doesn’t care if we are scratching Chester’s belly or Chin. It’s just numbers.

{{< highlight python3 >}}
def neuron(input_values, weights):
    output = np.dot(input_values,weights)
    output = sigmoid(output)
    return output
{{< / highlight >}}

Since we are in code, let’s break it down and experiment to further solidify our understanding. The code [np.dot](https://numpy.org/doc/stable/reference/generated/numpy.dot.html) is a shorthand way of calculating the dot-product of our input values and the weights. Let’s play around with it.

Assume we have two input values 1 and 10 and corresponding weights of 2 and 3. If we were to do this in long-form, the dot-product would be:

    >>> dot_product = (1*2)+(10*3)
    >>> print(dot_product)
    32

But we use np.dot from NumPy instead as it just does that math for us:

    >>> input_values = np.array([1,10])
    >>> weights = np.array([2,3])
    >>> np.dot(input_values,weights)
    32

We then feed that value into our activation function to provide non-linearity — in our case, we are just using the sigmoid function.

    >>> print(sigmoid(32))
    0.9999999999999873

Now, let’s get back to solving our problem where we are trying to predict if Chester will purr or not. We need someway to encode our knowledge into numbers. To do this, I have a scratch() function which generates an input array of numbers based on if he is being scratched or not. We simply use 0 to denote that Chester is not being scratched and 1 to denote that he is being scratched.

{{< highlight python3 >}}
def scratch(back=False, ears=False, chin=False, belly=False):
    input_array  = np.zeros(4)
    input_array[0] = 1 if back is True else 0
    input_array[1] = 1 if ears is True else 0
    input_array[2] = 1 if chin is True else 0
    input_array[3] = 1 if belly is True else 0
    return input_array
{{< / highlight >}}

We also need to define the weights. Again, we hard-code these here based on our knowledge of Chester’s behavior for example only. Realistically, we would not be setting these weights manually — this is where we rely on machine learning techniques to set the weights during the training of the model. We basically assign higher numbers to represent the things Chester loves and lower (negative) numbers for the things Chester hates making him less likely to purr. The numbers don’t really matter — it only matters how the inputs relate to each other. I could for example have chosen much bigger numbers for the things he hates as long as the thing he loves the most is the biggest and hence heavily weighted number.

{{< highlight python3 >}}
# Assume our neuron has been trained based on 
# the following observations:
#
# - Chester loves his back being scratched
# - Chester hates his ears being scratched
# - Chester really likes his chin being scratched
# - Chester likes his belly being scratched
#
# The array is in this order 
# [back, ears, chin, belly]

weights = np.array([3,-10,2,1])
{{< / highlight >}}

Now, everything is in place to run inference. Let’s do some predictions. Before you do that, perhaps you can predict yourself what the probability might be for each case using pen and paper.

    >>> input_layer = scratch(back=False, ears=False, chin=False, belly=False)
    >>> output = neuron(input_layer, weights)
    >>> print("Will Chester the cat purr if I do nothing? {:.2%} probability".format(output))
    Will Chester the cat purr if I do nothing? 50.00% probability

Recall that Chester **loves his back being scratched**. What does our AI predict when we do that?

    >>> input_layer = scratch(back=True, ears=False, chin=False, belly=False)
    >>> output = neuron(input_layer, weights)
    >>> print("Will Chester the cat purr if I scratch just his back? {:.2%} probability".format(output))
    Will Chester the cat purr if I scratch just his back? 95.26% probability

Recall that Chester **hates his ears being scratched**. What does our AI predict?

    >>> input_layer = scratch(back=False, ears=True, chin=False, belly=False)
    >>> output = neuron(input_layer, weights)
    >>> print("Will Chester the cat purr if I scratch just his ears? {:.2%} probability".format(output))
    Will Chester the cat purr if I scratch just his ears? 0.00% probability

Recall that Chester **really likes his chin being scratched**. What does our AI predict?

    >>> input_layer = scratch(back=False, ears=False, chin=True, belly=False)
    >>> output = neuron(input_layer, weights)
    >>> print("Will Chester the cat purr if I scratch just his chin? {:.2%} probability".format(output))
    Will Chester the cat purr if I scratch just his chin? 88.08% probability

Recall that Chester **likes his belly being scratched**. What does our AI predict?

    >>> input_layer = scratch(back=False, ears=False, chin=False, belly=True)
    >>> output = neuron(input_layer, weights)
    >>> print("Will Chester the cat purr if I scratch just his belly? {:.2%} probability".format(output))
    Will Chester the cat purr if I scratch just his belly? 73.11% probability

Let’s now go for broke. Let’s avoid all the things Chester hates and scratch all the things he likes, really likes or loves. What does our AI predict?

    >>> input_layer = scratch(back=True, ears=False, chin=True, belly=True)
    >>> output = neuron(input_layer, weights)
    >>> print("Will Chester the cat purr if I scratch everything except the ears? {:.2%} probability".format(output))
    Will Chester the cat purr if I scratch everything except the ears? 99.75% probability

And that is all there is to the magic of AI (artificial neural networks to be exact) at the cellular level.

What if this neuron was connected with others into some kind of network? Chester, in the above example is a very simple cat. But what if we take into account that Chester is hungry? or Chester has been caught out in the rain? Or Chester is in pain? These, and many others would most likely influence Chester and therefore complicate our prediction for whether he would purr or not. Imagine having neurons for each of these “features” and combining them with our simple scratching neuron we just developed. This, I hope begins to demonstrate the power of neural networks. As an exercise, perhaps you can consider extending it on your own.

I hope you have found it useful. Now, to go from here you have so many options. There are tons of YouTube videos, books, on-line courses to choose from. Happy learning!


