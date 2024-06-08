+++
title = 'How I Engineered My Personalized Development Environment And How You Can Too'
date = 2024-06-08T07:00:00-04:00
featured_image = "pde.png"
+++

In Figure 1 below, you will see a photo of a "mobile" thin-client version of my personalized development environment. Look closely. You will see it is running on an iPad. I have found the iPad to be pretty good for on-the-go development because a) it is light b) has long battery life c) has a great screen d) is cheaper than a typical developer-spec laptop and e) there are no secrets or code are stored locally presenting less of a security headache if the device is lost or stolen.

Look even more closely. There are no compromizes made (I do however leave my beloved, big and heavy [Unicomp New Model M keyboard](https://www.pckeyboard.com/page/product/NEW_M) behind). You will see I'm running my preferred toolset including [tmux](https://github.com/tmux/tmux/wiki), [Neovim](https://neovim.io) and [zsh](https://www.zsh.org) tripped out with [starship](https://starship.rs). The [colors](https://catppuccin.com) look beautiful. The [fonts](https://www.nerdfonts.com) are pleasing to the eye.

{{< figure src="ipad_tmux_neovim.png" caption="Figure 1 — Neovim and tmux.. On an iPad.. What in the world?" >}}

In this particular scenario, I'm developing my blog using [Hugo](https://gohugo.io). I therefore need to be able to see the results of my code changes in a browser on the client. In Figure 2 below, you will see that this indeed possible:

{{< figure src="ipad_testing.png" caption="Figure 2 — Accessing remote ports safely - how?" >}}

Although not obvious from the photo, this development environment workspace was automatically provisioned from a template in a matter of minutes customized with my own dot-files. It is also trivial to share the template with my team (ok, I'm currently a team of one - but you get the idea). How is this even possible?

In contrast, here is my "static" thick-client version of my personalized development environment. I develop on both Linux and Mac. Can you tell the difference? Notice how consistent the developer experience across all devices. This level of consistency I have found reduces the friction and enables me to be more productive whether I'm working at home on either Linux or Mac, or on the move using my iPad.

{{< figure src="pde.png" caption="Figure 1 — Linux and Mac - but they look the same?" >}}

In this article, I will share the process and the tools I used to achieve this outcome.

**Spoiler alert**: I am using [coder.com](https://coder.com) self hosted on my own server in my home lab. I am using [Twingate](https://www.twingate.com) to provide secure access back to home lab for when I travel. I'm using [blink.sh](https://blink.sh) on the iPad as my terminal emulator + SSH client.

### Stage 1 - Crafting The Development Environment

This is the slowest stage. The best tools are the ones you are most productive with. If you have been stuck using the same tools for the past few years, you may be missing out. There are some incredible tools available whether you prefer an off-the-shelf IDE such as VS Code or IntelliJ, or prefer something like Emacs, Neovim or Zed.

When I was working at Cisco as a Director of Engineering, I didn't really have an abundance of time to craft my own decent development environment and found VS Code (with VIM motions of course) fit perfectly my casual needs. However, while being on sabbatical I've had the luxury of time to invest in crafting my own personalized development environment that fits me like a glove.

These video courses from typecraft provided me with the motivation to get started: [Neovim for Newbs](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn) and [Tmux for Newbs](https://www.youtube.com/playlist?list=PLsz00TDipIfdrJDjpULKY7mQlIFi4HjdR). In addition, I also found inspiration from [this](https://www.youtube.com/watch?v=uOnL4fEnldA&t=765s) video by Josean Martinez.

Once you have crafted what works for you, take note of what you installed and how you installed them. You will need this information to build a template using coder.com. If you are working as part of a team, it is important to enable each developer to have control over there personalized development environment. Find out what is common across the entire team in terms of tools, and automate that in such a way that you leave the door open for them to individually customize to their unique needs. 80% automation is better than 0% automation. However, for my team of one of just me, myself and I, a template that fully automates 100% of the development environment is what I need.

Now might be a good time for you to learn more about coder.com. The best way I think is to watch [@typecraft_dev's](https://x.com/typecraft_dev) wonderful [YouTube video](https://www.youtube.com/watch?v=F9sQPpVVLeQ&t=578s).

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

jlsdjflsjdfljs

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

jlsdjflsjdfljs

```bash {linenos=table,linenostart=1}
#!/usr/bin/env bash

echo "Running install.sh"
stow --verbose=1 --target=$HOME `ls -1 | grep -v "\."`
```

jlsdjflsjdfljs

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

jlsdjflsjdfljs

```yaml {linenos=table,linenostart=1}
# ansible-playbook --connection=local --inventory 127.0.0.1, playbook-clone-repos.yml
# You need an SSH key first - once created, add the .pub key to GitHub
# ssh-keygen -t ed25519 -C "your_email"
- name: Clone all my repos
  hosts: 127.0.0.1
  tasks:
    - name: www-jasonsblog
      git:
        repo: git@github.com:jasondchambers/www-jasonsblog.git
        accept_newhostkey: true
        dest: ~/repos/www-jasonsblog
    - name: www-art
      git:
        repo: git@github.com:jasondchambers/www-art.git
        accept_newhostkey: true
        dest: ~/repos/www-art
    - name: www-house
      git:
        repo: git@github.com:jasondchambers/www-house.git
        accept_newhostkey: true
        dest: ~/repos/www-house
    - name: myresume
      git:
        repo: git@github.com:jasondchambers/myresume.git
        accept_newhostkey: true
        dest: ~/repos/myresume
    - name: wakeupmachine
      git:
        repo: git@github.com:jasondchambers/wakeupmachine.git
        accept_newhostkey: true
        dest: ~/repos/wakeupmachine
    - name: deploytool
      git:
        repo: git@github.com:jasondchambers/deploytool.git
        accept_newhostkey: true
        dest: ~/repos/deploytool
```

jlsdjflsjdfljs

```bash {linenos=table,linenostart=1}
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
