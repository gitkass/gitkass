# About gitkass

- [gitlab.com/gitkass](https://gitlab.com/gitkass): `28125260-gitkass@users.noreply.gitlab.com` [repo](https://gitlab.com/gitkass/gitkass)
- [github.com/gitkass](https://github.com/gitkass): `190964064+gitkass@users.noreply.github.com` [repo](https://github.com/gitkass/gitkass)

hello world

## slush commands

```
curl -fsSL https://tailscale.com/install.sh | sh
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
curl -sfL https://direnv.net/install.sh | bash
```

## git setup

`~/.gitconfig`:

```
[user]
    email = 28125260-gitkass@users.noreply.gitlab.com
	name = kass

[gitlab]
    user = gitkass

[github]
    user = gitkass

[includeIf "gitdir:~/devgl/"]
	path = ~/.gitconfig.gitlab

[includeIf "gitdir:~/devgh/"]
	path = ~/.gitconfig.github

[includeIf "gitdir:~/hub/"]
	path = ~/.gitconfig.github

...
```

`~/.gitconfig.gitlab`
```
[user]
    email = 28125260-gitkass@users.noreply.gitlab.com
    name = gitkass

[gitlab]
    user = gitkass
```


`~/.gitconfig.github`

```
[user]
    name = gitkass
    email = 190964064+gitkass@users.noreply.github.com

[github]
    user = gitkass
```

## markdown tidbits

> [!note]
> The following information is useful.

> [!tip]
> Tip of the day.

> [!important]
> This is something important you should know.

> [!caution]
> You need to be very careful about the following.

> [!warning]
> The following would be dangerous.

## macOS slush

### Reboot with filevault

```
IMMEDIATE=0
NEVER=-1

delay="$NEVER" sudo fdesetup authrestart -delayminutes "$delay"
```

### Secure erase drives

```
LEVEL_ZERO_FILL=0 # Single-pass zero fill erase.
LEVEL_ONE_RANDOM_PASS=1 #Single-pass random fill erase.
LEVEL_SEVEN_ZERO_ONE_RANDOM_PASS=2 # 2 #Seven-pass erase, consisting of zero fills and all-ones fills plus a final random fill.
LEVEL_GUTMANN=3 #Gutmann algorithm 35-pass erase.
LEVEL_THREE_PASS=4 #Three-pass erase, consisting of two random fills  plus a final zero fill.

erase_level="$LEVEL_ONE_RANDOM_PASS"
target_disk="disk4"
diskutil secureErase "$erase_level" "/dev/$target_disk"
```
