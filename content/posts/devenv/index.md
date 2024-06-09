+++
title = 'How I Engineered My Personalized Development Environment And How You Can Too'
date = 2024-06-08T07:00:00-04:00
featured_image = "pde.png"
+++

_(Note: the code snippets do not look great in this article. I'm publishing for now because I want to get the content out. I plan to adjust the styling later)_

In Figure 1 below, you will see a photo of a "mobile" thin-client version of my personalized development environment. Look closely. You will see it is running on an iPad. I have found the iPad to be pretty good for on-the-go development because a) it is light b) has long battery life c) has a great screen d) is cheaper than a typical developer-spec laptop and e) there are no secrets or code are stored locally presenting less of a security headache if the device is lost or stolen.

Look even more closely. There are no compromises made (I do however leave my beloved, big and heavy [Unicomp New Model M keyboard](https://www.pckeyboard.com/page/product/NEW_M) behind). You will see I'm running my preferred toolset including [tmux](https://github.com/tmux/tmux/wiki), [Neovim](https://neovim.io) and [zsh](https://www.zsh.org) tripped out with [starship](https://starship.rs). The [colors](https://catppuccin.com) look beautiful. The [fonts](https://www.nerdfonts.com) are pleasing to the eye. In a thin-client model, the bulk of the heavy lifting is done on a server somewhere - tmux isn't really running native on my iPad.

{{< figure src="ipad_tmux_neovim.png" caption="Figure 1 — Neovim and tmux.. On an iPad.. What in the world?" >}}

In this particular scenario, I'm developing my blog using [Hugo](https://gohugo.io). I therefore need to be able to securely see the results of my code changes in a browser on the client. In Figure 2 below, you will see that this indeed possible:

{{< figure src="ipad_testing.png" caption="Figure 2 — Accessing remote ports safely - how?" >}}

Although not obvious from the photo, this development environment workspace was automatically provisioned from a template in a matter of minutes customized with my own dot-files. It is also trivial to share the template with my team (ok, I'm currently a team of one - but you get the idea). How is this even possible?

In contrast, here is my "static" thick-client version of my personalized development environment. I develop on both Linux and Mac. Can you tell the difference? Notice how consistent the developer experience is across all devices. This level of consistency I have found reduces friction and enables me to be more productive whether I'm working at home on either Linux or Mac, or on the move using my iPad.

{{< figure src="pde.png" caption="Figure 2 — Linux and Mac - but they look the same?" >}}

In this article, I will share the process and the tools I used to achieve this outcome.

**Spoiler alert**: I am using [Coder](https://coder.com) self hosted on my own server in my home lab. I am using [Twingate](https://www.twingate.com) to provide secure access back to home lab for when I travel. I'm using [blink.sh](https://blink.sh) on the iPad as my terminal emulator + SSH client.

## Crafting The Development Environment

This is the slowest stage. The best tools are the ones you are most productive with. If you have been stuck using the same tools for the past few years, you may be missing out. There are some incredible tools available whether you prefer an off-the-shelf IDE such as VS Code or IntelliJ, or prefer something like Emacs, Neovim or Zed.

When I was working at Cisco as a Director of Engineering, I didn't really have the time to craft my own decent development environment and found VS Code (with Vim Motions of course) fit perfectly my casual needs. However, while being on sabbatical I've had the luxury of time to invest in crafting my own personalized development environment that fits me like a glove.

These video courses from typecraft provided me with the motivation to get started: [Neovim for Newbs](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn) and [Tmux for Newbs](https://www.youtube.com/playlist?list=PLsz00TDipIfdrJDjpULKY7mQlIFi4HjdR). In addition, I also found inspiration from [this](https://www.youtube.com/watch?v=uOnL4fEnldA&t=765s) video by Josean Martinez.

Now might be a good time for you to learn a little about [Coder](https://coder.com). The best way I think is to watch [@typecraft_dev's](https://x.com/typecraft_dev) wonderful [YouTube video](https://www.youtube.com/watch?v=F9sQPpVVLeQ&t=578s).

Once you have crafted what works for you, take note of what you installed and how you installed them. You will need this information to build a template using [Coder](https://coder.com). If you are working as part of a team, it is important to enable each developer to have control over their personalized development environment. What works for you may not work for everyone else. Find out what is common across the entire team in terms of tools, and automate that in such a way that you leave the door open for them to individually customize to their unique needs. 80% automation is better than 0% automation. However, for my team of just me, myself and I, a template that fully automates 100% of the development environment is what I need.

## Automate

To fully automate the provisioning of my development environment requires the use of Docker, Terraform and Ansible. Coder has lots of starter templates available. I found the Docker template meets my needs. There are other ways supported by Coder so find the way that works for you. It helps to know a little bit about Docker, but it's not essential. I also needed to tweak the Terraform script provided by the template. I hadn't used Terraform before but it was pretty straightforward to inject my own custom code within the template. I chose Ansible as the final step to apply the finishing touches to my development environment. You should expect this stage to be highly iterative. You will most likely not get to your perfect template in one pass. I went through many iterations to finally get to my completed template.

In Figure 3, you can see the various packages that form the ingredients of my development environment. There is some unavoidable complexity here. It would be wonderful if there was a single package manager to rule them all. Maybe one day there [could be](https://wasi.dev) but not today.

{{< figure src="packages.png" caption="Figure 3 - The packages that form the ingredients of my development environment" >}}

### Docker

It all begins with building a solid base. Using Docker, I use a base image from Ubunutu. Use whatever base image works for you. The smaller the better to reduce the maintenance burden of vulnerability management. The only changes I made to the starter template was to add the apt packages I needed and remove the ones I don't need. I don't explicitly need all of these packages, but implicitly I do. For example, build-essential is required by my Neovim LSP configuration ([GNU Make](https://www.gnu.org/software/make/) specifically). I also rely on [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to manage the dot-files. Finally, [pipx](https://pipx.pypa.io/stable/) is needed so that I can install Ansible. The other packages should be fairly self-explanatory.

For reference, here is my Dockerfile:

```docker {linenos=table,linenostart=1}
FROM ubuntu

RUN apt-get update \
 && apt-get install -y \
 build-essential \
 curl \
 git \
 sudo \
 neovim \
 zsh \
 wget \
 stow \
 pipx \
 && rm -rf /var/lib/apt/lists/\*

ARG USER=coder
RUN useradd --groups sudo --no-create-home --shell /usr/bin/zsh ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}
```

### Terraform

Once a Docker container has been created, Terraform is used to further customize it. Much of the Terraform script in the template can be safely ignored and left in-tact. I just need to make a few additions which are highlighted in lines 13-36 from this snippet of the main.tf file.

It should be fairly self-explanatory what is going on here:

```tf {linenos=table,hl_lines=["13-36"],linenostart=1}
resource "coder_agent" "main" {
  arch           = data.coder_provisioner.me.arch
  os             = "linux"
  startup_script = <<-EOT
    set -e

    # Prepare user home with default files on first start.
    if [ ! -f ~/.init_done ]; then
      cp -rT /etc/skel ~
      touch ~/.init_done
    fi

    ####### START JASONS HACKS

    # Install dot-files
    coder dotfiles -y "https://github.com/jasondchambers/dot-files"
    # Install ansible
    pipx install ansible-core

    # Install TPM for tmux if necessary
    if [ ! -d ~/.tmux/plugins/tpm ]; then
      git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm/
    fi

    # Install mydevenv if necessary
    if [ ! -d ~/mydevenv ]; then
      git clone https://github.com/jasondchambers/mydevenv.git
    fi

    # Run the Ansible playbook

    source ~/.zshrc
    ansible-galaxy collection install community.general
    ansible-playbook -vvv --connection=local --inventory 127.0.0.1, mydevenv/playbook.yml

    ###### END JASONS HACKS

    # install and start code-server
    curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/tmp/code-server --version 4.19.1
    /tmp/code-server/bin/code-server --auth none --port 13337 >/tmp/code-server.log 2>&1 &
  EOT
```

The final step (line 34) is where I run my Ansible playbook.

### Ansible

Here is my Ansible playbook. It's the final stage of provisioning. What I like about using Ansible (versus a hand-coded shell script) is the declarative nature of it. I also like the idempotent property of the playbook which means I can run it over and over again and skips tasks that have previously been performed.

```yaml {linenos=table,linenostart=1}
# ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml
- name: Complete provisioning of my development environment
  hosts: 127.0.0.1
  tasks:
    - name: Install nvm
      shell: >
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        creates=/home/{{ ansible_user_id }}/.nvm/nvm.sh

    - name: Install node
      shell: >
        /bin/bash -c "source ~/.nvm/nvm.sh && nvm install node"
        creates=/home/{{ ansible_user_id }}/.nvm/alias

    - name: Install Homebrew
      shell: >
        /bin/bash -c "export NONINTERACTIVE=1; $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        creates=/home/linuxbrew/.linuxbrew/

    - name: Configure .zshrc for Homebrew
      shell: >
        /bin/bash -c "(echo 'eval \"$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"') >> $HOME/.zshrc; touch $HOME/.homebrew.configured"
        creates=/home/{{ ansible_user_id }}/.homebrew.configured

    - name: Install packages using Homebrew
      community.general.homebrew:
        name:
          - tmux
          - fzf
          - starship
          - hugo

    - name: Configure .zshrc for Starship.rs
      shell: >
        /bin/bash -c "echo 'eval \"\$(starship init zsh)\"' >> ~/.zshrc; touch $HOME/.starship.configured"
        creates=/home/{{ ansible_user_id }}/.starship.configured

    - name: Configure .zshrc for fzf
      shell: >
        /bin/bash -c "echo 'source <(fzf --zsh)' >> ~/.zshrc; touch $HOME/.fzf.configured"
        creates=/home/{{ ansible_user_id }}/.fzf.configured

    - name: Load tmux TPM plugins automatically
      shell: >
        /usr/bin/zsh -c "source ~/.zshrc && ~/.tmux/plugins/tpm/bin/install_plugins"
```

## Building a Workspace

Now that we have a template, we can create a workspace from it as follows:

{{< figure src="s1.png" caption="" >}}

{{< figure src="s2.png" caption="" >}}

Watch the wheels turn:

{{< figure src="s3.png" caption="" >}}

It doesn't take long to create the workspace. Now, let's connect to it using the browser-based terminal by clicking on the "Terminal" button:

{{< figure src="s4.png" caption="" >}}

Here it is. It mostly looks pretty great but notice the fonts don't look quite right. The browser based terminal can work for you in a pinch, but I prefer to use a decent native terminal emulator.

{{< figure src="s5.png" caption="" >}}

For the iPad, I use [blink.sh](https://blink.sh). For Linux and Mac, I use [Alacritty](https://alacritty.org). In the screenshot below, I'm using [iTerm2](https://iterm2.com) on the Mac. You will also need to install the [Coder client](https://coder.com/docs/install) to enable you to SSH into your workspace. This is not available on the iPad, so the way I get around that is to "jump" via SSH onto another machine on my network that does have the Coder client installed. Notice that I need to quickly configure the SSH client before I can SSH into my workspace:

{{< figure src="s6.png" caption="" >}}

Everything looks great. Let's run tmux Neovim to make sure they are fully configured:

{{< figure src="s7.png" caption="" >}}

## Using the Workspace

The only thing missing are clones of my repos so that I can get to work. Before I can clone the repos, an SSH key needs to be generated and registered in my GitHub profile. Fortunately, I have a script that does that. Here it is:

```shell {linenos=table,linenostart=1}
#!/usr/bin/env bash

create_sshkey() {
    if [ ! -f ~/.ssh/id_ed25519.pub ]; then
        echo "SSH Keypair does not exist - let's create one"
        echo "Please enter your email address: "
        read -r EMAIL_ADDRESS
        ssh-keygen -t ed25519 -C "${EMAIL_ADDRESS}"
    fi
}

ensure_sshkey_is_registered_with_github() {
    echo "Add the SSH key in GitHub: "
    cat ~/.ssh/id_ed25519.pub
    echo "Press enter to confirm: "
    read -r x
}

create_sshkey
ensure_sshkey_is_registered_with_github
ansible-playbook --connection=local --inventory 127.0.0.1, playbook-clone-repos.yml
```

Let's run it:

{{< figure src="s9.png" caption="" >}}

Now register the SSH public key for my new workspace in GitHub:

{{< figure src="s10.png" caption="" >}}

Come back to the terminal and press return to run the Ansible playbook that clones all my repos:

{{< figure src="s11.png" caption="" >}}

Now, let's run the Hugo server:

{{< figure src="s12.png" caption="" >}}

And access it securely by clicking on the link within Coder:

{{< figure src="s13.png" caption="" >}}

See my changes in a browser on my client.

{{< figure src="s14.png" caption="" >}}

## Thick or Thin Client?

I'm very pleased with my automated development environment powered by [Coder](https://coder.com). The Thin Client model is perfect for when I am traveling if I want to do some development. I self-host Coder on my own server in my home lab. Of course, this presents an access challenge as my home lab is tucked neatly and safely behind the firewall. I solved this challenge using [Twingate](https://www.twingate.com). Even when I'm at home, I may still use the Thin Client model for quick experiments because it provides isolation from other workspaces enabling me to test upgrades or different operating systems without the risk of breaking anything.

The Thin Client model is arguably much more secure in the event of a lost or stolen laptop. With a Thick Client model, the entire source code plus probably secrets in the form of SSH keys become theoretically accessible to the thief. Of course, this threat can be mitigated using full-disk encryption, but still a stolen or lost laptop can create a headache for the security team.

The Thin Client model, when powered by [Coder](https://coder.com) does make it very easy to accelerate new team member on-boarding significantly. While at Cisco, I had to scale my Engineering Organization very quickly using contractors. I could have used something like [Coder](https://coder.com) in this situation. It also makes it easy to support a BYOD policy.

The Thick Client however, does provide some benefits. For example, If I want to do some graphics programming or if I want to directly access the hardware (i.e. my NVidia GPU) that is not available on my development server.

I also use a Neovim plugin called [Markdown Preview](https://github.com/iamcco/markdown-preview.nvim) to enable me to preview in the browser while working on Markdown files. This doesn't work at the moment. There may be a way to securely open a remote browser on the client, but I'm ok without it for now (and no, running a remote X11 server is probably not a good idea).
