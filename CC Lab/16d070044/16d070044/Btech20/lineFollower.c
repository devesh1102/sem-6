// -O0
// 7372800Hz

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "lcd.c"

unsigned char ADC_Conversion(unsigned char);
unsigned char ADC_Value;
unsigned char l = 0;
unsigned char c = 0;
unsigned char r = 0;
unsigned char PortBRestore = 0;
int count = 0, threshold_1 = 20,count1 = 0, hard_turn = 100, count_max = 100,dum = 0 ; 
float error_l =0,error_r =0,error_sum = 0 , error_c=0,kp= 1,kd = 0.5,ki = 0,error_pre = 0,error = 0,pid= 0,lp = 0,rp = 0,cp =0 ;
float error_diff = 0;
float turn_thres = 80;
float hard_thres = 120;


void motion_pin_config (void)
{
 DDRB = DDRB | 0x0F;   //set direction of the PORTB3 to PORTB0 pins as output
 PORTB = PORTB & 0xF0; // set initial value of the PORTB3 to PORTB0 pins to logic 0
 DDRD = DDRD | 0x30;   //Setting PD4 and PD5 pins as output for PWM generation
 PORTD = PORTD | 0x30; //PD4 and PD5 pins are for velocity control using PWM
}

//Function used for setting motor's direction
void motion_set (unsigned char Direction)
{
 unsigned char PortBRestore = 0;

 Direction &= 0x0F; 			// removing upper nibbel as it is not needed
 PortBRestore = PORTB; 			// reading the PORTB's original status
 PortBRestore &= 0xF0; 			// setting lower direction nibbel to 0
 PortBRestore |= Direction; 	// adding lower nibbel for direction command and restoring the PORTB status
 PORTB = PortBRestore; 			// setting the command to the port
}

void forward (void)         //both wheels forward
{
  motion_set(0x06);
}

void back (void)            //both wheels backward
{
  motion_set(0x09);
}

void left (void)            //Left wheel backward, Right wheel forward
{
  motion_set(0x05);
}

void right (void)           //Left wheel forward, Right wheel backward
{   
  motion_set(0x0A);
}

void soft_left (void)       //Left wheel stationary, Right wheel forward
{
 motion_set(0x04);
}

void soft_right (void)      //Left wheel forward, Right wheel is stationary
{ 
 motion_set(0x02);
}

void soft_left_2 (void)     //Left wheel backward, right wheel stationary
{
 motion_set(0x01);
}

void soft_right_2 (void)    //Left wheel stationary, Right wheel backward
{
 motion_set(0x08);
}

void hard_stop (void)       //hard stop(stop suddenly)
{
  motion_set(0x00);
}

void soft_stop (void)       //soft stop(stops slowly)
{
  motion_set(0x0F);
}

//Function to Initialize ADC
void adc_init()
{
 ADCSRA = 0x00;
 ADMUX = 0x20;		//Vref=5V external --- ADLAR=1 --- MUX4:0 = 0000
 ACSR = 0x80;
 ADCSRA = 0x86;		//ADEN=1 --- ADIE=1 --- ADPS2:0 = 1 1 0
}


void init_devices (void)
{
 cli(); //Clears the global interrupts
 port_init();
 adc_init();
 sei(); //Enables the global interrupts
}


//Function to configure LCD port
void lcd_port_config (void)
{
 DDRC = DDRC | 0xF7;    //all the LCD pin's direction set as output
 PORTC = PORTC & 0x80;  // all the LCD pins are set to logic 0 except PORTC 7
}

//ADC pin configuration
void adc_pin_config (void)
{
 DDRA = 0x00;   //set PORTF direction as input
 PORTA = 0x00;  //set PORTF pins floating
}

//Function to Initialize PORTS
void port_init()
{
 lcd_port_config();
 adc_pin_config();
 motion_pin_config();
}

//TIMER1 initialize - prescale:64
// WGM: 5) PWM 8bit fast, TOP=0x00FF
// desired value: 450Hz
// actual value: 450.000Hz (0.0%)
void timer1_init(void)
{
 TCCR1B = 0x00; //stop
 TCNT1H = 0xFF; //setup
 TCNT1L = 0x01;
 OCR1AH = 0x00;
 OCR1AL = 0xFF;
 OCR1BH = 0x00;
 OCR1BL = 0xFF;
 ICR1H  = 0x00;
 ICR1L  = 0xFF;
 TCCR1A = 0xA1;
 TCCR1B = 0x0D; //start Timer
}

