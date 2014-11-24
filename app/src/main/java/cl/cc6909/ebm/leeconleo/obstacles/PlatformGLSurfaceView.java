package cl.cc6909.ebm.leeconleo.obstacles;

import android.content.Context;
import android.opengl.GLSurfaceView;
import android.util.AttributeSet;

import cl.cc6909.ebm.leeconleo.SwipeInterface;

public class PlatformGLSurfaceView extends GLSurfaceView implements SwipeInterface{
    private PlatformRenderer mRenderer;

    public PlatformGLSurfaceView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }
    public PlatformGLSurfaceView(Context context) {
        super(context);
        init(context);
    }

    private void init(Context context){
        mRenderer = new PlatformRenderer(context);
        setEGLContextClientVersion(2);
        setRenderer(mRenderer);
        //setRenderMode(GLSurfaceView.RENDERMODE_WHEN_DIRTY);
        requestFocus();
    }
    public void pause() {
        super.onPause();
        mRenderer.onPause();
    }

    public void resume(){
        super.onResume();
        mRenderer.onResume();
    }



    public void onDestroy() {
        mRenderer.onDestroy();
    }

    @Override
    public void onSwipeLeft() {

    }

    @Override
    public void onSwipeRight() {

    }

    public void onSwipeUp() {
        mRenderer.onSwipeUp();
    }

    public void onSwipeDown() {
        mRenderer.onSwipeDown();
    }
}
