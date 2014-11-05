package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

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
