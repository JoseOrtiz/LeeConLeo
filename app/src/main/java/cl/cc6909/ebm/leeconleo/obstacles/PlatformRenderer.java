package cl.cc6909.ebm.leeconleo.obstacles;

import android.content.Context;
import android.opengl.GLES20;
import android.opengl.GLSurfaceView;
import android.opengl.Matrix;
import android.os.Handler;
import android.os.SystemClock;
import android.util.Log;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import cl.cc6909.ebm.leeconleo.FeedbackDialog;
import cl.cc6909.ebm.leeconleo.Vector2D;

public class PlatformRenderer implements GLSurfaceView.Renderer{
    private static final String TAG = "PlatformRenderer";
    private final Context mActivityContext;
    private Background back;
    private Runner runner;
    private Obstacle obstacle;

    // mMVPMatrix is an abbreviation for "Model View Projection Matrix"
    private final float[] mMVPMatrix = new float[16];
    private final float[] mProjectionMatrix = new float[16];
    private final float[] mViewMatrix = new float[16];
    private final float[] mRotationMatrix = new float[16];
    private long time,pausedTime,pause;

    private FeedbackDialog pd;
    private Handler h1,h2;
    private Runnable r1,r2;
    private boolean checked, paused;


    public PlatformRenderer(Context activity) {
        this.mActivityContext = activity;

        h1 = new Handler();
        h2 = new Handler();
        pd = new FeedbackDialog(mActivityContext);
        r1 = new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                }
            }
        };

        checked = false;
        pausedTime=0;
        paused=false;

    }

    @Override
    public void onSurfaceCreated(GL10 gl, EGLConfig config) {
        GLES20.glClearColor(0.5f, 1f, 1f, 0f);
        time = SystemClock.uptimeMillis();
        back = new Background(time);
        runner = new Runner(mActivityContext, time);
        obstacle = new Obstacle(mActivityContext, time);
    }


    @Override
    public void onSurfaceChanged(GL10 gl, int width, int height) {
        GLES20.glViewport(0, 0, width, height);

        float ratio = (float) width / height;

        Matrix.frustumM(mProjectionMatrix, 0, -ratio, ratio, -1, 1, 3, 7);

    }

    @Override
    public void onDrawFrame(GL10 gl) {
        long current = SystemClock.uptimeMillis();
        current-=pausedTime;
        if(!paused) {
            if (current - time > 1000 / 30) {
                GLES20.glClearColor(0.5f, 1f, 1f, 0f);
                clearBuffers(true, true, true);

                back.draw(mMVPMatrix, current);
                runner.draw(mMVPMatrix, current);
                obstacle.draw(mMVPMatrix, current);
                checkCollision();
                time = current;
            }
        }else{
            if (current - time > 1000 / 30) {
                GLES20.glClearColor(0.5f, 1f, 1f, 0f);
                clearBuffers(true, true, true);
                back.draw(mMVPMatrix, current);
                time=current;
            }
        }

    }
    public void onPause(){
        /* Do stuff to pause the renderer */
        paused=true;
        pause=SystemClock.uptimeMillis();
    }

    public void onResume(){
        /* Do stuff to resume the renderer */
        pausedTime+=SystemClock.uptimeMillis()-pause;
        paused=false;
        time=pause;
    }

    private void checkCollision(){
        Vector2D runnerPosition= runner.getPosition();
        Vector2D obstaclePosition = obstacle.getPosition();
        float distanceX = runnerPosition.getX() - obstaclePosition.getX();
        if(distanceX<0.1f && distanceX>=0f && !checked){
            boolean good = false;
            checked = true;
            if (obstaclePosition.getY()<-0.3){
                if(runnerPosition.getY()>obstaclePosition.getY()+0.3f){
                    good = true;
                }
            }
            else {
                if(runnerPosition.getY()+0.5f<obstaclePosition.getY()){
                    good = true;
                }
            }
            final boolean finalGood = good;
            r2= new Runnable() {
                @Override
                public void run() {
                    h2.post(new Runnable() { // This thread runs in the UI
                        @Override
                        public void run() {
                            if(finalGood){
                                pd.setGoodFeedback();
                            }
                            else {
                                pd.setBadFeedback();
                            }
                            pd.show();
                            h1.postDelayed(r1, 1000);
                        }
                    });
                }
            };
            new Thread(r2).start();
        }
        else {
            checked = false;
        }
    }

    public void clearBuffers(boolean color, boolean depth, boolean stencil) {
        int bits = 0;
        if (color) {
            bits = GLES20.GL_COLOR_BUFFER_BIT;
        }
        if (depth) {
            bits |= GLES20.GL_DEPTH_BUFFER_BIT;
        }
        if (stencil) {
            bits |= GLES20.GL_STENCIL_BUFFER_BIT;
        }
        if (bits != 0) {
            GLES20.glClear(bits);
        }
    }

    /**
     * Utility method for compiling a OpenGL shader.
     *
     * <p><strong>Note:</strong> When developing shaders, use the checkGlError()
     * method to debug shader coding errors.</p>
     *
     * @param type - Vertex or fragment shader type.
     * @param shaderCode - String containing the shader code.
     * @return - Returns an id for the shader.
     */
    public static int loadShader(int type, String shaderCode){

        // create a vertex shader type (GLES20.GL_VERTEX_SHADER)
        // or a fragment shader type (GLES20.GL_FRAGMENT_SHADER)
        int shader = GLES20.glCreateShader(type);

        // add the source code to the shader and compile it
        GLES20.glShaderSource(shader, shaderCode);
        GLES20.glCompileShader(shader);

        return shader;
    }
    /**
     * Utility method for debugging OpenGL calls. Provide the name of the call
     * just after making it:
     *
     * <pre>
     * mColorHandle = GLES20.glGetUniformLocation(mProgram, "vColor");
     * MyGLRenderer.checkGlError("glGetUniformLocation");</pre>
     *
     * If the operation is not successful, the check throws an error.
     *
     * @param glOperation - Name of the OpenGL call to check.
     */
    public static void checkGlError(String glOperation) {
        int error;
        while ((error = GLES20.glGetError()) != GLES20.GL_NO_ERROR) {
            Log.e(TAG, glOperation + ": glError " + error);
            throw new RuntimeException(glOperation + ": glError " + error);
        }
    }

    public void onSwipeUp(){
        runner.jump();
    }

    public void onSwipeDown(){
        runner.crouch();
    }

    public void onDestroy(){
        h1.removeCallbacks(r1);
        h2.removeCallbacks(r2);
        if (pd.isShowing() ) {
            pd.dismiss();
        }
    }
}
