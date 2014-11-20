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
import android.util.SparseBooleanArray;
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
    private SparseBooleanArray completed1, completed2;
    private Iterator<String> iterator;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_wrap);
        loadDictionary();
        letter = getIntent().getStringExtra("letter");
        completed1 = new SparseBooleanArray();
        completed2 = new SparseBooleanArray();
        changeAnswers();
        h = new Handler();
        pd = new FeedbackDialog(this);
        r = new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                    wrapView.clearCanvas();
                    completed1.clear();
                    completed2.clear();
                    changeAnswers();
                    setAnswers();
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
        wrap1.setTypeface(tf);
        wrap2.setTypeface(tf);
        setAnswers();
    }

    private void setAnswers() {
        TextView wrap1 = (TextView) findViewById(R.id.wrap_1);
        TextView wrap2 = (TextView) findViewById(R.id.wrap_2);
        wrap1.setText(answer1);
        wrap2.setText(answer2);
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
        iterator = dictionary.iterator();
    }

    public void changeAnswers(){
        while(iterator.hasNext()){
            String next = iterator.next();
            if(Normalizer.normalize(next.toLowerCase(), Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "").contains(letter)){
                answer1=next;
                setAnswerToComplete(answer1,completed1);
                break;
            }
        }
        while(iterator.hasNext()){
            String next = iterator.next();
            if(Normalizer.normalize(next.toLowerCase(), Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "").contains(letter)){
                answer2=next;
                setAnswerToComplete(answer2,completed2);
                break;
            }
        }

    }

    private void setAnswerToComplete(String answer, SparseBooleanArray completed) {
        int i=-1;
        while(i<answer.length()){
            int index = Normalizer.normalize(answer.toLowerCase(), Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "").indexOf(letter,i);
            //int index = answer.indexOf(letter, i);
            if(index>i) {
                completed.append(index, false);
                i=index+1;
            }else{
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
                CharSequence text = Normalizer.normalize(answer1.toLowerCase(), Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "");
                int i = text.toString().indexOf(letter);
                float[] widths = new float[letter.length()];
                layout1.getPaint().getTextWidths(text, i, i + letter.length(), widths);
                int position = checkPosition(wrap1, xMin - locations[0] - 10, xMax - locations[0] - 10, yMin, yMax, widths,completed1);
                if(position>=0){
                    completed1.put(position,true);
                    checkCompleted();
                    return true;
                }
            } else if (intersect2) {
                Layout layout2 = (wrap2).getLayout();
                CharSequence text = Normalizer.normalize(answer2.toLowerCase(), Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "");
                int i = text.toString().indexOf(letter);
                float[] widths = new float[letter.length()];
                layout2.getPaint().getTextWidths(text, i, i + letter.length(), widths);
                int position = checkPosition(wrap2, xMin - locations[0] - 10, xMax - locations[0] - 10, yMin, yMax, widths,completed2);
                if(position>=0){
                    completed2.put(position,true);
                    checkCompleted();
                    return true;
                }
            }
        }
        return false;
    }

    private void checkCompleted() {
        for(int i=0;i<completed1.size();++i){
            if(!completed1.valueAt(i))
                return;
        }
        for(int i=0;i<completed2.size();++i){
            if(!completed2.valueAt(i))
                return;
        }
        pd.setGoodFeedback();
        pd.show();
        h.postDelayed(r, 2000);
    }

    @TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    private int checkPosition(TextView wrap, float xMin, float xMax, float yMin, float yMax, float[] measure, SparseBooleanArray completed) {
        if(yMax-yMin<measure[0]*2/3)
            return -1;
        float center = yMin + yMax / 2;
        HashMap<Integer, Integer> count = new HashMap<Integer, Integer>();
        Layout layout = wrap.getLayout();
        float totalMeasure=0;
        for(float f:measure){
            totalMeasure+=f;
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
            int i=Normalizer.normalize(wrap.getText().toString().toLowerCase(), Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "").indexOf(letter, first);
            int sum = 0;
            int wide;
            if(completed.get(i)){
                return -1;
            }
            for (int j = 0; j < letter.length(); j++) {
                if (count.containsKey(j + i)) {
                    sum += count.get(j + i);
                }
            }
            wide=sum;
            if(count.containsKey(i-1)){
                wide+=count.get(i-1);
                if(count.get(i-1)>totalMeasure/2){
                    return -1;
                }
            }
            if(count.containsKey(i+letter.length()+1)){
                wide+=count.get(i+letter.length()+1);
                if(count.get(i+letter.length()+1)>totalMeasure/2){
                    return -1;
                }
            }
            if (sum >= totalMeasure*6/10 && wide<totalMeasure*8/5) {
                return i;
            }
            if(i==wrap.getText().length()-1 && sum>=totalMeasure*2/3){
                return i;
            }
        }
        return -1;
    }
}