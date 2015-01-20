package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.AnimationDrawable;
import android.graphics.drawable.GradientDrawable;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.RelativeLayout;

import com.github.amlcurran.showcaseview.OnShowcaseEventListener;
import com.github.amlcurran.showcaseview.ShowcaseView;

import cl.cc6909.ebm.leeconleo.R;
import cl.cc6909.ebm.leeconleo.ShowcaseManager;

public class PaintActivity extends Activity implements View.OnClickListener{

    PaintView pw;
    String letter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_paint);
        pw = (PaintView) findViewById(R.id.paint_surface);
        pw.setDrawingCacheEnabled(true);
        letter = getIntent().getStringExtra("letter");
        AutoResizeTextView background = (AutoResizeTextView) findViewById(R.id.paint_background);
        Typeface tf = Typeface.createFromAsset(getAssets(), "fonts/arialic_hollow.ttf");
        background.setText(letter);
        background.setTypeface(tf);
        /*InputStream inputStream;
        try {
            inputStream = getResources().getAssets().open("letters/" + letter.toUpperCase() + ".png");
            Drawable bitmap = Drawable.createFromStream(inputStream, null);
            if(Build.VERSION.SDK_INT >= 16 ) {
                pw.setBackground(bitmap);
            }else {
                pw.setBackgroundDrawable(bitmap);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }*/

        findViewById(R.id.back_button).setOnClickListener(this);
        adjustSizeOfPalette();
        setPalette();
        ShowcaseView showcaseView = new ShowcaseManager(this).showcasePaint();
        showcaseView.setOnShowcaseEventListener(new PaintShowcaseListener());
    }

    private void adjustSizeOfPalette() {
        final RelativeLayout palette = (RelativeLayout) findViewById(R.id.palette);

        ViewTreeObserver vto = palette.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int size = (int) Math.floor(findViewById(R.id.palette).getHeight() / 3);
                for(int i = 0; i<palette.getChildCount();++i) {
                    View child = palette.getChildAt(i);
                    child.getLayoutParams().height=size;
                    child.getLayoutParams().width=size;
                }
                ViewTreeObserver obs = palette.getViewTreeObserver();

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN)
                    obs.removeOnGlobalLayoutListener(this);
                else obs.removeGlobalOnLayoutListener(this);
            }

        });
    }

    private void setPalette() {
        RelativeLayout palette = (RelativeLayout) findViewById(R.id.palette);
        for(int i = 0; i<palette.getChildCount();++i){
            View child = palette.getChildAt(i);
            if(child.getBackground() instanceof GradientDrawable) {
                GradientDrawable background = (GradientDrawable) child.getBackground();
                background.setColor(Color.parseColor(child.getTag().toString()));
            }
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.back_button:
                finish();
                break;
        }
    }

    public void setColor(View view){
        pw.changeColor(Color.parseColor(view.getTag().toString()));
    }

    public void setEraser(View view){
        pw.setEraser();
    }

    private class PaintShowcaseListener implements OnShowcaseEventListener{

        @Override
        public void onShowcaseViewHide(ShowcaseView showcaseView) {
            AnimationDrawable background = (AnimationDrawable) showcaseView.getBackground();
            background.stop();
        }

        @Override
        public void onShowcaseViewDidHide(ShowcaseView showcaseView) {

        }

        @Override
        public void onShowcaseViewShow(ShowcaseView showcaseView) {

        }
    }

}
