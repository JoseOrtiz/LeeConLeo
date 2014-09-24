package cl.cc6909.ebm.leeconleo.obstacles;

import java.util.ArrayList;

import cl.cc6909.ebm.leeconleo.Vector2D;

public class Clouds {
    private Vector2D speed;
    private double count;
    private ArrayList<Circle> clouds;
    private Vector2D center;

    public Clouds(){
        clouds = new ArrayList<Circle>();
        reset();
    }

    public void reset(){
        center = new Vector2D((float) (1f+Math.random()*0.5f), (float) (0.60f+Math.random()/6f));
        speed = new Vector2D((float) (-0.1f*Math.random()),0f);
        count = Math.random()*3+3;
        float radius = 0.1f;
        float separation = 0;
        float [] color = new float[]{
                1f,1f,1f,1f
        };
        float coef = (float) (4*radius/(count*count));
        clouds.clear();
        for(int i=0;i<count;i++){
            clouds.add(new Circle(new Vector2D(center.getX()+separation,center.getY()), (float) (((count-1)*i-i*i)*coef+0.1f),100, color));
            separation+= (float) (((count-1)*i-i*i)*coef+0.1f);
        }
    }

    public void move(long dt){
        center = Vector2D.add(center,Vector2D.multiply(dt/1000f,speed));
        if(center.getX() < -1.5f-count*0.06f){
            reset();
        }
        for(int i=0;i<clouds.size();++i){
            Circle c = clouds.get(i);
            c.setCenter(Vector2D.add(c.getCenter(), Vector2D.multiply(dt/1000f, speed)));
            clouds.set(i, c);
        }
    }

    public void draw(float mvpMatrix[]){
        for(Circle c: clouds){
            if(c.getCenter().getX()<=1.2f) {
                c.draw(mvpMatrix);
            }
        }
    }
}
