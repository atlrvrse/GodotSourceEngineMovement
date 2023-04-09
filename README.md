# GodotSourceEngineMovement
~~A Kinematic player controller written in GDScript that mimics Source Engine movement~~
This branch is not entirely faithful to csgo. The goal of this branch is to continue work on the project that has been mostly abandoned, as well as add some modern features to make gameplay smoother. I want to use this as a starting point for my own game and will make a sperate branch/fork for something like that

# To-Do List
- [x] Airstrafing
- [x] Bunnyhopping
- [x] Wallstrafing
- [x] Zig-Zagging
- [ ] Accelerated Back Hopping (WIP)
- [ ] Sprinting
- [x] Crouching
- [ ] Collision modifying when crouching
- [x] Crouch-Jumping
- [x] Gravity
- [x] Ground Friction

# Parts that I want to add that are unrelated to source
- [x] Coyote time (not part of source)
- [x] Fix weird acceleration when spamming movement keys i.e. Hitting w, a, s, d gives a huge boost in velocity in the sd direction.
- [x] Make grounded movement less slippery to match modern source games like tf2. Likely caused by the lack of limit on acceleration from grounded straifing
- [ ] add limit to velocity gained from strafing (sorta?)
