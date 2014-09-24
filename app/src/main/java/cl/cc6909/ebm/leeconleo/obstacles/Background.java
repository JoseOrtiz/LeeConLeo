package cl.cc6909.ebm.leeconleo.obstacles;

import java.util.Vector;

import cl.cc6909.ebm.leeconleo.Vector2D;

public class Background {
    private long time;
    private Square[] floor;

    private Vector<Clouds> clouds;
    private Circle sun;

    public Background(long time){
        this.time = time;
        this.clouds = new Vector<Clouds>();
        for(int i=0;i<3;++i){
            clouds.add(new Clouds());
        }
        this.floor = new Square[3];
        this.sun = new Circle(new Vector2D(0.6f,0.7f),0.15f,100,new float[]{1f,1f,0f,1f});
    }

    public void draw(float mvpMatrix[], long current){
        drawFloor(mvpMatrix,current);
        sun.draw(mvpMatrix);
        drawClouds(mvpMatrix,current);
    }

    public void drawFloor(float mvpMatrix[], long current){
        float[] fColor = new float[]{
                0.5f,0.1f,0.1f,1f
        };
        this.floor[0] = new Square(new Vector2D(-1f,-1f),2f,0.7f,fColor);
        fColor = new float[]{
                1f,1f,1f,1f
        };
        this.floor[1] = new Square(new Vector2D(-1f,-0.51f),2f,0.01f,fColor);
        this.floor[2] = new Square(new Vector2D(-1f,-0.76f),2f,0.01f,fColor);
        for(Square s:floor){
            s.draw(mvpMatrix);
        }
    }

    public void drawClouds(float mvpMatrix[], long current){
        for(Clouds c: clouds){
            c.move((current-time));
            c.draw(mvpMatrix);
        }
        time=current;
    }
}