//This Function accepts the Channel Number and returns the corresponding Analog Value
unsigned char ADC_Conversion(unsigned char Ch)
{
 unsigned char a;
 Ch = Ch & 0x07;
 ADMUX= 0x20| Ch;
 ADCSRA = ADCSRA | 0x40;	//Set start conversion bit
 while((ADCSRA&0x10)==0);	//Wait for ADC conversion to complete
 a=ADCH;
 ADCSRA = ADCSRA|0x10;      //clear ADIF (ADC Interrupt Flag) by writing 1 to it
 return a;
}

//Main Function
int main(void)
{
 init_devices();
timer1_init();
 lcd_set_4bit();
 lcd_init();
//devesh 
//CALIBRATION ON WHITE ALL SHOW UPTO 100
//ON BLACK GREATER THAN 170
while(1)
{
	l=ADC_Conversion(3);
	c=ADC_Conversion(4);
	r=ADC_Conversion(5);
	lcd_print(1, 1, l, 3);
	lcd_print(1, 5, c, 3);
	lcd_print(1, 9, r, 3);
	//_delay_ms(300);
	

	error = l-r;
	error_diff = error - error_pre;
	error_pre = error;
	error_sum = error_sum+ error;
	pid = kp*error+ ki*error_sum + kd*error_diff;
//	 if (pid > 255 ) {
//	 pid = 255;
	  
//	 }
//	 if (pid<-255){
//	 pid = -255;}
//		
	 if (pid> turn_thres && c > 110){
	 		//left turn
			//OCR1AL = ;
	//	OCR1BL = (int)(255 * count / count_max);

	 	if (pid > hard_thres)	{//hardleft turn
	 	//	OCR1BL = 0;
		//	OCR1AL = 255;
    	//	OCR1BH = 0;
		//	OCR1AH = 0;
			soft_left();
			
//		lcd_cursor (2,8);
//		lcd_wr_char('LL');
	//	_delay_ms(30);

	 	}
		else {
		//OCR1BL = 0;
		//OCR1AL = 255;
    	//OCR1BH = 0;
		//OCR1AH = 0;
		soft_left();
//		lcd_cursor (2,8);
//		lcd_wr_char('Hl');
	//	_delay_ms(30);
		}
	 }
	else if (pid<-1* turn_thres  && c > 110) {
		//OCR1BL = 255;
		//OCR1AL = 0;
		//OCR1BH = 0;
		//OCR1AH = 0;
		soft_right();
//		lcd_cursor (2,8);
///		lcd_wr_char('R');
	//	_delay_ms(30);
	}
	else if ( c < 110){
		if (pid<-1* turn_thres ){
		right();
		}
		else {
		left();
		}
	//			lcd_cursor (2,8);
	//	lcd_wr_char('b');
			
	}
	else {
		//OCR1BL = 255;
		//OCR1AL = 255;
		OCR1BH = 0;
		OCR1AH = 0;
		forward ();
	//	lcd_cursor (2,8);
	//	lcd_wr_char('F');	
//	_delay_ms(300);
	}

}
}



