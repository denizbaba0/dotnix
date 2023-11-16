# _**`.NIX > *NIX`**_

![chadwm-2](https://github.com/utfeight/dotnix/assets/101834410/9d009cb7-2bbf-4f19-bf3b-8f3245387f19)

NixOS is beyond a Linux distribution. Here is mine.

## Building

Here is the script you need to run to get this working:

### Notes:

- I use two monitors in my setup (1920x1080, and a 20" square one) So my
  configuration assumes that you have two monitors. Just edit
  `dwm/default.nix - services.xserver.xrandrHeads` if you have a different
  setup.

> [!IMPORTANT] You **WILL NEED** `/etc/nixos/hardware-configuration.nix`, as
> this configuration imports it, so you will need to run
> `sudo nixos-generate-config` if you've deleted them.

```sh
nix-shell -p git --command "git clone https://github.com/utfeight/dotnix && cd dotnix"
./rebuild.sh
```

`machine-name` is a machine selected from the machines in the `machines`
directory.

## Configuration

Lets say you have changed the configuration and want to apply the changes to
your system. You would have to run the rebuild script:

```sh
git add . # if you have added/removed new files
./rebuild.sh
```

This runs the script interactively. You can also check how the script is used:

```sh
./rebuild.sh --help
```

This outputs:

```
Usage: ./rebuild.sh [-h | --help] [machine-name]
```

### NOTES

#### Mounting

https://discourse.nixos.org/t/how-to-add-second-hard-drive-hdd/6132/3

has a good explanation on how to mount a second hard drive. just:

```sh
sudo mkdir <DIR TO MOUNT THE DRIVE>
sudo mount /dev/sda1 <DIR TO MOUNT THE DRIVE>
sudo nixos-generate-config # this will write the currently mounted drives to /etc/nix/hardware-configuration.nix
./rebuild.sh # apply the changes
```

and whollah! You have a second drive mounted automatically in every startup.

## License

```
MIT License

dotnix - personal nixos configuration

Copyright (c) 2023-present utfeight

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
