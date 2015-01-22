package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.content.ClipData;
import android.content.ClipDescription;
import android.content.Context;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.AnimationDrawable;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.DragEvent;
import android.view.OrientationEventListener;
import android.view.Surface;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.github.amlcurran.showcaseview.OnShowcaseEventListener;
import com.github.amlcurran.showcaseview.ShowcaseView;


public class HorizontalActivity extends Activity implements View.OnClickListener {
    private static final String IMAGE_TAG = "Leo horizontal tag";
    private FeedbackDialog pd;
    private Handler h;
    private Runnable r1, r2, r3;
    private View view;
    private int answer;
    private int drag_answer;
    private int totalCorrectAnswers = 5;
    private int correctAnswers;
    private ImageView leo;
    private MyTiltEventListener myTiltEventListener;
    private int tiltThreshold=25;
    private MediaPlayer mDrag, mDrop;


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

        findViewById(R.id.back_button).setOnClickListener(this);
        findViewById(R.id.left_arrow).setOnClickListener(this);
        findViewById(R.id.right_arrow).setOnClickListener(this);

        answer = R.id.left_answer;

        findViewById(answer).setVisibility(View.VISIBLE);
        ShowcaseView showcaseView = new ShowcaseManager(this).showcaseHorizontalTap();
        showcaseView.setOnShowcaseEventListener(new HorizontalShowcaseListener());
    }

    @Override
    protected void onDestroy() {
        h.removeCallbacks(r1);
        try{
            h.removeCallbacks(r2);
        }catch (Exception e){
            Log.e("Horizontal Destroy",e.getMessage());
        }
        try{
            h.removeCallbacks(r3);
        }catch (Exception e){
            Log.e("Horizontal Destroy",e.getMessage());
        }
        if (pd.isShowing()) {
            pd.dismiss();
        }
        try{
            myTiltEventListener.disable();
        }
        catch (Exception e ){
            Log.i("Horizontal Destroy", "Tilt Listener not initialized");
        }
        super.onDestroy();
    }

    /*protected void onPause() {
        super.onPause();
        try{
            mSensorManager.unregisterListener(myTiltEventListener);
        }catch (Exception e){

        }
    }*/

    protected void onResume() {
        super.onResume();
        if(correctAnswers>2*totalCorrectAnswers){
            startTiltActivity();
        }else {
            if (correctAnswers > totalCorrectAnswers) {
                startDragActivity();
            }
        }
        /*try {
            mSensorManager.registerListener(myTiltEventListener, mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), SensorManager.SENSOR_DELAY_NORMAL);
        }catch (Exception e){

        }*/
    }

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
        findViewById(R.id.answer_layout).setVisibility(View.VISIBLE);
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
                v.setVisibility(View.INVISIBLE);
                return true;
            }
        });

        findViewById(R.id.left_surface).setOnDragListener(new MyDragListener());
        findViewById(R.id.right_surface).setOnDragListener(new MyDragListener());
        ShowcaseView showcaseView = new ShowcaseManager(this).showcaseHorizontalDrag();
        showcaseView.setOnShowcaseEventListener(new HorizontalShowcaseListener());
        mDrag =MediaPlayer.create(this,R.raw.drag);
        mDrop =MediaPlayer.create(this,R.raw.drop);

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

    private void changeDragAnswer(View view) {
        view.setVisibility(View.INVISIBLE);
        correctAnswers++;
        if (Math.random()>0.5) {
            drag_answer = R.id.left_surface;
        }
        else{
            drag_answer= R.id.right_surface;
        }
        setDragTip(drag_answer);
        findViewById(R.id.draggable_leo).setVisibility(View.VISIBLE);

    }

    private void startTiltActivity() {
        findViewById(R.id.left_surface).setOnDragListener(null);
        findViewById(R.id.right_surface).setOnDragListener(null);
        findViewById(R.id.draggable_leo).setOnLongClickListener(null);

        changeTiltAnswer(view);
        myTiltEventListener = new MyTiltEventListener(this);
        ShowcaseView horizontalTilt = new ShowcaseManager(this).showcaseHorizontalTilt();
        horizontalTilt.setOnShowcaseEventListener(new HorizontalShowcaseListener());

    }

    private void changeTiltAnswer( View view){
        view.setVisibility(View.INVISIBLE);
        correctAnswers++;
        if (Math.random()>0.5) {
            drag_answer = R.id.left_surface;
        }
        else{
            drag_answer= R.id.right_surface;
        }
        setDragTip(drag_answer);
        findViewById(R.id.draggable_leo).setVisibility(View.VISIBLE);
    }

    private void checkTiltAnswer(int orientation) {
        r3 = new Runnable() {

            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                    changeTiltAnswer(view);
                    myTiltEventListener.enable();
                }
            }
        };
        findViewById(R.id.draggable_leo).setVisibility(View.INVISIBLE);
        if(orientation<-1*tiltThreshold && drag_answer==R.id.left_surface){
            view = findViewById(R.id.left_answer);

            pd.setGoodFeedback();
            correctAnswers++;
        }
        else if(orientation>tiltThreshold && drag_answer==R.id.right_surface){
            view = findViewById(R.id.right_answer);
            pd.setGoodFeedback();
            correctAnswers++;
        }
        else{
            switch (drag_answer){
                case R.id.left_surface:
                    view = findViewById(R.id.right_answer);
                    break;
                case R.id.right_surface:
                    view = findViewById(R.id.left_answer);
                    break;
            }
            pd.setBadFeedback();
        }
        view.setVisibility(View.VISIBLE);
        pd.show();
        h.postDelayed(r3, 2000);
    }

    class MyDragListener implements View.OnDragListener {
        @Override
        public boolean onDrag(View v, DragEvent event) {

            switch (event.getAction()) {
                case DragEvent.ACTION_DRAG_STARTED:
                    dragSound();
                    break;

                case DragEvent.ACTION_DRAG_ENTERED:
                    v.setBackgroundColor(Color.LTGRAY);
                    break;

                case DragEvent.ACTION_DRAG_EXITED:
                    v.setBackgroundColor(Color.TRANSPARENT);
                    break;

                case DragEvent.ACTION_DROP:
                    if(v == findViewById(drag_answer)) {
                        if(drag_answer == R.id.left_surface){
                            view = findViewById(R.id.left_answer);
                        }
                        else{
                            view = findViewById(R.id.right_answer);
                        }

                        r2 =new Runnable(){

                            @Override
                            public void run() {
                                if (pd.isShowing()) {
                                    pd.dismiss();
                                    if (correctAnswers > 2*totalCorrectAnswers) {
                                        startTiltActivity();
                                    } else {
                                        changeDragAnswer(view);
                                    }
                                }
                            }
                        };

                        pd.setGoodFeedback();
                        pd.show();
                        h.postDelayed(r2, 2000);
                        view.setVisibility(View.VISIBLE);
                        return true;
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
                    return false;

                case DragEvent.ACTION_DRAG_ENDED:
                    if(!event.getResult()){
                        View view = (View) event.getLocalState();
                        view.setVisibility(View.VISIBLE);
                    }
                    v.setBackgroundColor(Color.TRANSPARENT);
                    dropSound();

                default:
                    break;
            }
            return true;
        }
    }
    private void dragSound() {
        try {
            if (mDrag.isPlaying()) {
                mDrag.stop();
                mDrag.release();
                mDrag = MediaPlayer.create(this, R.raw.drag);
            }

            mDrag.setVolume(100, 100);
            mDrag.setLooping(false);
            mDrag.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void dropSound() {
        try {
            if (mDrop.isPlaying()) {
                mDrop.stop();
                mDrop.release();
                mDrop =MediaPlayer.create(this,R.raw.drop);
            }

            mDrop.setVolume(100, 100);
            mDrop.setLooping(false);
            mDrop.start();
        } catch (Exception e) {
            e.printStackTrace();
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
            findViewById(R.id.draggable_leo).setX(width/2-64+3*orientation);
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

    private class HorizontalShowcaseListener implements OnShowcaseEventListener{

        @Override
        public void onShowcaseViewHide(ShowcaseView showcaseView) {
            AnimationDrawable background = (AnimationDrawable) showcaseView.getBackground();
            background.stop();
        }

        @Override
        public void onShowcaseViewDidHide(ShowcaseView showcaseView) {
            if(myTiltEventListener!=null) {
                myTiltEventListener.enable();
            }

        }

        @Override
        public void onShowcaseViewShow(ShowcaseView showcaseView) {

        }
    }

}