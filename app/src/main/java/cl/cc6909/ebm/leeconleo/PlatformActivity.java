package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.app.ActivityManager;
import android.content.Context;
import android.content.pm.ConfigurationInfo;
import android.graphics.PixelFormat;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import cl.cc6909.ebm.leeconleo.obstacles.PlatformGLSurfaceView;
import cl.cc6909.ebm.leeconleo.obstacles.PlatformRenderer;
import cl.cc6909.ebm.leeconleo.obstacles.Vector2D;

public class PlatformActivity extends Activity implements View.OnClickListener {

    private PlatformGLSurfaceView mGLSurfaceView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_platform);
        mGLSurfaceView = new PlatformGLSurfaceView(this);
        LinearLayout platform = (LinearLayout) findViewById(R.id.gamePlatformLayout);
        platform.addView(mGLSurfaceView);
        ((ImageView)findViewById(R.id.back_button)).setOnClickListener(this);

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
    public void onClick(View v) {
        int click = v.getId();
        switch (click) {
            case R.id.back_button:
                finish();
                break;
        }
    }
}
