package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.AnimationDrawable;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;

import com.github.amlcurran.showcaseview.OnShowcaseEventListener;
import com.github.amlcurran.showcaseview.ShowcaseView;

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
        ShowcaseView showcaseView = new ShowcaseManager(this).showcasePlatform();
        showcaseView.setOnShowcaseEventListener(new PlatformShowcaseListener());

        Intent objIntent = new Intent(this, BackgroundSound.class);
        startService(objIntent);
        mGLSurfaceView.pause();
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
        Intent objIntent = new Intent(this, BackgroundSound.class);
        stopService(objIntent);
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
    private class PlatformShowcaseListener implements OnShowcaseEventListener{

        @Override
        public void onShowcaseViewHide(ShowcaseView showcaseView) {
            AnimationDrawable background = (AnimationDrawable) showcaseView.getBackground();
            background.stop();
            mGLSurfaceView.resume();

        }

        @Override
        public void onShowcaseViewDidHide(ShowcaseView showcaseView) {
            //mGLSurfaceView.onResume();

        }

        @Override
        public void onShowcaseViewShow(ShowcaseView showcaseView) {
            mGLSurfaceView.pause();
        }
    }
}
