package cl.cc6909.ebm.leeconleo.letters;

import android.opengl.GLES20;
import android.util.Log;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.util.Vector;

import cl.cc6909.ebm.leeconleo.Vector2D;


public class Stitch {
    private final String vertexShaderCode =
            "attribute vec4 aPosition;              \n"
                    +   "void main() {                          \n"
                    +   " gl_Position = aPosition;              \n"
                    +   "}                                      \n";

    private final String fragmentShaderCode =
            "precision mediump float;"
                    + "uniform vec4 vColor;"
                    + "void main() {                          \n"
                    +   " gl_FragColor = vColor;         \n"
                    +   "}                                      \n";
    private FloatBuffer vertexBuffer;
    private final int mProgram;
    private float color[];

    private float stitchCoords1[];
    private float stitchCoords2[];

    static final int COORDS_PER_VERTEX = 3;
    private int vertexCount1, vertexCount2;
    private int vertexStride = COORDS_PER_VERTEX * 4;
    private Vector2D[] vectors, initial;
    private Vector2D center;
    private int mPositionHandle;
    private int mColorHandle;


    public Stitch(Vector2D v1, Vector2D v2){
        initial = new Vector2D[]{v1,v2};
        vectors = new Vector2D[]{v1,v2};
        center = Vector2D.add(v1,Vector2D.multiply(0.5f,Vector2D.subtract(v2,v1)));
        makeStitches();
        vertexCount1 = stitchCoords1.length / COORDS_PER_VERTEX;
        vertexCount2 = stitchCoords2.length / COORDS_PER_VERTEX;
        mProgram = GLES20.glCreateProgram();             // create empty OpenGL Program

        color = new float[]{0.5f,0.5f,0.7f,1f};
        // prepare shaders and OpenGL program
        int vertexShader = StitchRenderer.loadShader(
                GLES20.GL_VERTEX_SHADER, vertexShaderCode);
        int fragmentShader = StitchRenderer.loadShader(
                GLES20.GL_FRAGMENT_SHADER, fragmentShaderCode);

        GLES20.glAttachShader(mProgram, vertexShader);   // add the vertex shader to program
        GLES20.glAttachShader(mProgram, fragmentShader); // add the fragment shader to program
        GLES20.glLinkProgram(mProgram);                  // create OpenGL program executables
    }

    public void makeStitches(){
        Vector2D norm = Vector2D.multiply(0.1f,Vector2D.norm(Vector2D.subtract(initial[1], initial[0])));
        Vector2D normal = new Vector2D(-1*norm.getY(), norm.getX());
        stitchCoords1 = new float[]{
                vectors[0].getX(), vectors[0].getY(),0f,
                vectors[0].getX()+norm.getX()+normal.getX(), vectors[0].getY()+norm.getY()+normal.getY(),0f,
                vectors[0].getX()-norm.getX()+normal.getX(), vectors[0].getY()-norm.getY()+normal.getY(),0f,
                vectors[0].getX()-norm.getX()-normal.getX(), vectors[0].getY()-norm.getY()-normal.getY(),0f,
                vectors[0].getX()+norm.getX()-normal.getX(), vectors[0].getY()+norm.getY()-normal.getY(),0f
        };
        stitchCoords2 = new float[]{
                vectors[1].getX()-norm.getX(), vectors[1].getY()-norm.getY(),0f,
                vectors[1].getX()+normal.getX(), vectors[1].getY()+normal.getY(),0f,
                vectors[1].getX()+norm.getX()+normal.getX(), vectors[1].getY()+norm.getY()+normal.getY(),0f,
                vectors[1].getX()+norm.getX()-normal.getX(), vectors[1].getY()+norm.getY()-normal.getY(),0f,
                vectors[1].getX()-normal.getX(), vectors[1].getY()-normal.getY(),0f,

        };
    }

    public void draw() {
        draw1();
        draw2();

    }
    public void drawActive(){
        color = new float[]{0.5f,0.9f,0.5f,1f};
        draw();
        color = new float[]{0.3f,0.3f,0.3f,0.8f};
    }
    public void draw1(){
        ByteBuffer bb = ByteBuffer.allocateDirect(
                // (# of coordinate values * 4 bytes per float)
                stitchCoords1.length * 4);
        bb.order(ByteOrder.nativeOrder());
        vertexBuffer = bb.asFloatBuffer();
        vertexBuffer.put(stitchCoords1);
        vertexBuffer.position(0);

        mPositionHandle = GLES20.glGetAttribLocation(mProgram, "aPosition");
        // Add program to OpenGL environment
        GLES20.glUseProgram(mProgram);

        // Prepare the triangle coordinate data
        GLES20.glVertexAttribPointer(
                mPositionHandle, COORDS_PER_VERTEX,
                GLES20.GL_FLOAT, false,
                vertexStride, vertexBuffer);
        // Enable a handle to the triangle vertices
        GLES20.glEnableVertexAttribArray(mPositionHandle);

        // get handle to fragment shader's vColor member
        mColorHandle = GLES20.glGetUniformLocation(mProgram, "vColor");

        // Set color for drawing the triangle
        GLES20.glUniform4fv(mColorHandle, 1, color, 0);

        // Draw the triangle
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_FAN, 0, vertexCount1);

