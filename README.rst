stmtest
=======

Test for STM.

Required Arch Linux packages
----------------------------

- ``arm-none-eabi-binutils``
- ``arm-none-eabi-gcc``
- ``arm-none-eabi-gdb``
- ``arm-none-eabi-newlib``
- ``stlink``
- ``openocd``

Current problems
----------------

- Finish custom Makefile to compile sources in subfolders
- The example/ now compiles, can be flashed, but the PB00 pin is NOT blinking ; maybe the program is not started at all
- Flash will fail using stlink half the time and maybe work the other time
