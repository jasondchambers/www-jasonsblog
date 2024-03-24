+++
title = 'How My Career in Tech Started— Part 1'
date = 2024-02-16T12:36:52-04:00
featured_image = "strelley.png"
+++

{{< figure src="strelley.png" alt="Strelley Hall — my first place of work (photo sourced from Flickr)" caption="Strelley Hall — my first place of work (photo sourced from Flickr)" link="https://www.flickr.com/photos/veggiesosage/51137631217/in/photolist-2kURJ9R-2mrKK1v-DtXjCH-2oHjMYE-2nbWJhx-2p2Zx5i-GUPX6Y-R5AsLU-QyK7ed-2nc2UmE-2nc4kZu-2cYqdK7-H1cdA7-2h91VbL-K9HqLM-7uNQQs-2mrFJjp-2mrQw8f-2mrQw4h-DS1JRs-7uNRnJ-2i9ZD87-8XBGXY-JkmypY-2nc5MBv-2nc4kYh-DUqti3-2nbWJi4-2nc2Upa-2nbWJiK-2nbWJjg-2nc3i52-2nc4kXv-2nc2UmV-2nc3i6p-2nbWJkt-2nbWJmv-2nc3i5Y-2nc4kZE-2nbWJkD-QBvohe-7GnbhN-dVyM3b-e7zn6u-9RucLZ-dVyEL7-dVyM1f-dVyLZ1-K2XqVh-9sfJTT" >}}

The year was 1989. I was a nerdy awkward teenager about to enter the workforce. My mum found the advert in the jobs section of the Nottingham Evening Post. She was always very supportive in my interest towards computers since she bought my first computer [¹] a few years earlier. She had also seen that any job involving computers tended to be well-paid. This particular job was for a “Digitizer” at a company named PAFEC. I had no idea what that was and had never heard of the company. My mum pointed out that this was a good opportunity to work at a software company.

I looked at the job advert. I instantly dismissed it because the minimum age was 18. I was 17 years, 11 months precisely. My mum said something along the lines of “don’t be daft, you’ll be 18 next month”. I looked at the salary — £5,000 pa. Hmm — I might be able to buy a better motorbike with that money, I thought to myself. After a short futile resistance, I decided to apply expecting to be rejected due to not quite meeting the age limit. To my surprise, I got the job. I was to start on Monday June 26th, 1989. I guess, the first lesson is — listen to your parents. They might be right and you might be wrong.

The department I worked in was the digitizing bureau. Many engineering workshops were moving towards CAD yet needed a way to get their existing drawings, plans, schematics, maps etc. into digital form. They could choose the most expensive option, which was to digitize manually into a vector format so that it could be accessible by their CAD system of choice. That was my first job and involved using a digitizer to manually trace each line, arc, circle and piece of text to slowly re-create a CAD file. A cheaper option, which was much less labor intensive involved scanning the document using a fast, large format scanner to produce a raster file.

The service bureau was a side business to the core business of PAFEC, which was primarily in the business of developing and selling software. In fact, we ate our own dog food using our own software in the bureau. We used [DOGS](https://www.youtube.com/watch?v=w8V3zoQsPB8) for the CAD system (before AutoDesk dominated) and RAVEN for scanning and cleanup. I loved that PAFEC named most of their software after animals. Here are some examples I can remember:

- DOGS — Drawing Office Graphics System
- RAVEN — RAster and VEctorizatioN
- SWANS — Surfaces With A Nice Shape

We used DOGS on [Apollo](https://en.wikipedia.org/wiki/Apollo_Computer) workstations using an interesting operating system called [Domain/OS](https://en.wikipedia.org/wiki/Domain/OS). The workstation, as I recall looked something like this:

{{< figure src="apollo.png" alt="An Apollo workstation" caption="An Apollo workstation" link="https://medium.com/asecuritysite-when-bob-met-alice/the-rise-and-fall-of-sun-and-apollo-and-for-uuid-meet-ulid-6b1e97a4ee64" >}}

This was also my first exposure to networking. In fact, all the workstations were networked together using a [Token Ring](https://en.wikipedia.org/wiki/Token_Ring) topology. I had only used PCs and my ZX Spectrum up until this point — these computers were like grown-up adult computers. Since they looked like PCs, I turned mine off at the end of the first day. I didn’t realize that the next day when I turned up for my shift, I had somehow brought the network down as a result of me powering down the workstation. Who knew? I didn’t. Anyway, I got pretty efficient at using all the features of that particular operating system and most importantly, I learned to not turn off the workstation and crash the network.

There was an elegance to the workstation experience as I recall. Like most good tools, they become an extension of the person using it to the degree that the tool kind of disappears. Some of that elegance lives on today in the form of the world-wide web. The URI syntax design was directly influenced by the Apollo Domain System [²].

The manual digitizing was tedious, dull work without much room for growth. We were all typically aged between 18 and 21. The eldest was 27 and we called him “Old man Tim”. It basically felt like a youth club — albeit a profitable one. At the height we were literally working around the clock across three shifts. Oh, and by the way, our office cubicles were stables. I’m not kidding — they were converted stables. It has since been converted into a charming cafe. You can clearly still see the stables in the photos. It was a wonderful start to my career and I wouldn’t have had it any other way.

I took an opportunity to shift over to the scanning side of the business. The scanning part of the bureau was not in the stables, but a short walk across the way to the “Cow Shed”. I should point out that the PAFEC offices were situated in beautiful [Strelley Hall](https://www.strelley.com/), a Grade II Listed Building situated in Nottinghamshire.

Immediately, in my new role I found there was much to learn. My workstation was completely different to the Apollo workstations I had become very familiar with. Under the desk was something that looked like this:

{{< figure src="sun360.png" alt="Sun 3/160" caption="Sun 3/160" link="https://kb.pocnet.net/wiki/Datei:Sun3_160.jpg" >}}

It wasn’t a standard off the shelf workstation. It was equipped with a very expensive Primagraphics graphics card powerful enough that it could handle uncompressed data coming in from the large-format scanner.

It also ran a completely unfamiliar operating system. It was called Sun/OS which apparently was a type of UNIX — this meant nothing to my under-developed 19 year old brain. I was however, very curious. Most of the time was spent in the comfort of RAVEN’s GUI. However, there were times I had to use the command line. The first command I was invited to type and enter was as follows (it’s weird that I still to this day remember this):

    $ tar cvf /dev/rst0 *

What planet is this? I thought to myself. The Domain/OS of the Apollo workstation had a learning curve, but this immediately felt like a learning cliff. To those unfamiliar, what this command is doing is basically backing up files to tape. I guess just in case the “Cow Shed” went to shit, at least the files would be safe.

I quickly figured out the shell and learned how to navigate around the file system, run backups and so on.

Things were going great. Then the UK hit a recession in 1990. PAFEC had some layoffs. This presented another opportunity for me. Stay tuned for the next thrilling chapter of whatever this is.

<p style='text-align: center;'>. . .</p>

*[1]: - My first computer was a Sinclair ZX Spectrum. https://en.wikipedia.org/wiki/ZX_Spectrum*

*[2]: - Tim Berners-Lee FAQ https://www.w3.org/People/Berners-Lee/FAQ.html*
