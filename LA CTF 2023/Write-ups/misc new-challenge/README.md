# misc/new-challenge

Starting off, we're given a Git clone command, which can be used to clone a repository from a Git server hosted by LA CTF. Cloning this repository gives us 5 files:
- `Dockerfile`
- `challenge.yml`
- `pre-receive`
- `sshd_config`
- `start.sh`

From the `Dockerfile`, a file used to create a Docker container from a preset image, we can see that this Dockerfile is for a Git server, as it originates from `jkarlos/git-server-docker`. We can look up this Docker image, and see it is a popular image used for creating a Git server. Because of its popularity, it is unlikely that there is a security vulnerability somewhere in the server implementation itself. 

To connect the dots, the Git server we're given in our clone command is likely being hosted by this docker image, probably using the other files that we're in the cloned repository.

There is also a script named `pre-receive`. By looking at the contents of the script, and by looking up the file name we found that this script is likely run on the Git server, whenever someone tries pushing to the repository. Looking deeper at this script, we can see that it is used to only allow commits from certain authors, the challenge writers. It also checks if one of the committers is Benson Liu, or @bliutech as they were mentioned in the challenge description.

We can see that the flag is printed whenever bliutech is one of the authors, so the idea is to make a commit pretending to be bliutech, then push that commit to the Git server, to hopefully capture the flag. 

## Secure Hell

The issue with the script, is that it assumes that the author of the commits is genuinly the author. However, Git is set up so that you can make commits under any name and email address you want, because it does not verify these: this is outside the scope of Git, as it is decentralized, it does not have a central server that could be used for people to register their Git username and email addresses.

To make this script secure, it could've made use of commit signing, Git's mechanism to verify the integrity of commits. The script could have required that the commits were signed by the list of challenge writer, by adding their public keys to the server. These public keys can then be used by Git and GPG to check whether the commits actually originate from one of the trusted challenge writers.

Another option is to require connections to the Git server to be authenticated. The Git server image that was used in this challenge, `jkarlosb/git-server-docker`, has functionality for this too. However, the SSH authentication was explicitly disabled in the Git server of this challenge. This authentication requires that anyone connecting to the Git server, such as pushing to it, was given access to the Git server via a SSH public key.

## Love the Window

Let's continue attacking the server.
The machine we tried this on was running Windows, and it already had Git configured on it. Therefore, to override the author name and email, which were used in the script to check for the right author, we used the `--author` tag of `git commit`, with the command `git commit -m "AAAAA" --allow-empty --author "Benson Liu <bensonhliu@lac.tf>"`. However, when trying to push to the remote, the command got stuck on pushing the repository, and no flag was printed.

In an attempt to resolve this, we tried removing the GPG signature from the commit using `--no-gpg-sign` (as GPG was enabled by default on the machine). This was done because we suspected that the Git server might fail on checking the GPG key, but this approach did not help.

At this point we were unsure what to do, as we expected this to work. We gave up for now, and started working on other challenges.

## Penguin comes in clutch

The next day, we decided to give it another shot. To allow as little possibility of errors, we started a new Linux environment with Docker, and installed Git on there. We cloned the repository, set our global username and email to that of bliutech, and made a commit. This time, using `git push` did give us the flag: `lactf{wh3n_th3_1mp0st3r_1s_5us}`.

After the CTF was over, we looked back at this challenge, and tried to find why our initial attempt on Windows did not work. To find out, we tried an approach where we have two system with the same Git setup: author name and email set up to a different user (not bliutech), and GPG set up to automatically sign commits. The only difference between the two systems, was that one was running Linux and the other Windows. We then ran the commands:
- `git clone git://lac.tf:31152/new-challenge.git`, cloning the repository
- `cd new-challenge`, going into the repository
- `git commit --allow-empty -m "Hey" --author "Benson Liu <bensonhliu@lac.tf>"` making a commit in bliutech's name
- `git push` pushing the commit to the remote Git server

This caused the exact same issue as we had during the CTF: the Linux environment was able to push to the remote, extracting the flag, while the Windows environment appeared to get stuck pushing the commit to the repository. We tried to get Windows to push to the remote in multiple ways, but to no avail.

## Reflection

We should have tried to run this on a clean environment when we saw it wasn't working on our poluted Windows environment. Maybe even starting with a clean environment right away wouldn't be such a bad idea, but that depends more on the challenge. If a lot of tools need to be installed, a clean environment isn't the greatest idea.
