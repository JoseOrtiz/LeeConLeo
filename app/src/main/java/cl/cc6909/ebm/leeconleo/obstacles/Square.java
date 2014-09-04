package cl.cc6909.ebm.leeconleo.obstacles;

import android.opengl.GLES20;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.nio.ShortBuffer;

public class Square {
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
    private ShortBuffer drawListBuffer;
    private FloatBuffer vertexBuffer;
    private final int mProgram;
    private int mColorHandle;
    private int mPositionHandle;
    private float sizeX, sizeY;
    private float squareCoords[];
    private float color[];

    private Vector2D leftDown;
    static final int COORDS_PER_VERTEX = 3;
    private int vertexCount;
    private int vertexStride = COORDS_PER_VERTEX * 4; // 4 bytes per vertex
    private final short drawOrder[] = {0, 1, 2, 0, 2, 3};

    public Square(Vector2D leftDown, float sizeX, float sizeY, float color[]){
        this.leftDown = leftDown;
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        this.color = color;
        updateCoords();
        vertexCount = squareCoords.length / COORDS_PER_VERTEX;
        mProgram = GLES20.glCreateProgram();             // create empty OpenGL Program


        // prepare shaders and OpenGL program
        int vertexShader = PlatformRenderer.loadShader(
                GLES20.GL_VERTEX_SHADER, vertexShaderCode);
        int fragmentShader = PlatformRenderer.loadShader(
                GLES20.GL_FRAGMENT_SHADER, fragmentShaderCode);

        GLES20.glAttachShader(mProgram, vertexShader);   // add the vertex shader to program
        GLES20.glAttachShader(mProgram, fragmentShader); // add the fragment shader to program
        GLES20.glLinkProgram(mProgram);                  // create OpenGL program executables
    }

    private void updateCoords() {
        float x = leftDown.getX();
        float y = leftDown.getY();
        this.squareCoords = new float[]{
                x,y,0f,
                x+sizeX,y,0f,
                x+sizeX,y+sizeY,0f,
                x,y+sizeY,0f
        };
    }

    public void updatePosition(Vector2D leftDown){
        this.leftDown = leftDown;
        updateCoords();
    }
    public void draw(float[] mvpMatrix) {

        ByteBuffer bb = ByteBuffer.allocateDirect(
                // (# of coordinate values * 4 bytes per float)
                squareCoords.length * 4);
        bb.order(ByteOrder.nativeOrder());
        vertexBuffer = bb.asFloatBuffer();
        vertexBuffer.put(squareCoords);
        vertexBuffer.position(0);

        // initialize byte buffer for the draw list
        ByteBuffer dlb = ByteBuffer.allocateDirect(
                // (# of coordinate values * 2 bytes per short)
                drawOrder.length * 4);
        dlb.order(ByteOrder.nativeOrder());
        drawListBuffer = dlb.asShortBuffer();
        drawListBuffer.put(drawOrder);
        drawListBuffer.position(0);

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
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_FAN, 0, vertexCount);

        // Disable vertex array
        GLES20.glDisableVertexAttribArray(mPositionHandle);

    }
}
