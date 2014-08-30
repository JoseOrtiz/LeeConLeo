package cl.cc6909.ebm.leeconleo.obstacles;

import android.util.Log;

public class Background {
    private long time;
    private float[] rgb;
    private Square floor;
    private Triangle t;

    private Circle[] clouds;

    public Background(long time){
        this.time = time;
        float[] fFloor= new float[]{
                -1f,-0.3f,0f,
                -1f,-1f,0f,
                1f,-1f,0f,
                1f,-0.3f,0f
        };
        float[] fColor = new float[]{
                0.5f,0.1f,0.1f,1f
        };
        this.floor = new Square(fFloor,fColor);
        this.clouds = new Circle[1];

        this.clouds[0] = new Circle(0.2f,0.3f,0.2f,100,new float[]{1.0f,1.0f,1.0f,1.0f});

    }

    public void draw(float mvpMatrix[], long current){
        this.floor.draw(mvpMatrix);
        this.clouds[0].draw(mvpMatrix);
    }
}
