#define F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

volatile int counter = 3000;

ISR(INT1_vect) // External INT1 ISR
{
    PORTB = 0xFF; // Turn on all LEDs of PORTB
    _delay_ms(1000); // for 1000ms
    PORTB = 0x01; // Turn off all LEDs of PORTB except PB0
    counter = 3000; // Reset the counter
    EIFR = (1 << INTF1); // Clear the interrupt flag of INTF1
}

int main()
{
    // Interrupt on rising edge of INT1 pin
    EICRA = (1 << ISC11) | (1 << ISC10);

    // Enable the INT1 interrupt (PD3)
    EIMSK = (1 << INT1);

    sei(); // Enable global interrupts

    DDRB = 0xFF; // Set PORTB as output

    while(1)
    {
        _delay_ms(1); // Delay 1 ms
        counter--; // Decrement the counter

        if(counter == 0)
        {
            PORTB = 0x00; // Turn off the LED on PB0
            counter = 3000; // Reset the counter
        }
    }
}