+++
title = 'Coding Ninja'
date = 2023-11-28T10:56:01-04:00
tags = ['Coding', 'Career']
featured_image = "ninja.png"
+++

{{< figure src="ninja.png" alt="Code like a Ninja — but how?" caption="Code like a Ninja — but how?" >}}

Here are some tips I’d like to share from my 4 decades of coding. This list began life in another [article I wrote](/posts/tips-becoming-swe/), but I realized it is worthy of being it’s own living thing (expect updates in the future).

1. Don’t stop learning. There is always something to learn in this field.
2. You may struggle less if you have at least a basic understanding of [binary](https://en.wikipedia.org/wiki/Binary_number) and [logic gates](https://www.youtube.com/watch?v=UvI-AMAtrvE). You don’t need to be able to build a computer, but it is helpful as a programmer to appreciate conceptually how a computer works. If you are completely new to this field, logic gates by themselves may not “click” — until perhaps, you understand how they might be connected together to do math — which is at the heart of what a computer does. This video may help. To this day, I still find this [little trick](https://betterexplained.com/articles/swap-two-variables-using-xor/) magical.
3. Stay active. Just like fitness, if you don’t use it, you lose it. Keep practicing. Coding katas are a great way to stay sharp. [Codewars](https://www.codewars.com/) is a great resource to practice.
4. Learn from others. They will likely have different opinions and perspectives to you. You don’t always have to agree — but stay open to new ideas.
5. Watch for the trap of perfection. Don’t be sloppy — [but know when to stop](/posts/perfectionism/).
6. Make it work first, then make it pretty (re-factor), then and only then make it work fast [(if needed)](https://ubiquity.acm.org/article.cfm?id=1513451).
7. Ditch the Ragu and cook from scratch. Modern languages, frameworks and libraries are wonderful and make you highly productive. They can appear magic. Dig deeper and try and understand the magic. For example, learn 3D graphics by avoiding libraries and GPUs and just code it from scratch at the lowest level possible. Do your own matrix multiplications, use your own data structures. For AI, avoid using ML libraries and try coding a single neuron from scratch. Write your own linked list. This may seem like re-inventing the wheel — it is. Just use the approach temporarily to solidify the concepts. Then, move to using the fancy libraries and frameworks once you have a better understanding of what they do for you.
8. I have yet to discover a single paradigm to rule them all. [Functional](https://en.wikipedia.org/wiki/Functional_programming) [Structured](https://en.wikipedia.org/wiki/Structured_programming) and [Object Oriented](https://en.wikipedia.org/wiki/Object-oriented_programming) remain useful to this day depending on the problem you are looking to solve. Study the paradigms and you will find learning a new language becomes much easier.
9. Similarly, the quest for a general purpose language to rule them all is as yet unresolved. With the rapid advances in AI, perhaps it will be natural language after all [(at least for the “fuzzy” problems)](/posts/thoughts-on-software-2.0/). Perhaps it will happen [sooner than you think](https://www.youtube.com/watch?v=JhCl-GeT4jw&t=627s).
10. When learning a new language, it’s more fun and rewarding if you use it to solve a problem you are facing.
11. If you are already proficient in one language, consider re-writing it in another language.
12. As you build up a repertoire of languages, use the one that is the best fit for the problem you are trying to solve.
13. Learn by doing. You cannot learn tennis by reading a book.
14. Be patient with yourself. If you are not finding any joy in the process of writing code and solving problems — perhaps the career of a software engineer is not for you. That’s ok — it’s not for everyone. Your talents lie somewhere else. At least you have tried it out which is better than wondering what if.
15. Consider learning at least one [functional programming language](https://en.wikipedia.org/wiki/Functional_programming), one [object oriented language](https://en.wikipedia.org/wiki/Object-oriented_programming), one [assembly language](https://en.wikipedia.org/wiki/Assembly_language) and one [systems programming language](https://en.wikipedia.org/wiki/Systems_programming). This will give you a good grounding and enable you to quickly learn new languages. I recommend Haskell (functional), Python [ <sup>1</sup> ](object oriented), 8086 (assembly language) and C (system programming language). It’s not essential for you to learn assembly language — but if you want to learn something like C, I think learning assembly first will definitely help you understand pointers in C.
16. Study [imperative](https://en.wikipedia.org/wiki/Imperative_programming) vs [declarative](https://en.wikipedia.org/wiki/Declarative_programming) approaches to programming.
17. If you are an absolute beginner, or you want to introduce your child to programming, I recommend a visual programming language such as [Scratch](https://scratch.mit.edu/) from MIT. The syntax of a traditional text-based programming language may be a barrier too high.
18. Python is a great place to start if you are looking for your first language to learn (I don’t recommend BASIC — it’s not 1983 anymore). Python is unusual as it is both a great educational [ <sup>2</sup> ] language and is very widely used in industry [ <sup>3</sup> ].
19. AI assistants, such as [GitHub CoPilot](https://github.com/features/copilot) are useful but only once you have achieved some proficiency in the language. I would recommend not using them while you are learning a language.
20. Be wary of camps and tribes. Software engineers can get very opinionated and passionately defensive of the tools and languages they use. I was one of those. I would proclaim “Java is too slow. It’s Just Another Version of Algol. C++ is far superior” — only for me to wind up switching to Java a year later. Try and rise above the flame-wars and instead focus on solving problemsAs you progress, be sure to dive into the world of algorithms. For example, consider implementing a sorting algorithm or two. You will discover that the genius of software is not really in the language or the code itself — it is in the algorithm. You will also venture into the adjacent world of data structures as a bonus.
21. As you progress, be sure to dive into the world of [algorithms](https://en.wikipedia.org/wiki/Algorithm). For example, consider implementing a sorting algorithm or two. You will discover that the genius of software is not really in the language or the code itself — it is in the algorithm. You will also venture into the adjacent world of [data structures](https://en.wikipedia.org/wiki/Data_structure) as a bonus.
22. Take small baby steps. Code a little, test a little, repeat [ <sup>4</sup> ]. Get your feedback loops running as fast as possible. When things break, and they will break you will avoid hours of debugging what went wrong.
23. As you progress — don’t forget your [tests!](https://en.wikipedia.org/wiki/Test-driven_development) Be pragmatic — if you are just exploring, learning, experimenting — it’s ok to not worry too much about tests, code structure and quality. However, if the code you are working on will go to production and it needs to be maintained, tests are essential. Most languages have frameworks that support unit testing. Become familiar with them and use them. They will make your code better and you a better coder.
24. Know that you will spend more time reading and debugging code (usually someone else’s) than actually writing new code from scratch. Debugging code can be very hard especially if it is not easily reproducible. Modern software is typically part of a large system made up of many layers and many components. Just like a detective, it is simply a process of elimination to find the culprit. When searching for a needle in a haystack, you have to make the haystack as small as possible. Carve out the area of code where you think the bug exists. Put this into its own little project? Why? So, you can speed up the feedback loop and try things out much faster. Would you prefer to wait 20 minutes for the build to complete or 2 seconds? It’s possible, although extremely unlikely [ <sup>5</sup> ] that the defect is in some 3rd party library or the compiler. If you do discover this is where the defect exists, that small little project you carved out to investigate can serve as a proof the defect exists you can send to the owner/vendor.
25. We live in a hyper-connected world. The software you are writing is likely no exception. Ever since the [Internet adopted TCP/IP 40 years ago](https://www.usg.edu/galileo/skills/unit07/internet07_02.phtml#:~:text=This%20allowed%20different%20kinds%20of,connected%20by%20a%20universal%20language.), TCP/IP has become the networking standard. Learning the networking stack beneath the application layer will serve you well. You don’t need to become a network engineer, but being able to [figure out why your software is failing to connect](https://www.youtube.com/watch?v=4_7A8Ikp5Cc) to another piece of software will get you closer to coding ninja status. This looks like a fun way to [play with network packets](https://scapy.net/).
26. Know [the one rule to rule them all](/posts/one-rule/)
27. Consider the world of art. Carving and Sculpting is mostly subtractive. Painting is mostly additive. A coding ninja is both a sculptor and a painter. When coding, be sure to subtract and eliminate code that is not adding value, is dead code or is no longer needed [ <sup>6</sup> ]. Why? it makes the code easier to comprehend, faster to debug and makes it more theoretically more secure [ <sup>7</sup> ].
28. Learn to master the command line. IDEs come and go. Examples I’ve used over the years include [Turbo Pascal](https://en.wikipedia.org/wiki/Turbo_Pascal), [Visual Basic](https://winworldpc.com/product/microsoft-visual-bas/40), Visual Studio for C++, [Visual Age for Java](https://en.wikipedia.org/wiki/VisualAge), [JBuilder](https://en.wikipedia.org/wiki/JBuilder), [Eclipse](https://eclipseide.org/), [Atom](<https://en.wikipedia.org/wiki/Atom_(text_editor)>) and now [Visual Studio Code](https://code.visualstudio.com/). The command line has been my trusty companion [ <sup>8</sup> ] throughout my career. It continues to evolve and will continue to be my trusty companion in the future.
29. Learn how to write [code that is secure](https://en.wikipedia.org/wiki/Application_security). This is a huge area worthy of it’s own list. Know the threats. Know thy enemy. Know the principles. Learn how to break things and not just how to build things. Study [offensive security](https://www.techtarget.com/whatis/definition/offensive-security). Knowing how to attack things (ethically) will make you build things in a better way.
30. Understand the basics of [cryptography](https://en.wikipedia.org/wiki/Cryptography). You don’t need to (unless you want to) understand the mathematics that underpin cryptography, but understanding the basic concepts of [symmetric](https://en.wikipedia.org/wiki/Symmetric-key_algorithm), [asymetric encryption](https://en.wikipedia.org/wiki/Public-key_cryptography) and [1-way hashing](https://en.wikipedia.org/wiki/Cryptographic_hash_function) along with understanding why and where they might be used to support the [CIA](https://www.techtarget.com/whatis/definition/Confidentiality-integrity-and-availability-CIA) triad will serve you well.
31. Pay attention to and measure the health of your code. [Know your numbers!](/posts/know-your-numbers-health-screen-your-codebase-today/)
32. Most of all. Have some fun!

### Contributions

I’d like to thank the following Ninjas for taking the time to review and provide suggestions to the list:

Tom Gagnier
[Joey Gibson](https://www.linkedin.com/in/joeygibson/)
[Ryan Hofschneider](https://www.linkedin.com/in/ryanhof/)

<p style='text-align: center;'>. . .</p>

_[1]: — Python is not necessarily considered an object-oriented programming language — it does however support the object-oriented paradigm. It is what is considered a multi-paradigm programming language._

_[2]: - Python is used for [Stanford’s Code in Place program](https://codeinplace.stanford.edu/) (of which I am a volunteer)_

_[3]: - Python is one of the most popular programming languages on the planet._

_[4]: - “There are mountains in our way, But we climb a step every day” — lyrics from “Up Where We Belong”, Joe Cocker and Jennifer Warnes_

_[5]: - In my 40 years of coding, I have only discovered one defect in a (C) compiler. I found it by inspecting the assembler generated by the compiler._

_[6]: - “A designer knows he has achieved perfection not when there is nothing left to add, but when there is nothing left to take away.”, Antoine de Saint-Exupery_

_[7]: - Smaller code has a smaller attack surface area._

_[8]: - Shells have evolved. I started with [csh](https://en.wikipedia.org/wiki/C_shell), then [ksh](https://en.wikipedia.org/wiki/KornShell), then [bash](https://www.gnu.org/software/bash/). I had a good run with bash for many years. Several years ago I switched to zsh. And beacuse I’m lazy my goto today is [“oh my zsh”](https://ohmyz.sh/)._
