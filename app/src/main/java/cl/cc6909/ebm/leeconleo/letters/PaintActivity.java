package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.ShapeDrawable;
import android.graphics.drawable.shapes.Shape;
import android.os.Build;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import java.io.IOException;
import java.io.InputStream;

import cl.cc6909.ebm.leeconleo.R;

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
        InputStream inputStream;
        try {
            inputStream = getResources().getAssets().open("letters/" + letter.toUpperCase() + ".png");
            Drawable bitmap = Drawable.createFromStream(inputStream, null);
            pw.setBackgroundDrawable(bitmap);
            pw.setBackground(bitmap);
        } catch (IOException e) {
            e.printStackTrace();
        }

        findViewById(R.id.back_button).setOnClickListener(this);
        adjustSizeOfPalette();
        setPalette();
    }

    private void adjustSizeOfPalette() {
        final RelativeLayout palette = (RelativeLayout) findViewById(R.id.palette);

        ViewTreeObserver vto = palette.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int height = (int) Math.floor(findViewById(R.id.palette).getHeight() / 3);
                for(int i = 0; i<palette.getChildCount();++i) {
                    View child = palette.getChildAt(i);
                    child.getLayoutParams().height=height;
                    child.getLayoutParams().width=height;
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

}
