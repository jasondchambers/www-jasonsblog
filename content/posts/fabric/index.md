+++
title = 'Better Gen AI Results with Fabric'
date = 2024-05-30T10:00:00-04:00
featured_image = "fabric-logo-gif.gif"
tags = ['AI']
draft = true
+++

Recently I've been experimenting with [fabric](https://github.com/danielmiessler/fabric) to get more valuable responses from my Private AI server (powered by Llama3). Fabric provides a powerful collection of pre-built prompts called patterns that are optimized for a specific use case.

It works with OpenAI of course (bring your own API key), but more importantly for me, it works with my [Private AI server running Ollama](https://circleinaspiral.com/posts/privateai/). I did have to open up my Ollama port on the network (it was currently setup for local connections only) so I could run fabir on a different machine.

Let's walk through an example. Let's say I've stumbled across a BBC article and I want to "extract_wisdom" from it. Here's the article:

{{< figure src="bbc_article.png" alt="" caption="" >}}

    $ fabric --listmodels --remoteOllamaServer thelio.local
    /Users/jasonchambers/.local/pipx/venvs/fabric/lib/python3.12/site-packages/pydub/utils.py:170: RuntimeWarning: Couldn't find ffmpeg or avconv - defaulting to ffmpeg, but may not work
      warn("Couldn't find ffmpeg or avconv - defaulting to ffmpeg, but may not work", RuntimeWarning)
    GPT Models:

    Local Models:
    llama3:latest

    Claude Models:

    Google Models:



    $ pbpaste | fabric --remoteOllamaServer thelio.local --model llama3:latest -sp extract_wisdom

I'm going to use fabric on the command line, so I simply highlight and copy the body of text from the article into the copy/paste buffer.

{{< figure src="fabric_session.png" alt="" caption="" >}}
