package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.graphics.drawable.AnimationDrawable;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.TableLayout;
import android.widget.TableRow;

import com.github.amlcurran.showcaseview.OnShowcaseEventListener;
import com.github.amlcurran.showcaseview.ShowcaseView;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Vector;

import cl.cc6909.ebm.leeconleo.FeedbackDialog;
import cl.cc6909.ebm.leeconleo.R;
import cl.cc6909.ebm.leeconleo.ShowcaseManager;

public class TapActivity extends Activity{

    private String letter;
    private Vector<String> tap;
    private Handler h;
    private FeedbackDialog pd;
    private Runnable r;
    private boolean completed = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tap);

        tap = new Vector<String>();
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
        final AutoResizeTextView tapText = (AutoResizeTextView) findViewById(R.id.tap_text);

        ViewTreeObserver vto = tapText.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int width = (int) Math.floor(tapText.getWidth());
                ViewGroup.LayoutParams layoutParams = tapText.getLayoutParams();
                layoutParams.height=width;
                tapText.setLayoutParams(layoutParams);
                tapText.setText(letter.toUpperCase());
                tapText.setLayerType(View.LAYER_TYPE_SOFTWARE, null);
                tapText.setTextSize(width);
                tapText.setIncludeFontPadding(false);

                TableLayout tapSurface = (TableLayout) findViewById(R.id.tap_surface);
                tapSurface.getLayoutParams().height = width;
                int rect_size = (int) Math.floor(width / 10);
                for(int i=0;i<tapSurface.getChildCount();++i){
                    TableRow row = (TableRow) tapSurface.getChildAt(i);
                    for(int j=0;j<row.getChildCount();++j){
                        View button = row.getChildAt(j);
                        button.getLayoutParams().height= rect_size;
                        button.getLayoutParams().width = rect_size;
                        button.setTag(""+(i * row.getChildCount() + j));
                    }
                }
                ViewTreeObserver obs = tapText.getViewTreeObserver();

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN)
                    obs.removeOnGlobalLayoutListener(this);
                else obs.removeGlobalOnLayoutListener(this);
            }

        });

        setTapNeeded();
        ShowcaseView showcaseView = new ShowcaseManager(this).showcaseTap();
        showcaseView.setOnShowcaseEventListener(new TapShowcaseListener());
    }

    private void setTapNeeded() {
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        try {
            is = getAssets().open("tap/" + letter.toUpperCase() + ".txt");
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);
            String line;
            while((line=br.readLine())!=null){
                tap.add(line);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try {
                if (is != null) {
                    is.close();
                }
                if (isr != null) {
                    isr.close();
                }
                if (br != null) {
                    br.close();
                }
            }catch (Exception e) {
            }
        }
    }

    public void onRoundButtonClicked(View view){
        String number = (String) view.getTag();
        Log.i("number",""+number);
        tap.remove(number);
        view.setVisibility(View.INVISIBLE);
        if(checkCompleted() && !completed){
            pd.setGoodFeedback();
            pd.show();
            h.postDelayed(r, 2000);
            completed = true;
        }
    }

    public void onBackButtonClicked(View view){
        finish();
    }

    public boolean checkCompleted(){
        return tap.isEmpty();
    }

    private class TapShowcaseListener implements OnShowcaseEventListener{

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
