package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;

import cl.cc6909.ebm.leeconleo.obstacles.PlatformGLSurfaceView;

public class PlatformActivity extends Activity implements View.OnClickListener{

    private PlatformGLSurfaceView mGLSurfaceView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_platform);
        mGLSurfaceView = (PlatformGLSurfaceView) findViewById(R.id.platformSurface);
        findViewById(R.id.back_button).setOnClickListener(this);
        mGLSurfaceView.setOnTouchListener(new OnSwipeTouchListener(this,mGLSurfaceView));

        ViewTreeObserver vto = mGLSurfaceView.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int size = (int) Math.floor(findViewById(R.id.platformSurface).getWidth());
                ViewGroup.LayoutParams layoutParams = mGLSurfaceView.getLayoutParams();
                layoutParams.height= size;
                mGLSurfaceView.setLayoutParams(layoutParams);
                ViewTreeObserver obs = mGLSurfaceView.getViewTreeObserver();

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN)
                    obs.removeOnGlobalLayoutListener(this);
                else obs.removeGlobalOnLayoutListener(this);
            }

        });

    }
    @Override
    protected void onResume(){
        super.onResume();
        mGLSurfaceView.onResume();
    }
    @Override
    protected void onPause(){
        super.onPause();
        mGLSurfaceView.onPause();
    }

    @Override
    protected void onDestroy(){
        super.onDestroy();
        mGLSurfaceView.onDestroy();
    }

    @Override
    public void onClick(View v) {
        int click = v.getId();
        switch (click) {
            case R.id.back_button:
                finish();
                break;
        }
    }
}
