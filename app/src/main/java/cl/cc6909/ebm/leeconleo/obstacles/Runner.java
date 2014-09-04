package cl.cc6909.ebm.leeconleo.obstacles;

import android.content.Context;
import android.os.SystemClock;

import cl.cc6909.ebm.leeconleo.R;

public class Runner {
    private Vector2D position;
    private Vector2D velocity;
    private boolean jumping, crouching;
    private long startCrouch;
    private final long crouchingTime = 1;
    private final Vector2D gravity = new Vector2D(0f,-0.8f);
    private Sprite runner, jumper;
    private long time;

    public Runner(Context context, long time){
        position = new Vector2D(-0.72f,-0.72f);
        velocity = new Vector2D(0f,0f);
        jumping = false;
        crouching = false;
        runner = new Sprite(context, position,0.4f,0.5f, 5, 3, R.drawable.running_2, 3);
        jumper = new Sprite(context, position,0.4f,0.5f, 7, 1, R.drawable.jumping, 12);
        this.time = time;
    }

    public void move(long dt){
        if(jumping) {
            velocity = Vector2D.add(velocity, Vector2D.multiply(dt/1000f, gravity));
        }
        if(crouching && dt-startCrouch>crouchingTime){
            crouching = false;
        }
        position = Vector2D.add(position, Vector2D.multiply(dt/1000f, velocity));
        if(position.getY()<-0.72f){
            position = new Vector2D(-0.72f, -0.72f);
            velocity = new Vector2D(0f,0f);
            jumping = false;
        }
        if(jumping){
            jumper.setLeftDown(position);
        }
        runner.setLeftDown(position);
    }

    public void jump(){
        if(!jumping && !crouching) {
            jumping = true;
            velocity = Vector2D.add(velocity, new Vector2D(0, 1f));
        }
    }

    public void crouch(){
        if(!jumping && !crouching) {
            crouching = true;
            startCrouch = SystemClock.uptimeMillis();
        }
    }

    public void draw(float mvpMatrix[],long current){
        long dt = current - time;
        move(dt);
        time=current;
        if(jumping){
            jumper.draw(mvpMatrix);
        }
        else {
            runner.draw(mvpMatrix);
        }
    }

    public Vector2D getPosition(){
        return position;
    }

}
