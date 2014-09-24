package cl.cc6909.ebm.leeconleo.obstacles;

import android.opengl.GLES20;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

import cl.cc6909.ebm.leeconleo.Vector2D;

public class Circle {

    private float radius;
    private Vector2D center;
    private int mProgram, mPositionHandle, mColorHandle, mMVPMatrixHandle, points ;
    private FloatBuffer mVertexBuffer;
    private float vertices[];
    private float color[];

    private final String vertexShaderCode =
                    "attribute vec4 vPosition;" +
                    "void main() {" +
                    "  gl_Position = vPosition;" +
                    "}";

    private final String fragmentShaderCode =
            "precision mediump float;" +
                    "uniform vec4 vColor;" +
                    "void main() {" +
                    "  gl_FragColor = vColor;" +
                    "}";

    public Circle(Vector2D center, float radius, int points, float[] color){
        this.vertices = new float[points*3];
        this.color = color;
        this.points = points;
        this.radius = radius;
        this.center = center;
        updateVertex();

        int vertexShader = PlatformRenderer.loadShader(GLES20.GL_VERTEX_SHADER, vertexShaderCode);
        int fragmentShader = PlatformRenderer.loadShader(GLES20.GL_FRAGMENT_SHADER, fragmentShaderCode);

        mProgram = GLES20.glCreateProgram();
        GLES20.glAttachShader(mProgram, vertexShader);
        GLES20.glAttachShader(mProgram, fragmentShader);
        GLES20.glLinkProgram(mProgram);

    }

    private void updateVertex() {
        vertices[0] = center.getX();
        vertices[1] = center.getY();
        vertices[2] = 0.0f;

        for(int i =0; i <points-1; i++){
            vertices[((i+1) * 3)+ 0] = (float) (radius * Math.cos(2*(Math.PI/(points-2)) * (float)(i) )) + vertices[0];
            vertices[((i+1) * 3)+ 1] = (float) (radius * Math.sin(2*(Math.PI/(points-2)) * (float)(i) )) + vertices[1];
            vertices[((i+1) * 3)+ 2] = vertices[2];
        }
    }

    public void setCenter(Vector2D center){
        this.center = center;
        updateVertex();
    }
    public Vector2D getCenter(){
        return center;
    }

    public void draw (float[] mvpMatrix){
        ByteBuffer vertexByteBuffer = ByteBuffer.allocateDirect(vertices.length * 4);
        vertexByteBuffer.order(ByteOrder.nativeOrder());
        mVertexBuffer = vertexByteBuffer.asFloatBuffer();
        mVertexBuffer.put(vertices);
        mVertexBuffer.position(0);

        GLES20.glUseProgram(mProgram);

        mPositionHandle = GLES20.glGetAttribLocation(mProgram, "vPosition");

        GLES20.glEnableVertexAttribArray(mPositionHandle);

        GLES20.glVertexAttribPointer(mPositionHandle, 3, GLES20.GL_FLOAT, false, 12, mVertexBuffer);

        mColorHandle = GLES20.glGetUniformLocation(mProgram, "vColor");

        GLES20.glUniform4fv(mColorHandle, 1, color, 0);

        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_FAN, 0, points);

        GLES20.glDisableVertexAttribArray(mPositionHandle);
    }

}
