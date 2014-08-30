package cl.cc6909.ebm.leeconleo.obstacles;

import android.app.ActivityManager;
import android.content.Context;
import android.content.pm.ConfigurationInfo;
import android.graphics.PixelFormat;
import android.opengl.GLSurfaceView;
import android.util.AttributeSet;

public class PlatformGLSurfaceView extends GLSurfaceView{
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
        mRenderer = new PlatformRenderer();
        setEGLContextClientVersion(2);
        setRenderer(mRenderer);
        setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);
    }
    @Override
    public void onPause() {
        super.onPause();
        mRenderer.onPause();
    }

    @Override
    public void onResume() {
        super.onResume();
        mRenderer.onResume();
    }
}
