package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.content.ClipData;
import android.content.ClipDescription;
import android.content.Context;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Handler;
import android.view.DragEvent;
import android.view.OrientationEventListener;
import android.view.Surface;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;


public class HorizontalActivity extends Activity implements View.OnClickListener {
    private static final String IMAGE_TAG = "Leo horizontal tag";
    private FeedbackDialog pd;
    private Handler h;
    private Runnable r1;
    private Runnable r2;
    private FrameLayout container;
    private View view;
    private int answer;
    private int drag_answer;
    private int totalCorrectAnswers = 3;
    private int correctAnswers;
    private ImageView leo;
    private MyTiltEventListener myTiltEventListener;
    private int tiltThreshold=30;
    private Runnable r3;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_horizontal);
        correctAnswers = 0;

        h = new Handler();
        pd = new FeedbackDialog(this);
        r1 = new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                    if (correctAnswers > totalCorrectAnswers) {
                        startDragActivity();
                    } else {
                        findViewById(answer).setVisibility(View.VISIBLE);
                    }
                }
            }
        };

        ((ImageView)findViewById(R.id.back_button)).setOnClickListener(this);
        ((ImageView)findViewById(R.id.left_arrow)).setOnClickListener(this);
        ((ImageView)findViewById(R.id.right_arrow)).setOnClickListener(this);

        answer = R.id.left_answer;

        findViewById(answer).setVisibility(View.VISIBLE);
    }

    @Override
    protected void onDestroy() {
        h.removeCallbacks(r1);
        if (pd.isShowing()) {
            pd.dismiss();
        }
        super.onDestroy();
    }

    /*protected void onPause() {
        super.onPause();
        try{
            mSensorManager.unregisterListener(myTiltEventListener);
        }catch (Exception e){

        }
    }

    protected void onResume() {
        super.onResume();
        if(correctAnswers>2*totalCorrectAnswers){
            startTiltActivity();
        }else {
            if (correctAnswers > totalCorrectAnswers) {
                startDragActivity();
            }
        }
        try {
            mSensorManager.registerListener(myTiltEventListener, mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), SensorManager.SENSOR_DELAY_NORMAL);
        }catch (Exception e){

        }
    }*/

    @Override
    public void onClick(View v) {
        int click = v.getId();
        switch (click) {
            case R.id.back_button:
                finish();
                break;
            case R.id.left_arrow:
                if (answer == R.id.left_answer) {
                    pd.setGoodFeedback();
                    pd.show();
                    h.postDelayed(r1, 2000);
                    changeAnswer();
                } else {
                    pd.setBadFeedback();
                    pd.show();
                    h.postDelayed(r1, 2000);
                }
                break;
            case R.id.right_arrow:
                if (answer == R.id.right_answer) {
                    pd.setGoodFeedback();
                    pd.show();
                    h.postDelayed(r1, 2000);
                    changeAnswer();
                } else {
                    pd.setBadFeedback();
                    pd.show();
                    h.postDelayed(r1, 2000);
                }
                break;
        }
    }

    private void changeAnswer() {
        findViewById(answer).setVisibility(View.GONE);
        correctAnswers++;
        if (Math.random() > 0.5) {
            answer = R.id.left_answer;
        } else {
            answer = R.id.right_answer;
        }
    }

    private void startDragActivity(){
        drag_answer = R.id.left_surface;
        setDragTip(drag_answer);
        View answers = findViewById(R.id.horizontal_answers);
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
                View.DragShadowBuilder myShadow = new MyDragShadowBuilder(leo, BitmapFactory.decodeResource(getResources(), R.drawable.adventurer));
                v.startDrag(dragData, myShadow, leo, 0);
                return true;
            }
        });

        findViewById(R.id.left_surface).setOnDragListener(new MyDragListener());
        findViewById(R.id.right_surface).setOnDragListener(new MyDragListener());
    }

    private void setDragTip(int dragAnswer) {
        TextView tv = (TextView) findViewById(R.id.drag_tip);
        if(dragAnswer == R.id.left_surface){
            tv.setText(getString(R.string.left));
        }
        else if(dragAnswer == R.id.right_surface){
            tv.setText(getString(R.string.right));
        }
    }

    private void changeDragAnswer(FrameLayout container, View view) {
        container.removeView(view);
        LinearLayout answer_layout = (LinearLayout) findViewById(R.id.answer_layout);
        answer_layout.addView(view);
        int width = answer_layout.getWidth();
        view.setY(10);
        view.setX(width/2-64);
        correctAnswers++;
        if (Math.random()>0.5) {
            drag_answer = R.id.left_surface;
        }
        else{
            drag_answer= R.id.right_surface;
        }
        setDragTip(drag_answer);
        view.setVisibility(View.VISIBLE);

    }

    private void startTiltActivity() {
        findViewById(R.id.left_surface).setOnDragListener(null);
        findViewById(R.id.right_surface).setOnDragListener(null);
        findViewById(R.id.draggable_leo).setOnLongClickListener(null);

        changeTiltAnswer(container,view);
        myTiltEventListener = new MyTiltEventListener(this);
        myTiltEventListener.enable();
    }

    private void changeTiltAnswer(FrameLayout container, View view){
        container.removeView(view);
        LinearLayout answer_layout = (LinearLayout) findViewById(R.id.answer_layout);
        answer_layout.addView(view);
        int width = answer_layout.getWidth();
        view.setY(10);
        view.setX(width/2-64);
        correctAnswers++;
        if (Math.random()>0.5) {
            drag_answer = R.id.left_surface;
        }
        else{
            drag_answer= R.id.right_surface;
        }
        setDragTip(drag_answer);
        view.setVisibility(View.VISIBLE);
    }

    private void checkTiltAnswer(int orientation) {
        r3 =new Runnable(){

            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                    changeTiltAnswer(container,view);
                    myTiltEventListener.enable();
                }
            }
        };
        ViewGroup owner = (ViewGroup) view.getParent();
        owner.removeView(view);
        if(orientation<-1*tiltThreshold && drag_answer==R.id.left_surface){
            container = (FrameLayout) findViewById(R.id.left_surface);
            container.addView(view);
            view.setX(container.getWidth()/2-64);
            view.setY(container.getHeight()/2-126);
            pd.setGoodFeedback();
            correctAnswers++;
        }
        else if(orientation>tiltThreshold && drag_answer==R.id.right_surface){
            container = (FrameLayout) findViewById(R.id.right_surface);
            container.addView(view);
            view.setX(container.getWidth()/2-64);
            view.setY(container.getHeight()/2-126);
            pd.setGoodFeedback();
            correctAnswers++;
        }
        else{
            switch (drag_answer){
                case R.id.left_surface:
                    container = (FrameLayout) findViewById(R.id.right_surface);
                    break;
                case R.id.right_surface:
                    container = (FrameLayout) findViewById(R.id.left_surface);
                    break;
            }
            container.addView(view);
            view.setX(container.getWidth()/2-64);
            view.setY(container.getHeight()/2-126);
            pd.setBadFeedback();
        }
        pd.show();
        h.postDelayed(r3, 2000);
    }

    class MyDragListener implements View.OnDragListener {
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
                        view = (View) event.getLocalState();

                        ViewGroup owner = (ViewGroup) view.getParent();
                        owner.removeView(view);

                        container = (FrameLayout) v;
                        container.addView(view);
                        view.setX(container.getWidth()/2-64);
                        view.setY(container.getHeight()/2-126);

                        r2 =new Runnable(){

                            @Override
                            public void run() {
                                if (pd.isShowing()) {
                                    pd.dismiss();
                                    if (correctAnswers > 2*totalCorrectAnswers) {
                                        startTiltActivity();
                                    } else {
                                        changeDragAnswer(container, view);
                                    }
                                }
                            }
                        };

                        pd.setGoodFeedback();
                        pd.show();
                        h.postDelayed(r2, 2000);
                        view.setVisibility(View.VISIBLE);
                    } else {
                        View view = (View) event.getLocalState();
                        view.setVisibility(View.VISIBLE);
                        pd.setBadFeedback();
                        pd.show();
                        r2 =new Runnable(){

                            @Override
                            public void run() {
                                if (pd.isShowing()) {
                                    pd.dismiss();
                                }
                            }
                        };
                        h.postDelayed(r2, 2000);
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

    private class MyTiltEventListener extends OrientationEventListener {

        public MyTiltEventListener(Context context) {
            super(context);
        }

        @Override
        public void onOrientationChanged(int orientation) {
            orientation = adjustDegree(orientation);
            LinearLayout answer_layout = (LinearLayout) findViewById(R.id.answer_layout);
            int width = answer_layout.getWidth();
            view.setX(width/2-64+3*orientation);
            if(orientation>tiltThreshold || orientation<-1*tiltThreshold){
                checkTiltAnswer(orientation);
                disable();
            }
        }
        private int adjustDegree(int orientation){
            int naturalOrientation = ((WindowManager) getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay().getRotation();
            if (naturalOrientation == Surface.ROTATION_90){
                orientation += 90;
            }
            else if (naturalOrientation == Surface.ROTATION_180){
                orientation += 180;
            }
            else if (naturalOrientation == Surface.ROTATION_270){
                orientation += 270;
            }

            if (orientation > 360){
                orientation -= 360;
            }
            if(orientation > 180){
                orientation -= 360;
            }
            return orientation;
        }
    }

}