//devesh end
	/*forward();
while(1)
{	l=ADC_Conversion(3);
	c=ADC_Conversion(4);
	r=ADC_Conversion(5);
	lcd_print(1, 1, l, 3);
	lcd_print(1, 5, c, 3);
	lcd_print(1, 9, r, 3);
	_delay_ms(30);

	
	error_l = l - lp;
	error_r = r - rp;
 	error_c = c - cp;
	dum = 0;
	error = error_l -error_r;
	if ( (error_l - error_r) * error_c < threshold_1 ){
		//left
		if (abs ( (error_l - error_r)) > hard_turn){
		//hardturn
		//stop left wheel and move right
		OCR1BL = 255;
		OCR1AL =  0 ;
		lcd_print(2, 9, dum, 3);
		lcd_print(2, 1, r, 3);
		lcd_print(2, 5, dum, 3);
		}
		else {//no hardturn
		OCR1BL = pid; //right
		OCR1AL =  0 ;
		lcd_print(2, 5, c, 3);
		lcd_print(2, 9, dum, 3);
		lcd_print(2, 1, dum, 3);
		}
	} 
	else if ( (error_l - error_r)* error_c > -1*threshold_1 ){
		//right
		if (abs ( (error_l - error_r)) > hard_turn){
		OCR1BL = 0;
		OCR1AL =  255 ;	
		lcd_print(2, 9, l, 3);
		lcd_print(2, 1, dum, 3);
		lcd_print(2, 5, dum, 3);
		}
		else {// no hardturn
		OCR1BL = 0; //right
		OCR1AL =  pid ;
		
		}
	}
	else {//forward
		if(count < count_max){
			count++;
		}  
	//	OCR1AL = (int)(255 * count / count_max);
	//	OCR1BL = (int)(255 * count / count_max);
    	OCR1BL = (int)(255);
		OCR1AL = (int)(255);

	

		 //center
	}

	pid = kp *error + kd *(error - error_pre)+ki*error_sum;
 	error_sum = error_sum + error;
 	error_pre = error;
	 if (pid>255){
	 pid = 255;
		 }
	 if (pid<-255){
	 pid = -255;
		 }
 if(count1 < 100){
	error_sum = 0;
 }

 
	lp = l ;
	rp = r ;
 	cp = c;
}
	
}

/*
while(1)
{	l=ADC_Conversion(3);
	c=ADC_Conversion(4);
	r=ADC_Conversion(5);
	
	lcd_print(2, 1, pid, 3);
	lcd_print(2, 5, error_c, 3);
	lcd_print(2, 9, error_r, 3);
	_delay_ms(30);
	error_l = l - lp;
	error_r = r - rp;
 	error_c = c - cp;
	error = error_l -error_r;
	forward();            //both wheels forward
	if ( (error_l - error_r)  > threshold_1 )
	{
		//left
	lcd_print(1, 1, l, 3);
	lcd_print(1, 5, c, 3);
	lcd_print(1, 9, r, 3);
	if (abs ( (error_l - error_r)) > hard_turn){
		//hardturn
	else {
		soft_left();               //Left wheel backward, Right wheel forward
		_delay_ms(-1*pid);
		}
		//}
		//else {//no hardturn
	//soft_left();          //Left wheel stationary, Right wheel forward
	//_delay_ms(-1*pid);
	//	}
	} 
	else if( (error_l - error_r) < -threshold_1 ){
		//right
		//if (abs ( (error_l - error_r)) > hard_turn){
		right();              //Left wheel forward, Right wheel backward
		_delay_ms(pid);	
	lcd_print(2, 1, pid, 3);
	lcd_print(2, 5, error_c, 3);
	lcd_print(2, 9, error_r, 3);
	//	}
	//	else {// no hardturn
//	soft_right();         //Left wheel forward, Right wheel is stationary
//	_delay_ms(pid);
		
	//	}
	}
	else {//forward
		if(count < count_max){
			count++;
		}  
	forward();            //both wheels forward
	_delay_ms(100);;

	

		 //center
	}

	pid = kp *error+kd *(error - error_pre)+ki*error_sum;
 	error_sum = error_sum + error;
 	error_pre = error;
	
 if(count1 < 100){
	error_sum = 0;
 }

 
	lp = l ;
	rp = r ;
 	cp = c;
}
	
}
*/
/*
	forward();            //both wheels forward
	_delay_ms(1000);

	hard_stop();						
	_delay_ms(300);

	back();               //both wheels backward						
	_delay_ms(1000);

	hard_stop();						
	_delay_ms(300);

	left();               //Left wheel backward, Right wheel forward
	_delay_ms(1000);

	hard_stop();						
	_delay_ms(300);

	right();              //Left wheel forward, Right wheel backward
	_delay_ms(1000);

	hard_stop();						
	_delay_ms(300);

	soft_left();          //Left wheel stationary, Right wheel forward
	_delay_ms(1000);

	hard_stop();						
	_delay_ms(300);

	soft_right();         //Left wheel forward, Right wheel is stationary
	_delay_ms(1000);

	hard_stop();						
	_delay_ms(300);

	soft_left_2();        //Left wheel backward, right wheel stationary
	_delay_ms(1000);


void velocity (unsigned char left_motor, unsigned char right_motor)
{
OCR1AL = left_motor;
OCR1BL = right_motor;
}


	hard_stop();						
	_delay_ms(300);

	soft_right_2();       //Left wheel stationary, Right wheel backward
	_delay_ms(1000);

	hard_stop();						
	_delay_ms(300);
   
}
*/

