#define F_CPU 16000000UL
#include<avr/io.h>
#include<avr/interrupt.h>
#include<util/delay.h>

volatile uint16_t counter = 300;
volatile uint8_t done_both = 1;
volatile uint8_t done = 1;

ISR(INT1_vect){ //external interrupt 1
    counter = 0;
    if (done==0){
        done_both=0;
    }
    done = 0;
EIFR = (1 << INTF1); // Clear the flag of interrupt INTF1


}

int main(){
    EICRA=(1<<ISC11) | (1<<ISC10); //rising edge for INT1

    EIMSK=(1<<INT1); //enable INT1 interrupt, PD3

    sei(); //enable global interrupt

    DDRB=0xFF; //PORTB as output

    PORTB=0x00; //initially all LEDs are off

    while(1){
        if (counter<300 && done_both==0){
            done_both = 0;
            if (counter<200)
            PORTB=0xFF; //turn on all LEDs
            _delay_ms(1);
            counter++;
            if (counter>200 && counter<299){
                PORTB=0x01; //turn on the first LED
                _delay_ms(1);
            }
            if (counter==299) {
                PORTB=0x00;
                done_both = 1;
                done = 1;
            }
            //
        } else if (counter<300 && done == 0){
            done = 0;
            _delay_ms(1);
            counter++;
            if (counter<299 && done == 0){
                PORTB=0x01;
            } else if (counter==299 && done == 0){
                PORTB=0x00;
                done = 1;
            }
            
        }
    }
}

/*
Να υλοποιηθεί αυτοματισμός που να ελέγχει το άναμμα και το σβήσιμο ενός φωτιστικού σώματος. Όταν πατάμε
το push button PD3 (δηλαδή με την ενεργοποίηση της INT1) να ανάβει το led PΒ0 της θύρας PORTB (που
υποθέτουμε ότι αντιπροσωπεύει το φωτιστικό σώμα). Το led θα σβήνει μετά από 3 sec, εκτός και αν ενδιάμεσα
υπάρξει νέο πάτημα του PD3, οπότε και ο χρόνος των 3 sec θα ανανεώνεται. Κάθε φορά που γίνεται ανανέωση να
ανάβουν όλα τα led της θύρας PORTΒ (PΒ7-PΒ0) για 1 sec, μετά να σβήνουν εκτός από το led PΒ0 που παραμένει
συνολικά για 3 sec εκτός και αν ανανεωθεί. O κώδικας να δοθεί σε C.
Υποδείξεις:
1. Στην κύρια ρουτίνα χρησιμοποιήστε τη ρουτίνα _delay_ms(1) και έναν μετρητή που θα μετράει από το 0
έως το 3000.
2. Στη ρουτίνα υπηρεσίας διακοπής, ο μετρητής θα μηδενίζεται.
3. Επίσης στη ρουτίνα υπηρεσίας διακοπής η αντίστοιχη σημαία διακοπής θα μηδενίζεται.
*/