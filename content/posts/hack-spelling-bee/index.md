+++
title = 'Hacking the (NY Times) Spelling Bee'
date = 2023-11-15T13:14:00-05:00
featured_image = "genius.png"
tags = ['Rust', 'Problem Solving']
+++

{{< figure src="genius.png" alt="How did I manage to get to Genius level in a matter of seconds?" caption="How did I manage to get to Genius level in a matter of seconds?" >}}

Firstly, I’m using the term “Hacking” to refer to the act of “fussing with machines” and not the act of “digital trespass”. “Hack” and “Hacking” are ambiguous words with multiple meanings [<sup>1</sup>].

So, the hack in this case is using machines (software) to enable you to impress your friends and quickly solve or at least get closer to solving the [New York Times Spelling Bee](https://en.wikipedia.org/wiki/The_New_York_Times_Spelling_Bee#:~:text=Spelling%20Bee%20was%20created%20by,The%20New%20York%20Times%20Magazine.). Some might call it a life-hack. Is it cheating? Maybe. That is not for me to judge.

Why, might you ask, would I take on something like this? That’s a good question. The truth is, as an engineer, I do enjoy challenges and problem solving. Also, as an engineer I get bored easily, I’m prone to laziness [<sup>2</sup>] and despise repetition. The truth is, I find joy in optimizing and automating things by tinkering in the digital world. If I’m being entirely honest, my wife, an English major and voracious reader always beat me in Spelling Bee. One day I grew tired of losing and knocked up a very quick hack to give me an (unfair?) boost.

A motivation of this exercise and why I’m choosing to document it, is to demonstrate how one might approach solving a problem with software. My hope is that early in career software engineers might find this useful. A key take-away is that the bulk of problem solving is using good old paper and pencil, coming up with ideas and then trying out those ideas in software to find out if they work or not. Then, either expand and keep going or go back to the “drawing board” so to speak.

### Define the problem

The first step for solving any problem is to truly understand the problem. In the real world, be careful. A lot of time and money can be wasted solving the wrong problem. The “Slow Elevator” problem is a prime example of this.

Proximity to the problem can definitely help. For example, can you even begin to truly understand the plight of the homeless until you have spent the night on the streets yourself? Find out how you can gain empathy and fully understand the problem you are looking to solve. If you are building a software system with a user in mind, then consider becoming the user, at least temporarily. I’ve most recently built systems for SecOps. I’m not a SecOps professional, but I did rig up my home network and appointed myself CISO, SecOps engineer, and Incident Responder for my home network. I did this just so I can gain proximity to the problem and gain empathy for my users.

For this particular problem, I found it useful to free yourself of constraints. If you had enough time, how would you theoretically solve the problem. In this case, it occurred to me the solution to this problem lies in a good old fashioned dictionary.

{{< figure src="dictionary.png" alt="For solving Spelling Bee, all the answers lie within a dictionary" caption="For solving Spelling Bee, all the answers lie within a dictionary" >}}

The thing is though. It’s a big book. Scanning the entire dictionary would not be efficient. Would there be a way to quickly filter out all of those words?

Actually, yes. The first rule of Spelling Bee is it only accepts words that are 4 or more letters in length. Regardless of what letters they contain, words of 3 or less characters can instantly be discarded. It helps, if you imagine pouring all the words from the dictionary as if they were water from a jug, and we have a filter that only allows bigger words to fall through.

We are making progress.

The next step is a little trickier but follows the same concept. We need another filter that is fed by the results of the first filter. We now need to find words that only contain the allowed letters for the day— and the words must contain the center letter. That could be tricky. From my art class, I recalled the idea of ["drawing with negative space"](<https://www.studiobinder.com/blog/what-is-positive-and-negative-space-in-art/#:~:text=Negative%20space%20is%20a%20term,the%20subject%20(positive%20space).>). This art trick opened up to me the idea of rather than filtering based on what the word must contain, instead filtering based on what the word must not contain.

This involves taking all the possible letters in the alphabet, and creating a new list of all the letters that are not in the SpellingBee list of 7 letters. With this list, let’s call it the list of invalid characters, we can build our secondary filter. If the word contains one of the invalid characters, we discard it.

Finally, we need to make sure the word contains the center letter.

That is it. Let’s test it using pencil and paper.

Imagine we have a (very) small dictionary containing the following words:

{{< figure src="one.png" alt="The starting point is the (very small) dictionary" caption="The starting point is the (very small) dictionary" >}}

Let’s run it through our first filter which discards words that are too short. This leaves us with:

{{< figure src="two.png" alt="Filtering out the small words" caption="Filtering out the small words" >}}

Now, we have to make sure the words contain the Spelling Bee letters. Let’s assume “neoflip”. We also have to make sure the word contains the center letter — which is “o”.

{{< figure src="three.png" alt="Filtering out the words that only contain the Spelling Bee letters and that must contain the center letter" caption="Filtering out the words that only contain the Spelling Bee letters and that must contain the center letter" >}}

Now with this resulting list, I can plug in those words directly to Spelling Bee. What we have is a prototype algorithm. Now onto the fun part — crafting an implementation of this algorithm into software.

You should be able to look at my [code](https://github.com/jasondchambers/spellingbee_cheat/blob/main/src/main.rs) now, and as long as you understand the algorithm , you should have a good sense of what the code is doing.

A recommended exercise, if you are in the process of learning to code is to make an attempt to write a solution in your language of choice. You can find dictionaries of words (where each word is on a separate line) all over the Internet. You can also find one on your PC.

Happy Hacking!

<p style='text-align: center;'>. . .</p>

_[1] — There are approximately 8 definitions according to [“The Jargon File”](http://www.catb.org/~esr/jargon/html/H/hacker.html). The New Yorker has a [wonderful article](https://www.newyorker.com/tech/annals-of-technology/a-short-history-of-hack) if you want to dig deeper._

_[2] — I don’t classify myself as a member of the “best” club, but [the best engineers are typically lazy](https://thethreevirtues.com/) and find a way to channel that lazyness. That’s perhaps why we have bridges._
