---
title: Coding for Kano Wand outside the app
tags: code javascript toys
copyright: CC0
---

This article is for those who receive a [Kano Harry Potter Coding Wand](https://kano.me/uk/store/products/coding-wand), perhaps as a gift.  You try [the App that comes with it](https://kano.me/app) and then think "This is an interesting piece of hardware.  What else can I do with it?"

Well I hope so.  That is why I bought one as a gift - and I'm [not the first](https://blog.adafruit.com/2019/11/30/smartwand/) to see its potential as a remote control device.

This is my record of what I discovered before it went on its way to a new owner.


## Can I talk to it from my Linux computer?

I was using [Ubuntu Bionic](http://releases.ubuntu.com/18.04/).  Package names and filenames may differ on other systems or versions.

You will need a Bluetooth host adapter which supports Bluetooth Low Energy, some software which may not already be installed, and to grant some extra privileges to the `hcitool` program.

These instructions are from [Stack Exchange](https://unix.stackexchange.com/questions/96106/bluetooth-le-scan-as-non-root/182559#182559)

```
sudo aptitude install bluetooth bluez libcap2-bin
sudo setcap 'cap_net_raw,cap_net_admin+eip' `which hcitool`
hcitool -i hci0 lescan
```

If your device can't do Bluetooth Low Energy, you may see `Set scan parameters failed: Input/output error`.  If you have multiple Bluetooth host devices you can use a different one by name.  hci0 is the default and `hcitool dev` should list what you have available.  I didn't do this and haven't shown how to do it when using the other code below.

If it is working, you will see `LE Scan ...`.  Wake the wand and it should show itself like `Kano-Wand-xx-yy-zz`.  OK, your hardware is working!  Press ctrl-C to stop.


## Can I talk to it from my MacOS X laptop?

Probably, if it's not very old.  I haven't looked up the equivalent of `hcitool lescan`.

This [MacBook A1278](https://everymac.com/ultimate-mac-lookup/?search_keywords=A1278) works fine, and it's probably the mid-2012 model.


## Other tools that will be needed

We're going to need some compilers.  We will also need a distributed version control system [called Git](https://git-scm.com/) which will be useful for fetching other people's software.

Under Ubuntu Linux, in addition to the Bluetooth-related tools above, they can be fetched with `sudo aptitude install git build-essential` .  In older Ubuntu, the `git` package was known as `git-core`.  `build-essential` brings in a commonly useful assortment of compilers and libraries.

On a Mac, the XCode tools can be installed from the Apple Store and Git is included.  Exactly how this is done may differ between versions of MacOS, but Homebrew helped me to get it right.


## Can I talk to the Wand in Javascript?

Yes!  But the instructions are a little different between Mac and Linux, because the `noble` package which provides access to Bluetooth LE has a Mac-specific fork called `noble-mac`.

The [`kano-wand-nodejs` project](https://github.com/megabytemb/kano-wand-nodejs) I used was started by [megabytemb](https://github.com/megabytemb) a year ago, and other people have extended or modified it.  This is how it looks in [Github's "project fork" view](https://github.com/megabytemb/kano-wand-nodejs/network/members).

On Mac, the default [master branch of megabytemb's project](https://github.com/megabytemb/kano-wand-nodejs) worked for me.

On Ubuntu Linux, the [grpc branch of GageAmes' version](https://github.com/GageAmes/kano-wand-nodejs/tree/grpc) worked for me.

Either way, we need [NodeJS](https://nodejs.org/) to run the Javascript, which includes the Node Package Manager to fetch more code libraries.

* On MacOS I used Node 12.14.0 LTS installed via [Homebrew](https://brew.sh) .
* On Bionic [it was](https://packages.ubuntu.com/bionic/nodejs) 8.10.0~dfsg-2ubuntu0.4 .



### Javascript on Ubuntu Bionic

We can install everything, fetch the project and run the example with a few lines.

```
sudo aptitude install npm nodejs libbluetooth-dev libudev-dev
sudo setcap cap_net_raw+eip $(eval readlink -f `which node`)
git clone -b grpc https://github.com/GageAmes/kano-wand-nodejs
```

### Javascript on MacOS

To install NodeJS I start with Homebrew so I didn't need any administrator privileges.

```
cd
git clone https://github.com/Homebrew/brew
cd brew/
xcode-select --install
bin/brew install node
cd
git clone https://github.com/megabytemb/kano-wand-nodejs
```

### Javascript anywhere

Once NPM is working and the correct `kano-wand-nodejs` is downloaded, the process is the same.

```
cd kano-wand-nodejs/
npm install
node example.js
```

Enter the downloaded project directory.  Tell `npm` to install everything listed in the `package.json` and `package-lock.json` files.  Run the example!

It should wait until the Wand is woken up, then

```
foundWand
[ '[Kano-Wand-xx-yy-zz]', 'init' ]
[ '[Kano-Wand-xx-yy-zz]', 'Discovering services...' ]
[ '[Kano-Wand-xx-yy-zz]', 'Found' ]
[ '[Kano-Wand-xx-yy-zz]',
  'Discovering characteristics for service with UUID' ]
[ '[Kano-Wand-xx-yy-zz]',
  'Discovering characteristics for service with UUID' ]
[ '[Kano-Wand-xx-yy-zz]',
  'Discovering characteristics for service with UUID' ]
[ '[Kano-Wand-xx-yy-zz]', 'Found vibrate characteristic' ]
[ '[Kano-Wand-xx-yy-zz]', 'Found button characteristic' ]
[ '[Kano-Wand-xx-yy-zz]', 'Found keep alive characteristic' ]
[ '[Kano-Wand-xx-yy-zz]', 'Found position characteristic' ]
[ '[Kano-Wand-xx-yy-zz]', 'Found ResetChar characteristic' ]
[ '[Kano-Wand-xx-yy-zz]', 'Subscribe to motion characteristic' ]
[ '[Kano-Wand-xx-yy-zz]', 'Subscribe to button characteristic' ]
[ '[Kano-Wand-xx-yy-zz]', 'Reset position' ]
[ '[Kano-Wand-xx-yy-zz]', 'Wand ready!' ]
```

Now hold the button down and draw a spell

```
{ score: 0.9995614290237427,
  spell: 'Avis',
  positions: 
   [ [ 493.3333333333333, 158.10000000000002 ],
     [ 492.44444444444446, 158.7 ],
     [ 491.55555555555554, 159.3 ],
     [ 489.77777777777777, 157.8 ],
     [ 487.1111111111111, 151.8 ],
     [ 488.8888888888889, 136.5 ],
     [ 495.1111111111111, 118.80000000000001 ],
     [ 508.44444444444446, 105 ],
     [ 522.6666666666667, 99 ],
     [ 533.3333333333333, 110.69999999999999 ],
     [ 536, 129.3 ],
     [ 529.7777777777778, 149.39999999999998 ],
     [ 530.6666666666666, 148.2 ],
     [ 548.4444444444445, 132.89999999999998 ],
     [ 585.7777777777778, 106.79999999999995 ],
     [ 616, 94.5 ],
     [ 633.7777777777778, 105 ],
     [ 643.5555555555555, 124.5 ],
     [ 644.4444444444445, 141 ] ] }
```

(That's the only spell I can get right reliably.)


## Can I talk to the Wand in Python?

Maybe, but on Ubuntu Bionic I ran into problems and found easier success in Javascript.  I will try again if I have time, but for now **this section is incomplete**.

From [the Adafruit blog](https://blog.adafruit.com/2019/11/30/smartwand/) I continued to [Instructables](https://www.instructables.com/id/SmartWand/).  There I partly followed the instructions and partly followed my nose.

```
sudo aptitude install python3-numpy virtualenv libglib2.0-dev
# I'm not sure all of these are needed, since the later "pip install -r requirements.txt"
# brings some of them?

virtualenv -p /usr/bin/python3 wand
cd wand
. bin/activate
# now we have a safely isolated place to install some code, without
# interfering with other things

git clone --recursive https://github.com/GammaGames/kano-wand-demos.git
cd kano-wand-demos
pip install -r requirements.txt

sudo setcap 'cap_net_raw,cap_net_admin+eip' $VIRTUAL_ENV/lib/python3*/*-packages/bluepy/bluepy-helper
```


## Other problems seen on the way?

* Linux: when the bluetooth services fail to restart my host adapter, I see this in the output of `dmesg`: `Bluetooth: hci0: urb 000000005c....2c failed to resubmit (113)`
    * Looks like I need to reboot.

## Maybe you're wondering...?

* Will I be using the wand to do something cool?  Probably not.  I like the idea of conducting some instruments with it, but I don't have the musical skills and the wand itself is Going Away soon.  I do have another BLE device to play with though.
* Are there alternatives to the Kano HPCW (wand)?  Maybe.  There is a [DIY project](https://hackaday.io/project/161832-kano-wand-hack) and there are 3D mouse products such as [the Air Mouse](https://www.gyration.com/products/air-mouse-mobile/) or [SkyStream Air Mouse remote](https://www.skystreamx.com/products/skystream-air-mouse-remote-1)
* Do you understand [quaternions](https://en.wikipedia.org/wiki/Quaternion)?  Not so much.  I know they extend the complex numbers and I know where to look if I want to study them some more.
* How long will these instructions remain valid?  That depends on how much work people put into the projects.  Sometimes code changes fast, sometimes it just sits there.
