# secure-lappy

this is similar to my [lappy project](https://github.com/pcrockett/lappy), but for my
"secure" laptop.

## rationale

_why do i need a dedicated secure laptop?_ because i don't like to put all my eggs in
one basket.

people tend to use their computers for two general kinds of activity:

- non-sensitive daily activity _(like browsing the web, checking email, playing games)_
- sensitive infrequent activity _(like managing finances, doing taxes, tweaking DNS
  records)_

your normal daily activity is usually less consequential than your sensitive infrequent
activity. if you engage in both activities on the same machine, then a small mistake
in your daily life can have a great impact on all the sensitive things you do. for
example, if your daily machine is running Windows, it's incredibly easy to accidentally
upload your tax returns to OneDrive, which is an _entirely inappropriate_ place to store
sensitive tax documents.

of course there are ways to try to protect sensitive things on a machine where you
engage in daily activity. however in my experience, that's not likely to succeed. not
only is it difficult to do; the end result is almost always ineffective. it's just much
simpler and more effective to have two separate physical laptops (especially because the
secure laptop can be old and dirt-cheap).

## threat model

i'm not concerned about state-sponsored hackers, targeted attacks, or anything like
that. if you're concerned about those things, i _highly recommend_
[qubes](https://www.qubes-os.org/). my main goals here are:

- to protect me from myself, to help me fall into the pit of success
- to minimize the risk of software vulnerabilities opening my sensitive activities to
  attack
- to minimize the risk of being pwned by ransomware

these goals are mostly addressed just by the fact that i have two separate laptops.

## design decisions

**atomic OS:**

this runs on [fedora silverblue](https://fedoraproject.org/atomic-desktops/silverblue/),
an "atomic" desktop operating system. this style of operating system is great for
stability and reducing maintenance burden, especially when the machine is only
occasionally powered on.

**minimalist:**

minimalism has many benefits, including a decreased attack surface. also important:
the more software you install on this thing, the more likely it will become a "daily"
machine. that goes against the goal of the project.

**blarg:**

configuration is managed with [blarg](https://github.com/pcrockett/blarg), because:

- i enjoy using my own tool (even if it is inferior to bigger more complex tools)
- it's useful for managing an evolving system over time
- it's good for documenting how the machine is configured
- it makes provisioning a new machine with the same configuration easy

## getting started

1. install fedora silverblue on a laptop
2. connect the laptop to the internet
3. bootstrap your secure laptop with curl-pipe-to-bash! _for what it's worth, i see this
   as conforming to my threat model._
   ```bash
   curl -SsfL https://github.com/pcrockett/secure-lappy/raw/refs/heads/main/bin/bootstrap.sh \
     | bash
   ```
4. follow instructions that the script may print out

now you can begin using your laptop to login to your bank, fill out tax returns, etc.
