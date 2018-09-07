// the event
KBHit kb;

int _mf;
int _mg;
float _cf;

67 => _cf;
50 => _mf;
80 => _mg;

fun void fmsound(int cf, float mf, float mg, float _gain) { 
    
    // SinOsc m => SinOsc c => ADSR e => JCRev r => Gain g => dac;
    
    SinOsc m => SinOsc c => JCRev r => Gain g => dac;
    
    // e.set(.2::second, 0.01::second, .06, .02::second);
    
    r.mix(0.2);
    
    
    
    // phase modulation is FM synthesis (sync is 2)
    
    2 => c.sync;
    
    
    
    // time-loop
    
    while( true ) {
        
        Std.mtof(_cf) => c.freq;
        _mf => m.freq;
        _mg => m.gain;
        _gain => g.gain;
        
        50::ms=> now; // freq change interval
        
    }
    
   
    
};

spork ~ fmsound(62, 140, 30, 0.1);


while (true) {
    
    // wait on event
    kb => now;
    
    // loop through 1 or more keys
    while( kb.more() )
    {
        // set filtre freq
        kb.getchar() => int c;
//        <<< "ascii:", c >>>;        

        if (c == 40) {
            _cf - 1.0 => _cf;
            <<<"carrier freq: ">>>;
            <<<_cf>>>;            
        }
        
        if (c == 41) {
            _cf + 1.0 => _cf;
            <<<"carrier freq: ">>>;
            <<<_cf>>>;            
        }
        
        if (c == 91) {
            _mf--;
            <<<"modulator freq: ">>>;
            <<<_mf>>>;            
        }
        
        if (c == 93) {
            _mf++;
            <<<"modulator freq: ">>>;
            <<<_mf>>>;            
        }
        
        if (c == 123) {
            _mg--;
            <<<"modulator gain: ">>>;
            <<<_mg>>>;
        }
        
        if (c == 125) {
            _mg++;
            <<<"modulator gain: ">>>;
            <<<_mg>>>;
        }


    }
    
   
    10::ms => now;
    
}