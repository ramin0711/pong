Welcome to PONG with Real Physics-Based Sound!
by Perry R. Cook, Summer 2015, for Course:
Physics Based Sound Synthesis for Games and Interactive Systems
Stanford CCRMA/Kadenze

You should run these programs in a Terminal shell window
(Mac, LINUX) or Command Prompt (DOS box) Window.  To
find out more about that, read the file: 

UsingTerminal.txt

If you've saved the PongSynth1 directory in you home 
directory, you should see it listed in the output if 
you type and enter in the Terminal/Prompt

ls

Along with other things, you should see PongSynth1.  If it's 
there, type/return

cd PongSynth1

If you saved PongSynth1 to your Desktop, then type/return

cd Desktop/PongSynth1

If PongSynth was saved somewhere else, find it using the Find
function(s) for your OS and move it somewhere normal, like 
your Desktop.  Actually, you probably at this time want to 
make a folder to hold all of your coursework for this class,
named something like PhysicsDSP2015 or other. You can then 
stash PongSynth1 in there, and subsequent course projects.

Once you've navigated to the PongSynth1 directory, type/return

./PONG

Magic should happen!!  A square black window should appear 
with a ball bouncing in it, and you should hear sounds when
the ball bounces off the walls or center peg.

(NOTE to Windows Users:  You can actually launch PONG.bat
by double-clicking it from a directory window, but if it
doesn’t work right (you see errors or don’t see balls 
bouncing around and hear sounds), then you’ll need to
get into a Command Prompt to debug as described below)

If Magic didn't happen, then let's try things one at
a time.  Type in your terminal window (to stop anything 
that might running):

<ctrl>-c   (that's the Control key, adding the "c" key
so they're both held down at the same time)

NOTE:  Control-c is your friend, because it stops any
program that you might have run in the Terminal. Many
ChucK demos are infinite loops, so you'll use 
<ctrl>-c to stop them when you're tired of them.

Now type:

chuck PongPhysics1.ck

You should see lots of text spewing into your
terminal window.  These are commands for the 
PongViewGL viewer window to display the balls.

If chuck isn't working, then you need to install
it (go to the ChucK download page and get the
one for your architecture, using the installer
to put things in the right places for you).
If the PongPhysics1.ck file cause ChucK to 
generate errors, then you're probably not
using the most recent version of ChucK.  
Again, go get and install the newest one.

(NOTE to older (and maybe other) Windows Users:
The newest ChucK might complain that MSVCR100.dll
needs to be loaded.  This is a run-time library
that should be installed in order for lots of 
modern programs to work correctly.  Get and install
that (use google to find it), then chuck should work).

Once chuck works, then <ctrl>-c to stop the chuck
program running (or it will stop anyway after 30
seconds).

Now type (and return):

PongViewGL

If it gives you an error (like saying "bad executable"
or other message like that), that just means that the
PongViewer isn't the right type (Windows, Mac, Linux).
In that case, go to **GET PONG VIEW WORKING below

If PongViewGL did work, you see the black PongViewer window.
Type (and carriage return after each line):

b0 0 0 0.2
f0 1
c0 0 1 0
h1 0.5 0.5 0.3
c1 1 0 0
f1 1
Exit

You just drew a ball, filled it, with blue, then 
you drew a heart, filled, with red, then caused 
the window to go away.  Cool huh?

Now try type/return:

chuck PongPhysics1.ck | ./PongViewGL

Since ChucK works, and PongViewGL works, then 
this should work.  This is exactly what's in
the PONG or PONG.bat files.

If you still can’t get things working, check the course
Forums, or find a programmer friend to help you out.



**GET PONG VIEW WORKING

The main PongSynth1 directory comes with two executables 
for PongViewGL already in it, one (PongViewGL) for MacOSX,
and another (PongViewGL.exe) for Windows.  If you're a Linux
user, then you need to replace PongViewGL with the one for
Linux (or build one for your version of Linux).  All of the
executables for many different platforms live pre-compiled 
in the PongViewGLbin directory.  cd to there:

cd PongViewGLbin

and try typing the one that corresponds to your platform.
(Note there's even one for the Raspberry Pi!!)

Windows (maybe even Mac) might ask you if you want to trust
this application. Say you do and it should work from then on.
We’ve included the appropriate graphics .dll files so the
PongViewer can do its thing.  Those need to live in the
same directory as PongViewGL(.exe) or in a directory that’s
in one of your default PATHs.  

Linux:  Your PONGLinux script should likely work fine, as
it points to the compiled binary in the PongViewGLbin directory.
If you got the PongViewGLinux file to work, then you could
just copy that up one level to PongViewGL (replacing the Mac
one that’s there).  Then you could just use the PONG script.
Other Linux-type users might need to compile their own.  
We’ll try to put up a repository of executables for each
Linux, as we get them built and running. See the README.txt 
file in the directory, PongViewGLsrc for more information 
about how to build your own.

END

