+++
title = 'Re-creating One Of The Greatest Games Ever.. From Scratch'
date = 2024-05-10T09:00:00-04:00
featured_image = "first_npc.png"
tags = ['Gaming', 'Python']
+++

After getting swept up in the great tech layoff of '23 and '24, I found myself with time on my hands. With no teams to lead, reports to write, plans to create, meetings to attend, and politics to navigate, I quickly snapped back to my default self. That is full on nerd, or as my mum used to say when I would spend hours hacking my little Sinclair ZX Spectrum, "He's playing on the computer".

I've always been hacking and cooking stuff on the side, even as I ventured into the world of management fifteen years ago. I felt staying technical kept me connected with my teams enabling me to better lead, serve and guide them. Now, with this time on my hands, where might my curiosity lead me? One of the projects I had conceived a while ago, was to attempt to re-create what was arguably one of the greatest games of all time. Just for fun. The game I am referring to, is [Wolfenstein 3D](https://en.wikipedia.org/wiki/Wolfenstein_3D).

The genius of [John Carmack](https://en.wikipedia.org/wiki/John_Carmack) and the creative force of [John Romero](https://en.wikipedia.org/wiki/John_Romero) is the stuff of legend. If you are interested in learning more about their story, may I recommend David Kushner's 2004 book, [Masters of Doom](https://www.amazon.com/Masters-Doom-Created-Transformed-Culture/dp/0812972155).

Of course, re-creating Wolfenstein 3D today is much easier using modern fast capable hardware with lots of memory, amazing frameworks, libraries and techniques at hand. Being slightly lazy, I didn't really want to create it exactly from scratch. I stumbled across this great [YouTube tutorial](https://www.youtube.com/watch?v=ECqUrT7IdqQ) which I followed - it's kind of like a paint by numbers.

## Step 1 - Ray Casting

Once the world has been defined, a key capability to implement is "Ray Casting".

This can be seen (temporarily) as the yellow area. The dot represents the person and in the words of Wikipedia "virtual light rays are "cast" or "traced" on their path from the focal point of a camera through each pixel in the camera sensor to determine what is visible along the ray in the 3D scene." In other words, the yellow represents what the player can see from their current position.

The squares represent the walls in the scene. Obviously, the person cannot see through walls.

{{< figure src="ray_casting.png" alt="" caption="" >}}

This is essentially a very clever optimization technique because it reduces significantly the number of objects that need to be considered for rendering to the screen, to purely what is visible from the perspective of the player.

## Step 2 - Shift to 3D

Now moving from a top-down 2D map to a 3D projection of the space. No texture yet. But, hopefully you can see how the game is starting to take shape.

{{< figure src="3d_projection.png" alt="" caption="" >}}

## Step 3 - Introduce depth

Although we are now immersed into a 3D world, we are missing depth. Let's add it.

{{< figure src="depth.png" alt="" caption="" >}}

Here we can get a sense of what is close and what is further away.

## Step 4 - Add some texture

The walls look a little bleak at this point. We need to add some interesting texture so they do at least resemble something akin to a wall.

{{< figure src="texture.png" alt="" caption="" >}}

## Step 5 - More texture please

The walls are pretty boring even though they have texture. Let's add a range of textures.

{{< figure src="texture2.png" alt="" caption="" >}}

## Step 6 - Say hello to my little friend

Our nazi killing hero needs a gun. Let's give him one. Also, let's lighten up the sky.

{{< figure src="gunsprite_and_sky.png" alt="" caption="" >}}

## Step 7 - Add the enemy

Our nazi killing hero needs an adversary otherwise what's the point? In gaming, this is called an NPC - or a non-player character. Also, let's add some killer sound effects (obviously, you will have to use your imagination here).

{{< figure src="first_npc.png" alt="" caption="" >}}

## Step 8 - Finish off

That is as far as I got to be honest. One day, I will complete it. Maybe. You can find the code repo on my [GitHub](https://github.com/jasondchambers/wolfenstein3d_clone).
