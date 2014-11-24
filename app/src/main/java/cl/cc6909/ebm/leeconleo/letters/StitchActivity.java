package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.graphics.drawable.AnimationDrawable;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;

import com.github.amlcurran.showcaseview.OnShowcaseEventListener;
import com.github.amlcurran.showcaseview.ShowcaseView;

import cl.cc6909.ebm.leeconleo.R;
import cl.cc6909.ebm.leeconleo.ShowcaseManager;

public class StitchActivity extends Activity{
    StitchGLSurfaceView stitch;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_stitch);

         stitch= (StitchGLSurfaceView) findViewById(R.id.stitch_surface);

        ViewTreeObserver vto = stitch.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int width = (int) Math.floor(findViewById(R.id.stitch_surface).getWidth());
                ViewGroup.LayoutParams layoutParams = stitch.getLayoutParams();
                layoutParams.height=width;
                stitch.setLayoutParams(layoutParams);
                stitch.setDimension(width);
                ViewTreeObserver obs = stitch.getViewTreeObserver();

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN)
                    obs.removeOnGlobalLayoutListener(this);
                else obs.removeGlobalOnLayoutListener(this);
            }

        });
        ShowcaseView showcaseView = new ShowcaseManager(this).showcaseStitch();
    }


    public void onBackButtonClicked(View view){
        finish();
    }

    private class StitchShowcaseListener implements OnShowcaseEventListener{

        @Override
        public void onShowcaseViewHide(ShowcaseView showcaseView) {
            stitch.onResume();
            AnimationDrawable background = (AnimationDrawable) showcaseView.getBackground();
            background.stop();
        }

        @Override
        public void onShowcaseViewDidHide(ShowcaseView showcaseView) {

        }

        @Override
        public void onShowcaseViewShow(ShowcaseView showcaseView) {
            stitch.onPause();

        }
    }
}
