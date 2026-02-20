# About gitkass

<!-- git@gitlab.com:gitkass/gitkass.git -->

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

### ssh arguments

- `-o PreferredAuthentications=password -o PubkeyAuthentication=no`: Use password-based auth for this connection.

### ssh config

- `StrictHostKeyChecking accept-new`: Trust new hosts, but warn if an existing host changes.

### Generate ssh key in secure enclave

- [source](https://gist.github.com/arianvp/5f59f1783e3eaf1a2d4cd8e952bb4acf)
- Use a `-ne` (non-exportable) key type
- Note these expire in 1 year.

```
your_key_type="p-256-ne" # The `-ne` suffix means non-exportable.
touch="bio" # or `none` to not require a touchID prompt 
your_label="key11"
your_email="190964064+gitkass@users.noreply.github.com"
your_common_name="kass.zxcv.foo"
your_organizational_unit="gitkass"
your_organization="zxcv.foo"
your_locality="Toronto"
your_state="Ontario"
your_country="CA" # (2-letter ISO 3166 country code, e.g., "US", "GB", "DE")

sc_auth create-ctk-identity \
-l "${your_label}" \
-N "${your_common_name}" \
-t "${touch}" \
-E "${your_email}" \
-U "${your_organizational_unit}" \
-O "${your_organization}" \
#-S "${your_state}" \
#-L "${your_locality}" \
#-C "${your_country}" \
-k "${your_key_type}" # Last since key type is required and other arguments may be commented out.

```

### Stay awake


```
     -d      Create an assertion to prevent the display from sleeping.
     -i      Create an assertion to prevent the system from idle sleeping.
     -m      Create an assertion to prevent the disk from idle sleeping.
     -s      Create an assertion to prevent the system from sleeping. This assertion is valid only when system is running on AC power.
     -u      Create an assertion to declare that user is active. If the display is off, this option turns the display on and prevents the display
             from going into idle sleep. If a timeout is not specified with '-t' option, then this assertion is taken with a default of 5 second
             timeout.
     -t      Specifies the timeout value in seconds for which this assertion has to be valid. The assertion is dropped after the specified timeout.
             Timeout value is not used when an utility is invoked with this command.
     -w      Waits for the process with the specified pid to exit. Once the the process exits, the assertion is also released.  This option is
             ignored when used with utility option.
```

```
caffeinate -dimsu task #stay awake until `task` finishes
caffeinate -dimsu -t 3600 #1 hour
```

