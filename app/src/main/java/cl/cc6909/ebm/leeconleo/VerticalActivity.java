package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.app.Dialog;
import android.content.ClipData;
import android.content.ClipDescription;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Handler;
import android.view.DragEvent;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;


public class VerticalActivity extends Activity implements View.OnClickListener {

    private static final String IMAGE_TAG = "Leo tag";
    private FeedbackDialog pd;
    private Handler h;
    private Runnable r;
    private int answer;
    private int drag_answer;
    private int totalCorrectAnswers = 2;
    private int correctAnswers;
    private ImageView leo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_verticality);
        correctAnswers = 0;

        h = new Handler();
        pd = new FeedbackDialog(this,"");
        r =new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                }
            }
        };

        ((ImageView)findViewById(R.id.back_button)).setOnClickListener(this);
        ((ImageView)findViewById(R.id.up_arrow)).setOnClickListener(this);
        ((ImageView)findViewById(R.id.down_arrow)).setOnClickListener(this);

        answer = R.id.down_answer;

        findViewById(answer).setVisibility(View.VISIBLE);
    }

    @Override
    protected void onDestroy() {
        h.removeCallbacks(r);
        if (pd.isShowing() ) {
            pd.dismiss();
        }
        super.onDestroy();
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.back_button:
                finish();
                break;
            case R.id.down_arrow:
                if(answer==R.id.down_answer){
                    pd.setGoodFeedback();
                    pd.show();
                    h.postDelayed(r, 2000);
                    changeAnswer();
                }
                else{
                    pd.setBadFeedback();
                    pd.show();
                    h.postDelayed(r, 2000);
                }
                break;
            case R.id.up_arrow:
                if(answer==R.id.up_answer){
                    pd.setGoodFeedback();
                    pd.show();
                    h.postDelayed(r, 2000);
                    changeAnswer();
                }
                else{
                    pd.setBadFeedback();
                    pd.show();
                    h.postDelayed(r, 2000);
                }
                break;
        }


    }

    private void changeAnswer(){
        findViewById(answer).setVisibility(View.GONE);
        correctAnswers++;
        if (Math.random()>0.5) {
            answer = R.id.down_answer;
        }
        else{
            answer = R.id.up_answer;
        }
        if(correctAnswers>totalCorrectAnswers){
            startDragActivity();
        }
        else{
            findViewById(answer).setVisibility(View.VISIBLE);
        }
    }

    private void startDragActivity(){
        drag_answer = R.id.down_surface;
        setDragTip(drag_answer);
        View answers = findViewById(R.id.vertical_answer);
        answers.setVisibility(View.GONE);
        leo = (ImageView) findViewById(R.id.draggable_leo);

        leo.setTag(IMAGE_TAG);
        leo.setVisibility(View.VISIBLE);

        leo.setOnLongClickListener(new View.OnLongClickListener() {

            @Override
            public boolean onLongClick(View v) {
                ClipData.Item item = new ClipData.Item((CharSequence) v.getTag());
                String[] mimeTypes = {ClipDescription.MIMETYPE_TEXT_PLAIN};
                ClipData dragData = new ClipData(v.getTag().toString(), mimeTypes, item);
                View.DragShadowBuilder myShadow = new MyDragShadowBuilder(leo);
                v.startDrag(dragData, myShadow, leo, 0);
                v.setVisibility(View.INVISIBLE);
                return true;
            }
        });

        findViewById(R.id.down_surface).setOnDragListener(new MyDragListener());
        findViewById(R.id.up_surface).setOnDragListener(new MyDragListener());
    }

    private void setDragTip(int dragAnswer) {
        TextView tv = (TextView) findViewById(R.id.drag_tip);
        if(dragAnswer == R.id.down_surface){
            tv.setText(getString(R.string.down));
        }
        else if(dragAnswer == R.id.up_surface){
            tv.setText(getString(R.string.up));
        }
    }

    private class FeedbackDialog extends Dialog {

        private TextView tv;

        public void setGoodFeedback(){
            tv.setText(getText(R.string.good_feedback));
            tv.setTextColor(Color.GREEN);
        }

        public void setBadFeedback(){
            tv.setText(getText(R.string.bad_feedback));
            tv.setTextColor(Color.RED);
        }
        public FeedbackDialog(Context context, String feedback) {
            super(context, R.style.Theme_Transparent);
            WindowManager.LayoutParams wlmp = getWindow().getAttributes();
            wlmp.gravity = Gravity.CENTER_HORIZONTAL;
            getWindow().setAttributes(wlmp);
            setTitle(null);
            setCancelable(false);
            setOnCancelListener(null);
            LinearLayout layout = new LinearLayout(context);
            layout.setOrientation(LinearLayout.VERTICAL);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
            tv = new TextView(context);
            tv.setText(feedback);
            tv.setTextSize(200);
            layout.addView(tv, params);
            addContentView(layout, params);
        }
    }

    private static class MyDragShadowBuilder extends View.DragShadowBuilder {

        private static Drawable shadow;
        private Bitmap image;

        public MyDragShadowBuilder(View v) {
            super(v);
            shadow = new ColorDrawable(R.drawable.adventurer);
        }

        @Override
        public void onProvideShadowMetrics (Point size, Point touch){
            int width, height;
            width = getView().getWidth() / 2;

            height = getView().getHeight() / 2;

            shadow.setBounds(0, 0, width, height);

            size.set(width, height);

            touch.set(width / 2, height / 2);
        }
        @Override
        public void onDrawShadow(Canvas canvas) {
            shadow.draw(canvas);
        }
    }

    class MyDragListener implements View.OnDragListener {
        Drawable normalShape = getResources().getDrawable(R.drawable.adventurer);
        @Override
        public boolean onDrag(View v, DragEvent event) {

            switch (event.getAction()) {
                case DragEvent.ACTION_DRAG_STARTED:
                    break;

                case DragEvent.ACTION_DRAG_ENTERED:
                    v.setBackgroundColor(Color.LTGRAY);
                    break;

                case DragEvent.ACTION_DRAG_EXITED:
                    v.setBackgroundColor(Color.TRANSPARENT);
                    break;

                case DragEvent.ACTION_DROP:
                    if(v == findViewById(drag_answer)) {
                        View view = (View) event.getLocalState();

                        ViewGroup owner = (ViewGroup) view.getParent();
                        owner.removeView(view);

                        FrameLayout container = (FrameLayout) v;
                        container.addView(view);
                        view.setX(event.getX());
                        view.setY(70);
                        pd.setGoodFeedback();
                        pd.show();
                        h.postDelayed(r, 2000);
                        view.setVisibility(View.VISIBLE);
                        changeDragAnswer(container,view);
                    } else {
                        View view = (View) event.getLocalState();
                        view.setVisibility(View.VISIBLE);
                        pd.setBadFeedback();
                        pd.show();
                        h.postDelayed(r, 2000);
                    }
                    break;

                case DragEvent.ACTION_DRAG_ENDED:
                    v.setBackgroundColor(Color.TRANSPARENT);

                default:
                    break;
            }
            return true;
        }
    }

    private void changeDragAnswer(FrameLayout container, View view) {
        container.removeView(view);
        LinearLayout answer_layout = (LinearLayout) findViewById(R.id.answer_layout);
        answer_layout.addView(view);
        int width = answer_layout.getWidth();
        view.setY(0);
        view.setX(width/2-64);
        correctAnswers++;
        if (Math.random()>0.5) {
            drag_answer = R.id.down_surface;
        }
        else{
            drag_answer= R.id.up_surface;
        }
        setDragTip(drag_answer);
        view.setVisibility(View.VISIBLE);

    }

}
