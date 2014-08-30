package cl.cc6909.ebm.leeconleo.obstacles;

import android.util.Log;

public class Square {
    private float squareCoords[];
    private float color[];

    private float triangleCoords1[], triangleCoords2[];
    static final int COORDS_PER_VERTEX = 3;
    private final short orderT1[] = { 0, 1, 2};
    private final short orderT2[] = { 0, 2, 3};

    private Triangle t1, t2;

    public Square(float squareCoords[], float color[]){
        this.squareCoords = squareCoords;
        this.color = color;

        this.triangleCoords1 = new float[COORDS_PER_VERTEX*3];
        this.triangleCoords2 = new float[COORDS_PER_VERTEX*3];
        for(int i=0;i<orderT1.length;++i){
            for(int j=0;j<COORDS_PER_VERTEX;++j){
                triangleCoords1[i*COORDS_PER_VERTEX+j] = squareCoords[COORDS_PER_VERTEX*orderT1[i]+j];
            }
        }
        for(int i=0;i<orderT2.length;++i){
            for(int j=0;j<COORDS_PER_VERTEX;++j){
                triangleCoords2[i*COORDS_PER_VERTEX+j] = squareCoords[COORDS_PER_VERTEX*orderT2[i]+j];
            }
        }
        t1 = new Triangle(triangleCoords1,color);
        t2 = new Triangle(triangleCoords2,color);
    }
    public void draw(float[] mvpMatrix) {
        t1.draw(mvpMatrix);
        t2.draw(mvpMatrix);
    }
}