        // Disable vertex array
        //GLES20.glDisableVertexAttribArray(mPositionHandle);

        //border
        // get handle to fragment shader's vColor member
        mColorHandle = GLES20.glGetUniformLocation(mProgram, "vColor");

        // Set color for drawing the triangle
        GLES20.glUniform4fv(mColorHandle, 1, new float[]{0f,0f,0f,1f}, 0);

        // Draw the triangle
        GLES20.glDrawArrays(GLES20.GL_LINE_LOOP, 0, vertexCount1);

        // Disable vertex array
        GLES20.glDisableVertexAttribArray(mPositionHandle);
    }
    public void draw2(){

        ByteBuffer bb = ByteBuffer.allocateDirect(
                // (# of coordinate values * 4 bytes per float)
                stitchCoords2.length * 4);
        bb.order(ByteOrder.nativeOrder());
        vertexBuffer = bb.asFloatBuffer();
        vertexBuffer.put(stitchCoords2);
        vertexBuffer.position(0);

        mPositionHandle = GLES20.glGetAttribLocation(mProgram, "aPosition");
        // Add program to OpenGL environment
        GLES20.glUseProgram(mProgram);

        // Prepare the triangle coordinate data
        GLES20.glVertexAttribPointer(
                mPositionHandle, COORDS_PER_VERTEX,
                GLES20.GL_FLOAT, false,
                vertexStride, vertexBuffer);
        // Enable a handle to the triangle vertices
        GLES20.glEnableVertexAttribArray(mPositionHandle);

        // get handle to fragment shader's vColor member
        mColorHandle = GLES20.glGetUniformLocation(mProgram, "vColor");

        // Set color for drawing the triangle
        GLES20.glUniform4fv(mColorHandle, 1, color, 0);

        // Draw the triangle
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_FAN, 0, vertexCount2);

        // Disable vertex array
        //GLES20.glDisableVertexAttribArray(mPositionHandle);

        //border
        // get handle to fragment shader's vColor member
        mColorHandle = GLES20.glGetUniformLocation(mProgram, "vColor");

        // Set color for drawing the triangle
        GLES20.glUniform4fv(mColorHandle, 1, new float[]{0f,0f,0f,1f}, 0);

        // Draw the triangle
        GLES20.glDrawArrays(GLES20.GL_LINE_LOOP, 0, vertexCount1);

        // Disable vertex array
        GLES20.glDisableVertexAttribArray(mPositionHandle);
    }

    public Vector2D getStitch(int index){
        return vectors[index];
    }

    public void moveStitch(Vector2D newPosition, int index) {
        if(index<0 || index > 1) return;
        Vector2D movement = Vector2D.multiply(0.1f,Vector2D.norm(Vector2D.subtract(center,initial[index])));
        Vector2D normal = Vector2D.norm(Vector2D.subtract(initial[index],center));
        Vector2D remaining = Vector2D.subtract(newPosition, center);
        //Vector2D distance = Vector2D.subtract(center,vectors[index]);
        Vector2D moved = Vector2D.subtract(newPosition, initial[index]);
        Vector2D proj = Vector2D.multiply(Vector2D.dot(moved, movement) / (movement.scalar() * movement.scalar()), movement);
        if(movement.getX()*proj.getX()<0) proj.setX(0f);
        if(movement.getY()*proj.getY()<0) proj.setY(0f);
        vectors[index] = Vector2D.add(initial[index],proj);
        if(Vector2D.distance(vectors[index],center)<0.11f || Vector2D.dot(normal,remaining)<0){
            vectors[index]=center;
        }
        makeStitches();
    }

    public boolean checkCompleted(){
        return Vector2D.distance(vectors[0],vectors[1])==0.0f;
    }

    public Vector2D getCenter(){
        return center;
    }

    public int getStitchNumber(Vector2D v){
        Vector2D norm[] = new Vector2D[2];
        norm[0] = Vector2D.multiply(0.1f,Vector2D.norm(Vector2D.subtract(initial[0],center)));
        norm[1] = Vector2D.multiply(0.1f,Vector2D.norm(Vector2D.subtract(initial[1],center)));
        Vector2D subtract1 = Vector2D.subtract(v, vectors[1]);
        Vector2D subtract0 = Vector2D.subtract(v, vectors[0]);
        Vector2D proj1 = Vector2D.multiply(Vector2D.dot(subtract1,norm[1])/(norm[1].scalar()*norm[1].scalar()),norm[1]);
        Vector2D proj0 = Vector2D.multiply(Vector2D.dot(subtract0,norm[0])/(norm[0].scalar()*norm[0].scalar()),norm[0]);
        if(Vector2D.dot(proj0,norm[0])>0 && subtract0.scalar()<0.7){
            return 0;
        }
        if(Vector2D.dot(proj1,norm[1])>0 && subtract1.scalar()<0.7){
            return 1;
        }
        return -1;

    }
}

