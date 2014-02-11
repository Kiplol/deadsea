deadsea
=======

Repo for Dead Sea shmup

Idea
=======

Dead Sea is a vertically scrolling shmup in which the player controls a submarine
via touch controls.  There will be multiple levels, each with the goal of getting
to the end, defeating a boss, and collecting a piece of treasure.

Basics
=======

Moving the sub will be 1-to-1 with the player's fingers.  While the player
touches the screen, the sub will fire.  When there is no touch, the sub will not
fire.

If a player's bullet touches any part of an enemy, it counts as a collision.  An
enemy's bullet must touch the center portion of the player (which will be made
obvious in its sprite) for it to count as a collision.

Features
=======

The player can use multitouch to affect the current of the water.  The direction
in which the player swipes will determine the direction the bullets on screen
will be carried (including the player's).

Altering the current will use up charges.  Destroying enemies builds up these
charges, and destroying them in quick succession will build them faster.