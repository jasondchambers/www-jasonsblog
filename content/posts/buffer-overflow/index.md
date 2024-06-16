+++
title = 'Buffer overflow — what is it and why is it still such a security problem? (part 1)'
date = 2024-01-22T12:36:52-04:00
tags = ['Security', 'C']
featured_image = "memory.png"
+++

In 2024, [Buffer overflow](https://en.wikipedia.org/wiki/Buffer_overflow) unfortunately still exists. Why it still exists after all these years is probably another topic for another article. Not to be too depressing, there has been wonderful progress in OS and programming language safety since [“Smashing The Stack For Fun And Profit”](http://phrack.org/issues/49/14.html#article) was published in 1996— but there hasn’t been enough progress to completely eradicate it from existence.

In this article, in much the same spirit as [“Smashing The Stack For Fun And Profit”](http://phrack.org/issues/49/14.html#article), I will walk through why the problem exists and how it can be exploited for educational purposes only. Specifically, we will be looking at the [stack-based buffer overflow](https://cwe.mitre.org/data/definitions/121.html). We will be getting down and dirty with C, assembly and GDB. If you don’t want to go that deep but still want to better understand the problem, I recommend this [Computerphile video](https://www.youtube.com/watch?v=1S0aBV-Waeo) on YouTube.

It does require effort and skill to exploit the vulnerability, but do not underestimate a determined attacker. This vulnerability was exploited by [Slammer Worm (2003)](https://en.wikipedia.org/wiki/SQL_Slammer), which was one of the most devastating worms in history.

As a developer, you may be thinking how this might be relevant to you. After all, maybe you code in Python or Java or JavaScript and don’t go anywhere near C/C++. Well, C is never far away. [Python is written in C](https://github.com/python/cpython). So is much of the [Java Virtual Machine](https://github.com/openjdk/jdk/tree/master). Maybe your favorite Python package is also written in C under the covers ([NumPy](https://github.com/numpy/numpy) for example). What about the [V8 JavaScript engine](https://github.com/v8/v8)? C++ (close enough). What about that web server? The database you use? The OS kernel itself? — you get the idea. In other words, either directly or indirectly, it is likely the application you are working on may be vulnerable to buffer overflow at some point.

I find it interesting to dig deep into some of the most common and/or dangerous common weaknesses. My hope is as a developer, you will become more security conscious resulting in safer more resilient software which we can all benefit from.

In no way am I knocking C. I have a fondness for C as it was the language I wrote in (along with C++) for the first decade of my career. However, it is also showing signs of age in it’s 6th decade. I still however, think every CS student should learn it — even if you don’t code in it on a daily basis.

Here’s our intentionally vulnerable C code. The problem is, to the untrained eye it doesn’t look vulnerable. The compiler won’t warn you that this vulnerable code be exploited in a way that could wipe out yours (or somebody else’s business) resulting in millions of dollars worth of damage.

{{< highlight cpp >}}
/_ thestack.c _/
#include <string.h>
void foo(char \*input) {
char buff[10];
strcpy(buff,input);
}
int main(int argc, char \*\*argv) {
foo(argv[1]);
return 0;
}
{{< / highlight >}}

It’s a contrived example, but is vulnerable because we are copying bytes of data that are being passed in as a parameter from outside the program, into a buffer that is only 10 bytes. If the length of the parameter is less than 10 bytes, everything is fine. Things get a little wonky if the input parameter is more than 10 bytes. As an aside, the way to remove this vulnerability is to avoid using strcpy() and instead use strcpy_s() which was published as part of the C11 standard in 2011 (At this point, C was approaching 40 years old). You may argue that another fix is to rewrite it in a safer language such as Rust. Given the amount of C code out there, this is not a quick fix solution. Rust is slowly finding it’s way into the [Linux kernel as of 6.1](https://www.zdnet.com/article/linus-torvalds-rust-will-go-into-linux-6-1/), but 30+ years and approximately 27 million lines of C code are not going away any time soon.

Yes, this is a command line program — and yours may not be. The takeaway, is wherever your program takes input that you don’t control, make sure to check its contents (another problem altogether) and its length. For example, your program maybe taking input data from a web form, a database, a file, a socket. You need to deploy a software bouncer so to speak at every door-way into your program.

Let’s compile and run it a couple of times:

    $ uname -a
    Linux pop-os 6.6.6-76060606-generic #202312111032~1702306143~22.04~d28ffec SMP PREEMPT_DYNAMIC Mon D x86_64 x86_64 x86_64 GNU/Linux
    $ gcc thestack.c -o thestack
    $ ./thestack A
    $ ./thestack `python -c 'print("A"*5)'`
    $ ./thestack `python -c 'print("A"*10)'`
    $ ./thestack `python -c 'print("A"*11)'`
    *** stack smashing detected ***: terminated
    [1]    332716 IOT instruction (core dumped)  ./thestack `python -c 'print("A"*11)'`

It crashes only when we attempt to pass in 11 bytes of data (sneakily generated for us with that little bit of Python). This is the behavior observed running on my Pop!\_OS machine. On a different machine with a different version of the kernel using a different distro (Kali), I get slightly different behavior:

    ┌──(jason㉿kali)-[~/buffer_overflow]
    └─$ uname -a
    Linux kali 6.5.0-kali3-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.6-1kali1 (2023-10-09) x86_64 GNU/Linux

    ┌──(jason㉿kali)-[~/buffer_overflow]
    └─$ gcc thestack.c -o thestack

    ┌──(jason㉿kali)-[~/buffer_overflow]
    └─$ ./thestack A

    ┌──(jason㉿kali)-[~/buffer_overflow]
    └─$ ./thestack `python -c 'print("A"*5)'`

    ┌──(jason㉿kali)-[~/buffer_overflow]
    └─$ ./thestack `python -c 'print("A"*10)'`
    zsh: segmentation fault  ./thestack `python -c 'print("A"*10)'`

Let’s park for now why that might be. Before we dive into gdb and assembler, we need to review how memory is organized.

{{< figure src="memory.png" alt="Figure 1 — how your program is organized in memory" caption="Figure 1 — how your program is organized in memory" >}}

As we can see in Figure 1, when you execute your program the code and data is organized into segments for our process. Our focus here is specifically the [stack-based buffer overflow problem](https://en.wikipedia.org/wiki/Stack_buffer_overflow) so our attention is the stack segment. In our example, we have main() calling foo(). When foo() has completed, control needs to be passed back to the calling function — main() — how does that happen? Well it needs to push things onto the stack so that control can get back to where it came from. There is what is called a stack frame for each call of a function(). Let’s dig into that a little. Let’s study the state of memory just before foo() is called from within main. There are two registers that essentially keep track of the current stack frame — rbp holds the address (in memory) of the “base” of the current frame and rsp holds the address of the top of the stack. At this point, the top of the stack is the “top” of the main() stack frame. You may have to do a little mental gymnastics because the stack grows downward from high to low in the address space— this is to keep it as far as possible from the heap which is growing in the other direction.

{{< figure src="figure2.png" alt="Figure 2- State of memory just before main() calls foo()" caption="Figure 2- State of memory just before main() calls foo()" >}}

However, don’t take my word for it. Let’s inspect the memory by running the program in [gdb](https://en.wikipedia.org/wiki/GNU_Debugger).

First, we need to build it. Notice the options we are passing to the gcc compiler. Basically we are by-passing two security features to enable us to do some naughty things. Recall at the beginning of this article, I mentioned there had been some improvements to mitigate the buffer overflow problem since the publication of the original [“Smashing The Stack For Fun And Profit”](http://phrack.org/issues/49/14.html#article) paper. Real production code should absolutely lean on these default security features — but just to have some fun, we need to turn them off.

    $ gcc -g -z execstack -no-pie -o thestack thestack.c

Launch the debugger, set a breakpoint in main, then execute as follows:

    $ gdb thestack
    (gdb) break main
    (gdb) run "AAA"

You should be at the top of the main() function. Now, within gdb, use the “nexti” command to skip to the next instruction. Disassemble main to reveal the assembly code for the main() function as follows:

    (gdb) disas main
    Dump of assembler code for function main:
       0x0000000000401148 <+0>: push %rbp
       0x0000000000401149 <+1>: mov %rsp,%rbp
       0x000000000040114c <+4>: sub $0x10,%rsp
       0x0000000000401150 <+8>: mov %edi,-0x4(%rbp)
       0x0000000000401153 <+11>: mov %rsi,-0x10(%rbp)
       0x0000000000401157 <+15>: mov -0x10(%rbp),%rax
       0x000000000040115b <+19>: add $0x8,%rax
       0x000000000040115f <+23>: mov (%rax),%rax
       0x0000000000401162 <+26>: mov %rax,%rdi
    => 0x0000000000401165 <+29>: call 0x401126 <foo>
       0x000000000040116a <+34>: mov $0x0,%eax
       0x000000000040116f <+39>: leave
       0x0000000000401170 <+40>: ret
    End of assembler dump.

Keep on using “nexti” until you get to the “call” instruction. The actual addresseses in memory will vary to what you see and also between successive runs.

Now, let’s query the values of the rbp and rsp registers. Using “stepi” step into the foo function and disassemble it. You should be right at the very top of the foo() function. Before we go any further, let’s inspect the rsp register. Notice as we have gone into the foo function, the rsp register has changed meaning that something has been pushed onto the stack.

    (gdb) print $rbp
    $22 = (void *) 0x7fffffffddd0
    (gdb) print $rsp
    $23 = (void *) 0x7fffffffddc0
    (gdb) stepi
    foo (input=0x0) at thestack.c:3
    3 void foo(char *input) {
    (gdb) disas foo
    Dump of assembler code for function foo:
    => 0x0000000000401126 <+0>: push %rbp
       0x0000000000401127 <+1>: mov %rsp,%rbp
       0x000000000040112a <+4>: sub $0x20,%rsp
       0x000000000040112e <+8>: mov %rdi,-0x18(%rbp)
       0x0000000000401132 <+12>: mov -0x18(%rbp),%rdx
       0x0000000000401136 <+16>: lea -0xa(%rbp),%rax
       0x000000000040113a <+20>: mov %rdx,%rsi
       0x000000000040113d <+23>: mov %rax,%rdi
       0x0000000000401140 <+26>: call 0x401030 <strcpy@plt>
       0x0000000000401145 <+31>: nop
       0x0000000000401146 <+32>: leave
       0x0000000000401147 <+33>: ret
    End of assembler dump.
    (gdb) print $rbp
    $24 = (void *) 0x7fffffffddd0
    (gdb) print $rsp
    $25 = (void *) 0x7fffffffddb8 <- The stack pointer has changed - something has been pushed

It’s the call instruction that has pushed something on to the stack. It needs to remember where to return control back to once foo() has finished. This is the instruction in main() immediately after the call instruction.

At this point, our memory looks like this (figure 3):

{{< figure src="figure3.png" alt="Figure 3- State of memory just after main() calls foo()" caption="Figure 3- State of memory just after main() calls foo()" >}}

Let’s inspect the top of the stack to see what it is:

    (gdb) x/1w $rsp
    0x7fffffffddb8: 0x0040116a

Recall that 0x0040116a is indeed the address of the instruction immediately following the call to foo().

{{< figure src="figure4.png" alt="" caption="" >}}

The whole crux of this attack is based on the ability to redirect the control flow to execute some other code instead of getting back to main().

If we could somehow modify that value on the stack to point to some other code e.g. a malicious piece of code, we are in business. Before we figure out how to do that, let’s complete the execution of the foo() function. Recall we have just entered the top of the foo function. Let’s disassemble it:

    (gdb) disas foo
    Dump of assembler code for function foo:
    => 0x0000000000401126 <+0>: push %rbp
       0x0000000000401127 <+1>: mov %rsp,%rbp
       0x000000000040112a <+4>: sub $0x20,%rsp
       0x000000000040112e <+8>: mov %rdi,-0x18(%rbp)
       0x0000000000401132 <+12>: mov -0x18(%rbp),%rdx
       0x0000000000401136 <+16>: lea -0xa(%rbp),%rax
       0x000000000040113a <+20>: mov %rdx,%rsi
       0x000000000040113d <+23>: mov %rax,%rdi
       0x0000000000401140 <+26>: call 0x401030 <strcpy@plt>
       0x0000000000401145 <+31>: nop
       0x0000000000401146 <+32>: leave
       0x0000000000401147 <+33>: ret

The first set of instructions are setting up the stack frame for foo — storing local variable and arguments that were passed into it. Set a breakpoint or stepi into the call to strcpy(). We want to get to the point just before the input bytes are copied into the buffer.

    (gdb) x/80b $rsp
    0x7fffffffdd88: 0x45 0x11 0x40 0x00 0x00 0x00 0x00 0x00
     0x0000000000401145 <- Next instruction once strcpy() has completed
     ____________________________________________________________________
     Stack frame for foo()
    0x7fffffffdd90: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
    0x7fffffffdd98: 0x88 0xe2 0xff 0xff 0xff 0x7f 0x00 0x00
    0x7fffffffdda0: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
    0x7fffffffdda8: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
    0x7fffffffddb0: 0xd0 0xdd 0xff 0xff 0xff 0x7f 0x00 0x00
     ____________________________________________________________________
    0x7fffffffddb8: 0x6a 0x11 0x40 0x00 0x00 0x00 0x00 0x00
     0x000000000040116a <- Next instruction once foo has completed
     ____________________________________________________________________
     Stack frame for main()
    0x7fffffffddc0: 0xe8 0xde 0xff 0xff 0xff 0x7f 0x00 0x00
    0x7fffffffddc8: 0xb0 0xda 0xff 0xf7 0x02 0x00 0x00 0x00
    0x7fffffffddd0: 0x02 0x00 0x00 0x00 0x00 0x00 0x00 0x00

By the way, notice how the bytes are backwards for the return addresses?. Doesn’t this make debugging fun? How memory is stored is CPU dependent. We happen to be running on a little-endian system where the least-significant byte is stored at the lower address and the most-significant byte is stored at a higher-address.

Complete the call to strcpy so we are back in foo() — let’s see how the stack has been changed as a result of copying the input “AAA” into the buffer via strcpy.

    (gdb) x/80b $rsp
                    ____________________________________________________________________
                    Stack frame for foo()
    0x7fffffffdd90: 0x00    0x00    0x00    0x00    0x00    0x00    0x00    0x00
    0x7fffffffdd98: 0x88    0xe2    0xff    0xff    0xff    0x7f    0x00    0x00
    0x7fffffffdda0: 0x00    0x00    0x00    0x00    0x00    0x00  |-0x41----0x41
    0x7fffffffdda8: 0x41----0x00-|  0x00    0x00    0x00    0x00    0x00    0x00
    0x7fffffffddb0: 0xd0    0xdd    0xff    0xff    0xff    0x7f    0x00    0x00
                    ____________________________________________________________________
    0x7fffffffddb8: 0x6a    0x11    0x40    0x00    0x00    0x00    0x00    0x00
                    0x000000000040116a <- Next instruction once foo has completed
                    ____________________________________________________________________
                    Stack frame for main()
    0x7fffffffddc0: 0xe8    0xde    0xff    0xff    0xff    0x7f    0x00    0x00
    0x7fffffffddc8: 0xb0    0xda    0xff    0xf7    0x02    0x00    0x00    0x00
    0x7fffffffddd0: 0x02    0x00    0x00    0x00    0x00    0x00    0x00    0x00
    0x7fffffffddd8: 0xca    0x26    0xdf    0xf7    0xff    0x7f    0x00    0x00

By the way, ‘A’ is 0x41 — we can clearly see where it is being written to in the stack. Everything looks good so far. Our stack has not been corrupted. Control will return back to main() once foo() has completed.

Now, let’s be a little naughty and copy 11 bytes (10 ‘A’s followed by \0 null terminator) into the buffer.

    (gdb) run $(python -c 'print("A"*10)')

Break at the same point in foo() just after the strcpy(). First notice that the stack is at a slightly different location in memory — this is to be expected between runs.

    (gdb) x/80b $rsp
                    ____________________________________________________________________
                    Stack frame for foo()
    0x7fffffffdd80: 0x00    0x00    0x00    0x00    0x00    0x00    0x00    0x00
    0x7fffffffdd88: 0x81    0xe2    0xff    0xff    0xff    0x7f    0x00    0x00
    0x7fffffffdd90: 0x00    0x00    0x00    0x00    0x00    0x00  |-0x41----0x41
    0x7fffffffdd98: 0x41----0x41----0x41----0x41----0x41----0x41----0x41----0x41
    0x7fffffffdda0: 0x00-|  0xdd    0xff    0xff    0xff    0x7f    0x00    0x00
                    ____________________________________________________________________
    0x7fffffffdda8: 0x6a    0x11    0x40    0x00    0x00    0x00    0x00    0x00
                    0x000000000040116a <- Next instruction once foo has completed
                    ____________________________________________________________________
    0x7fffffffddb0: 0xd8    0xde    0xff    0xff    0xff    0x7f    0x00    0x00
    0x7fffffffddb8: 0xb0    0xda    0xff    0xf7    0x02    0x00    0x00    0x00
    0x7fffffffddc0: 0x02    0x00    0x00    0x00    0x00    0x00    0x00    0x00
    0x7fffffffddc8: 0xca    0x26    0xdf    0xf7    0xff    0x7f    0x00    0x00

We have corrupted the stack by 1 byte. But not enough because the return address of the next instruction once foo() has completed is still intact. In this case, we have corrupted the value of the (char \*input) parameter passed to foo().

To corrupt the return address, we need over-write the stack by at least 8 bytes. Let’s try it making sure we break execution immediately after the strcpy call:

    (gdb) run $(python -c 'print("A"*18)')

Ok, now let’s look at the state of our stack corruption:

                    ____________________________________________________________________
                    Stack frame for foo()
    0x7fffffffdd80: 0x00    0x00    0x00    0x00    0x00    0x00    0x00    0x00
    0x7fffffffdd88: 0x79    0xe2    0xff    0xff    0xff    0x7f    0x00    0x00
    0x7fffffffdd90: 0x00    0x00    0x00    0x00    0x00    0x00 |--0x41----0x41
    0x7fffffffdd98: 0x41----0x41----0x41----0x41----0x41----0x41----0x41----0x41
    0x7fffffffdda0: 0x41----0x41----0x41----0x41----0x41----0x41----0x41----0x41
                    ____________________________________________________________________
    0x7fffffffdda8: 0x00-|  0x11    0x40    0x00    0x00    0x00    0x00    0x00
                    0x000000000040116a <- What Next instruction should be once foo has
                                          completed - but it's not!!!
                    ____________________________________________________________________
    0x7fffffffddb0: 0xd8    0xde    0xff    0xff    0xff    0x7f    0x00    0x00
    0x7fffffffddb8: 0xb0    0xda    0xff    0xf7    0x02    0x00    0x00    0x00
    0x7fffffffddc0: 0x02    0x00    0x00    0x00    0x00    0x00    0x00    0x00
    0x7fffffffddc8: 0xca    0x26    0xdf    0xf7    0xff    0x7f    0x00    0x00

So, in this part we have demonstrated how we can corrupt the stack. We’ve shown that a stack frame contains local variables and the values of parameters that have been passed in. Also in the stack, is the address of the next instruction to return to once the call has completed. This is implicitly added as part of the call instruction.

Assuming that we can load malicious code in memory somehow, and we can roughly locate it’s address in memory (we don’t actually need to be exact), we can theoretically corrupt the stack of our vulnerable code so that arbitrary malicious code is executed instead of returning back to main.

Stay tuned for part 2!!
