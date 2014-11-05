package cl.cc6909.ebm.leeconleo.letters;

import android.annotation.TargetApi;
import android.graphics.Color;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.ActionBarActivity;
import android.text.Layout;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Vector;

import cl.cc6909.ebm.leeconleo.FeedbackDialog;
import cl.cc6909.ebm.leeconleo.R;

public class WrapActivity extends ActionBarActivity {
    protected String letter;
    protected Handler h;
    protected FeedbackDialog pd;
    protected Runnable r;
    protected WrapView wrapView;
    private ArrayList<String> dictionary;
    private String answer1, answer2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_wrap);
        loadDictionary();
        letter = getIntent().getStringExtra("letter");
        changeAnswers();
        h = new Handler();
        pd = new FeedbackDialog(this);
        r = new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                }
            }
        };
        final AutoResizeTextView printed = (AutoResizeTextView) findViewById(R.id.printed);

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

        final AutoResizeTextView written = (AutoResizeTextView) findViewById(R.id.written);

        vto = written.getViewTreeObserver();
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
        final RelativeLayout wrapSurface = (RelativeLayout) findViewById(R.id.wrap_surface);
        vto = wrapSurface.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int height = wrapSurface.getHeight();
                findViewById(R.id.wrap_1).getLayoutParams().height = height / 2;
                findViewById(R.id.wrap_2).getLayoutParams().height = height / 2;
            }
        });
        wrapView = (WrapView) findViewById(R.id.wrap_view);
        TextView wrap1 = (TextView) findViewById(R.id.wrap_1);
        TextView wrap2 = (TextView) findViewById(R.id.wrap_2);
        Typeface tf = Typeface.createFromAsset(getAssets(), "fonts/little_days.ttf");
        wrap1.setText(answer1);
        wrap1.setTypeface(tf);
        wrap2.setText(answer2);
        wrap2.setTypeface(tf);
    }

    private void loadDictionary() {
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        dictionary = new ArrayList<String>();

        try {
            is = getResources().getAssets().open("wrap/dictionary.txt");
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);
            String line;
            while((line=br.readLine())!=null){
                dictionary.add(line);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
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
            } catch (Exception e) {
            }
        }
    }

    public void changeAnswers(){
        Iterator<String> iterator = dictionary.iterator();
        while(iterator.hasNext()){
            String next = iterator.next();
            if(next.indexOf(letter)>0){
                answer1=next;
                break;
            }
        }
        while(iterator.hasNext()){
            String next = iterator.next();
            if(next.indexOf(letter)>0){
                answer2=next;
                break;
            }
        }

    }

    public void onBackButtonClicked(View view) {
        finish();
    }

    public boolean checkAnswer() {
        TextView wrap1 = (TextView) findViewById(R.id.wrap_1);
        TextView wrap2 = (TextView) findViewById(R.id.wrap_2);
        Rect rect1 = new Rect();
        Rect rect2 = new Rect();
        wrap1.getGlobalVisibleRect(rect1);
        wrap2.getGlobalVisibleRect(rect2);
        Vector<Float> xAxis = wrapView.getXAxis();
        Vector<Float> yAxis = wrapView.getYAxis();
        float xMin = Collections.min(xAxis);
        float xMax = Collections.max(xAxis);
        float yMin = Collections.min(yAxis);
        float yMax = Collections.max(yAxis);
        int[] locations = new int[2];
        wrap1.getLocationOnScreen(locations);
        boolean intersect1 = rect1.intersects((int) xMin, (int) yMin + locations[1], (int) xMax, (int) yMax + locations[1]);
        boolean intersect2 = rect2.intersects((int) xMin, (int) yMin + locations[1], (int) xMax, (int) yMax + locations[1]);
        if (!(intersect1 && intersect2)) {
            if (intersect1) {
                Layout layout1 = wrap1.getLayout();
                CharSequence text = Normalizer.normalize(answer1, Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "");
                int i = text.toString().indexOf(letter);
                float[] widths = new float[letter.length()];
                layout1.getPaint().getTextWidths(text, i, i + letter.length(), widths);
                return checkPosition(wrap1, xMin-locations[0]-10, xMax-locations[0]-10, yMin, yMax, widths);
            } else if (intersect2) {
                Layout layout2 = (wrap2).getLayout();
                CharSequence text = Normalizer.normalize(answer2, Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "");
                int i = text.toString().indexOf(letter);
                float[] widths = new float[letter.length()];
                layout2.getPaint().getTextWidths(text, i, i + letter.length(), widths);
                return checkPosition(wrap1, xMin-locations[0]-10, xMax-locations[0]-10, yMin, yMax, widths);
            }
        }
        return false;
    }

    @TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    private boolean checkPosition(TextView wrap, float xMin, float xMax, float yMin, float yMax, float[] measure) {
        float center = yMin + yMax / 2;
        HashMap<Integer, Integer> count = new HashMap<Integer, Integer>();
        Layout layout = wrap.getLayout();
        float total=0;
        for(float f:measure){
            total+=f;
        }
        for (float x = xMin; x <= xMax; x += 1) {
            int value;
            if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.ICE_CREAM_SANDWICH) {
                 value = wrap.getOffsetForPosition(x, center);
            }else {
                int line = layout.getLineForVertical((int) center);
                value = layout.getOffsetForHorizontal(line, x);
            }
            if (count.containsKey(value)) {
                count.put(value, count.get(value) + 1);
            } else {
                count.put(value, 1);
            }
        }
        if (count.size() >= letter.length() && count.size() <= letter.length() + 2) {
            Integer first= Collections.min(count.keySet());
            int i = wrap.getText().toString().indexOf(letter, first);
            int sum= 0;
            for (int j = 0; j < letter.length(); j++) {
                if (count.containsKey(j + i)) {
                    sum += count.get(j + i);
                }
            }
            if(count.containsKey(i-1)){
                if(count.get(i-1)>total/2){
                    return false;
                }
            }
            if(count.containsKey(i+letter.length()+1)){
                if(count.get(i+letter.length()+1)>total/2){
                    return false;
                }
            }
            Log.i("total", total + "");
            Log.i("suma", sum + "");
            if (sum >= total*4/5) {
                return true;
            }
        }
        return false;
    }
}