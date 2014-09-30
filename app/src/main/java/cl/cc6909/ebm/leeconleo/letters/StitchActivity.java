package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;

import cl.cc6909.ebm.leeconleo.R;

public class StitchActivity extends Activity{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_stitch);

        final StitchGLSurfaceView stitch = (StitchGLSurfaceView) findViewById(R.id.stitch_surface);

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
    }


    public void onBackButtonClicked(View view){
        finish();
    }
}
