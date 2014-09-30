package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TableLayout;
import android.widget.TableRow;

import cl.cc6909.ebm.leeconleo.FeedbackDialog;
import cl.cc6909.ebm.leeconleo.R;

public class RecognitionActivity extends Activity {

    protected String letter;
    protected Handler h;
    protected FeedbackDialog pd;
    protected Runnable r;
    protected Image[] picture;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recognition);
        h = new Handler();
        pd = new FeedbackDialog(this);
        r =new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                }
            }
        };
        letter = getIntent().getStringExtra("letter");
        final AutoResizeTextView printed= (AutoResizeTextView) findViewById(R.id.printed);

        ViewTreeObserver vto = printed.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int height = (int) Math.floor(printed.getHeight());
                ViewGroup.LayoutParams layoutParams = printed.getLayoutParams();
                printed.setLayoutParams(layoutParams);
                printed.setText(letter.toLowerCase());
                printed.setTextSize(height);
                printed.setTextColor(Color.BLUE);
                printed.setIncludeFontPadding(false);

                ViewTreeObserver obs = printed.getViewTreeObserver();

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN)
                    obs.removeOnGlobalLayoutListener(this);
                else obs.removeGlobalOnLayoutListener(this);
            }

        });

        final AutoResizeTextView written= (AutoResizeTextView) findViewById(R.id.written);

        vto = printed.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int height = (int) Math.floor(written.getHeight());
                ViewGroup.LayoutParams layoutParams = written.getLayoutParams();
                Typeface tf = Typeface.createFromAsset(getAssets(), "fonts/little_days.ttf");
                written.setLayoutParams(layoutParams);
                written.setText(letter.toLowerCase());
                written.setTextSize(height);
                written.setTextColor(Color.BLUE);
                written.setTypeface(tf);
                written.setIncludeFontPadding(false);

                ViewTreeObserver obs = written.getViewTreeObserver();

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN)
                    obs.removeOnGlobalLayoutListener(this);
                else obs.removeGlobalOnLayoutListener(this);
            }

        });
        final TableLayout table = (TableLayout) findViewById(R.id.picture_gallery);

        vto = table.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int width = table.getWidth();
                int height = table.getHeight();
                for (int i = 0; i < table.getChildCount(); ++i) {
                    TableRow tr = (TableRow) table.getChildAt(i);
                    for (int j = 0; j < tr.getChildCount(); ++j) {
                        if(tr.getChildAt(j) instanceof RelativeLayout){
                            RelativeLayout rl = (RelativeLayout) tr.getChildAt(j);
                            rl.getLayoutParams().height = height / 2;
                            rl.getLayoutParams().width = width / 2;
                            ImageView iv = (ImageView) rl.getChildAt(0);
                            iv.setImageDrawable(picture[i * 2 + j].getImage());
                            iv.setMaxHeight(height / 2);
                            iv.setMaxWidth(width / 2);
                            iv.getLayoutParams().height = height / 2;
                            iv.getLayoutParams().width = width / 2;
                            iv.setTag(picture[i * 2 + j].getName());
                            ImageButton ib = (ImageButton) rl.getChildAt(1);
                            ib.getLayoutParams().height = height / 10;
                            ib.getLayoutParams().width = width / 10;
                            ib.setTag(picture[i * 2 + j].getName());

                        }
                    }

                }
            }
        });

    }

    public void onBackButtonClicked(View view){
        finish();
    }

    public void checkAnswer(View view){
    }

    public void getVoiceTip(View view){

    }
}
