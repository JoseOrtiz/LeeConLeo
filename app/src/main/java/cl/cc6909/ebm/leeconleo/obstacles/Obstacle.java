package cl.cc6909.ebm.leeconleo.obstacles;

import android.content.Context;

import cl.cc6909.ebm.leeconleo.Vector2D;

public class Obstacle {
    private Vector2D position;
    private Vector2D velocity;
    private Square obstacle;
    private long time;

    public Obstacle(Context context, long time){
        position = new Vector2D(1.1f,-0.72f);
        velocity = new Vector2D(-0.8f,0f);
        this.time = time;
        this.obstacle = new Square(position,0.1f,0.3f, new float[]{1.f,0.5f,0.2f,1.0f});
    }

    public void move(long dt){
        position = Vector2D.add(position, Vector2D.multiply(dt/1000f, velocity));
        if(position.getX()<-1.5f){
            if(Math.random()>0.5) {
                position = new Vector2D(1.1f, -0.72f);
            }else {
                position = new Vector2D(1.1f, -0.1f);
            }
        }
        obstacle.updatePosition(position);
    }

    public void draw(float mvpMatrix[],long current){
        long dt = current - time;
        move(dt);
        time=current;
        obstacle.draw(mvpMatrix);
    }

    public Vector2D getPosition(){
        return position;
    }
}
