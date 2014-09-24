package cl.cc6909.ebm.leeconleo.letters;

import android.opengl.GLES20;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.util.ArrayList;
import java.util.Vector;

import cl.cc6909.ebm.leeconleo.Vector2D;
public class Contour {
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
    private final int mProgram;
    private final float[] color;
    private FloatBuffer vertexBuffer;

    static final int COORDS_PER_VERTEX = 3;
    private int vertexCount;
    private int vertexStride = COORDS_PER_VERTEX * 4;
    private Vector<Vector2D> center;
    private float[] centerCoords;
    private int mPositionHandle;
    private int mColorHandle;

    public Contour(Vector2D initial){
        center = new Vector<Vector2D>();
        center.add(initial);
        mProgram = GLES20.glCreateProgram();             // create empty OpenGL Program

        color = new float[]{0f,0f,0f,1f};
        // prepare shaders and OpenGL program
        int vertexShader = StitchRenderer.loadShader(
                GLES20.GL_VERTEX_SHADER, vertexShaderCode);
        int fragmentShader = StitchRenderer.loadShader(
                GLES20.GL_FRAGMENT_SHADER, fragmentShaderCode);

        GLES20.glAttachShader(mProgram, vertexShader);   // add the vertex shader to program
        GLES20.glAttachShader(mProgram, fragmentShader); // add the fragment shader to program
        GLES20.glLinkProgram(mProgram);                  // create OpenGL program executables
    }

    public void makeVertex(){
        Vector2D last = center.lastElement();
        Vector2D arrow = Vector2D.subtract(last, center.elementAt(center.size() - 2));
        Vector2D norm = Vector2D.multiply(0.05f,Vector2D.norm(new Vector2D(-1 * arrow.getY(), arrow.getX())));
        ArrayList<Float> listCoords = new ArrayList<Float>();
        for(Vector2D v: center){
            listCoords.add(v.getX());
            listCoords.add(v.getY());
            listCoords.add(0f);
        }
        Vector2D tail = Vector2D.multiply(0.05f, Vector2D.norm(arrow));
        listCoords.add(last.getX()+norm.getX()-tail.getX());
        listCoords.add(last.getY()+norm.getY()-tail.getY());
        listCoords.add(0f);
        listCoords.add(last.getX());
        listCoords.add(last.getY());
        listCoords.add(0f);
        listCoords.add(last.getX()-norm.getX()-tail.getX());
        listCoords.add(last.getY()-norm.getY()-tail.getY());
        listCoords.add(0f);
        centerCoords = new float[listCoords.size()];
        int i=0;
        for(Float f: listCoords){
            centerCoords[i++]=(f != null? f:Float.NaN);
        }

        vertexCount = centerCoords.length/ COORDS_PER_VERTEX;
    }

    public void draw(){
        ByteBuffer bb = ByteBuffer.allocateDirect(
                // (# of coordinate values * 4 bytes per float)
                centerCoords.length* 4);
        bb.order(ByteOrder.nativeOrder());
        vertexBuffer = bb.asFloatBuffer();
        vertexBuffer.put(centerCoords);
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
        GLES20.glDrawArrays(GLES20.GL_LINE_STRIP, 0, vertexCount);

        // Disable vertex array
        GLES20.glDisableVertexAttribArray(mPositionHandle);
    }

    public void addCenter(Vector2D vector){
        center.add(vector);
        makeVertex();
    }
}
