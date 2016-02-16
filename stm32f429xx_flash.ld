/*
 * Karl Palsson, 2011
 * This is a memory map for the STM32L15xxB parts
 * It is considered to be released into the public domain
 */
ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx)    : ORIGIN = 0x8000000, LENGTH = 2048K
    RAM (xrw)     : ORIGIN = 0x20000000, LENGTH = 192K
    CCMRAM (rw)   : ORIGIN = 0x10000000, LENGTH = 64K
}

INCLUDE generic_sections_flash.ld
