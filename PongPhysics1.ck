// PongPhysics1.ck   by Perry R. Cook  2015
// And me Ramin Anushiravani
// Simple physics of bouncing ball in a 
// square  box.  One peg in center.
// Collisions trigger sounds.  
// I've added codes to change the radius of the cirble
// as well its accelation and pitch randomly 
// I tried to make the sound as related to
// it's accelration and speed by changing its gain and pitch.
// I used a piano note and repeating piano note, I thought it would
// be cool to make music with the ball bouncing, I guess
// for a more interesting music, I would need to add more
// constraints on the ball behaviour


// Simple Ball object with physics variables
class Ball {
    0.06 => float r;   // radius
    0.5 => float x;    // x position
    0.5 => float y;    // y position
    0.02 => float dx;  // velocity in x
    0.01 => float dy;  // velocity in y
    0.0 => float ax;   // acceleration in x 
    0.0 => float ay;   // acceleration in y
    0.995 => float damp; // 1.0 means no loss over time

    fun void doPhysics()  {
        ax +=> dx;   // dx += ax; // in C/Java
        ay +=> dy;   // dy += ay; // in C/Java
        (damp *=> dx) +=> x;      // x += (dx *= damp);  // in C/Java
        (damp *=> dy) +=> y;      // y += (dy *= damp);  // in C/Java
    }
}

// Define your sound making objects here
SndBuf ballSound => Pan2 pan => dac;
SndBuf pegSound => dac;
me.dir()+"piano_d.wav" => ballSound.read;
ballSound.samples() => ballSound.pos;
me.dir()+"single_note.wav" => pegSound.read;
pegSound.samples() => pegSound.pos;

Ball ball; // moving ball
Ball peg;  // rigid filled peg
0.0 => peg.x => peg.y => peg.dx => peg.dy;
drawPeg(0,peg);  // only have to do this once

now + 40::second => time then;  // run for 10 seconds

while (now < then)   {
    ball.doPhysics();
    drawBall(1,ball);
    if (checkLeftRightWalls(ball)) {
        ball.x => pan.pan;  // pan is set by position
        soundBall(ball.ax*ball.dy+ball.dx); 
        //I'm adding random numbers to change the gain
        ballSound.rate()+ball.dy => ballSound.rate;
        // changing the pitch
        Math.random2f(0.01,0.03) => ball.r;
        // changing the radius
    }
    if (checkTopBottomWalls(ball)) {
        ballSound.samples() => ballSound.pos;
        ball.ay => pan.pan;  
        // pan is set by position
        ball.dx*ballSound.rate()+ball.dy/ball.ay => ballSound.rate;
        //changing te rate by a complex nonsense relation!
        soundBall(ball.dy);
        Math.random2f(0.001,0.1) => ball.r;
        //change radius
        Math.random2f(-0.001,0.01) => ball.ay;
        //change accelration
    }   
    if (checkBallPegCollide(ball,peg)) {
        soundPeg(ball.dx+ball.dy-ball.ay);
        Math.random2f(0.03,0.3) => ball.r;
        //change radius
        Math.random2f(-0.009,0.02) => ball.ax;
        // change acceleration

    }
    33*ms => now;  // 30 frames (roughly) per second
}

chout <= "Exit\n";   // send exit signal to GL Viewer
chout.flush();

fun void drawBall(int which,Ball bl)  {
    chout <= "b"+which+" "+bl.x+" "+bl.y+" "+bl.r+"\n";   // draw a ball
    chout.flush();                  // make sure things don't linger in buffers
}

fun void drawPeg(int which, Ball pg)  {
    drawBall(which,pg);        // draw a ball, but
    chout <= "f"+which+" 1\n"; // then fill it in
    chout.flush();             // make sure things don't linger in buffers
}

fun int checkLeftRightWalls(Ball bl)  {
    if (bl.x < -(1.0-bl.r)) {  // check left limit in x
        3*bl.dx -=> bl.x;  // bounce off
        -1.1 *=> bl.dx;   // with velocity reflection
        Math.random2f(-0.001,0.001) => bl.ax;  // new random x force
        return 1;
    }
    else if (bl.x > (1.0-bl.r)) {  // check right limit in x
        3*bl.dx -=> bl.x;  // bounce off
        -0.9 *=> bl.dx;   // with velocity reflection
        Math.random2f(-0.001,0.001) => bl.ax;  // new random x force
        return 1;
    }
    else return 0;
}

fun int checkTopBottomWalls(Ball bl)  {
    if (bl.y > (1.0-bl.r)) {  // check top limit in y
        3*bl.dy -=> bl.y;  // bounce off
        -1 *=> bl.dy;   // with velocity reflection
        Math.random2f(-0.001,0.001) => bl.ay;  // new random y force
        return 1;
    }
    else if (bl.y < -(1.0-bl.r)) {  // check top limit in y
        3*bl.dy -=> bl.y;  // bounce off
        -1 *=> bl.dy;   // with velocity reflection
        Math.random2f(-0.001,0.001) => bl.ay;  // new random y force
        return 1;
    }
    else return 0;
}

fun float distance(Ball bl, Ball bl2)  {
    bl2.x - bl.x => float delx;
    bl2.y - bl.y => float dely;
    return Math.sqrt(delx*delx + dely*dely);
}

fun int checkBallPegCollide(Ball bl, Ball pg)  {
    if (distance(bl,pg) < bl.r+pg.r)  {  // collision!!
        3*bl.dy -=> bl.y;  // bounce off
        -0.1 *=> bl.dy;   // with velocity reflection and great loss
        3*bl.dx -=> bl.x;  // bounce off
        -0.5 *=> bl.dx;   // with velocity reflection and great loss

        // the peg has magical powers!!!
        Math.random2f(-0.001,0.01) => bl.ax; // new random forces
        Math.random2f(-0.01,0.001) => bl.ay; //  after collision
        return 1;
    }
    else return 0;
}

fun void soundPeg(float vel)  {
    0.1+vel => pegSound.gain;
    0.8 + vel*2.0 => pegSound.rate;
    0 => pegSound.pos;
}

fun void soundBall(float vel)  {
    0.1+vel => ballSound.gain;
    0.8 + vel*2.0 => ballSound.rate;
    0 => ballSound.pos;
}
