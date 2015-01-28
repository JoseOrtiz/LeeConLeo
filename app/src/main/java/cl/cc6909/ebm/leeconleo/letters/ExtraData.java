package cl.cc6909.ebm.leeconleo.letters;

import android.opengl.GLES20;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.util.Vector;

import cl.cc6909.ebm.leeconleo.Vector2D;

public class ExtraData {
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
    private float[] coords;
    private int mPositionHandle;
    private int mColorHandle;

    public ExtraData() {
        mProgram = GLES20.glCreateProgram();             // create empty OpenGL Program

        coords = new float[]{-0.15f,0.3f,0.0f,0.25f,0.3f,0.0f};
        vertexCount = coords.length/ COORDS_PER_VERTEX;

        color = new float[]{0f,0f,1f,1f};
        // prepare shaders and OpenGL program
        int vertexShader = StitchRenderer.loadShader(
                GLES20.GL_VERTEX_SHADER, vertexShaderCode);
        int fragmentShader = StitchRenderer.loadShader(
                GLES20.GL_FRAGMENT_SHADER, fragmentShaderCode);

        GLES20.glAttachShader(mProgram, vertexShader);   // add the vertex shader to program
        GLES20.glAttachShader(mProgram, fragmentShader); // add the fragment shader to program
        GLES20.glLinkProgram(mProgram);                  // create OpenGL program executables
    }

    public void draw() {
        ByteBuffer bb = ByteBuffer.allocateDirect(
                // (# of coordinate values * 4 bytes per float)
                coords.length* 4);
        bb.order(ByteOrder.nativeOrder());
        vertexBuffer = bb.asFloatBuffer();
        vertexBuffer.put(coords);
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

        // Draw the line
        GLES20.glLineWidth(6f);
        GLES20.glDrawArrays(GLES20.GL_LINE_STRIP, 0, vertexCount);
        GLES20.glLineWidth(1f);

        // Disable vertex array
        GLES20.glDisableVertexAttribArray(mPositionHandle);
    }
}
