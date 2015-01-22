package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.content.ClipData;
import android.content.ClipDescription;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.AnimationDrawable;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.os.Handler;
import android.view.DragEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.github.amlcurran.showcaseview.OnShowcaseEventListener;
import com.github.amlcurran.showcaseview.ShowcaseView;


public class VerticalActivity extends Activity implements View.OnClickListener{

    private static final String IMAGE_TAG = "Leo tag";
    private FeedbackDialog pd;
    private Handler h;
    private Runnable r1;
    private FrameLayout container;
    private View view;
    private int answer;
    private int drag_answer;
    private int totalCorrectAnswers = 5;
    private int correctAnswers;
    private ImageView leo;
    private MediaPlayer mDrag,mDrop;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_verticality);
        correctAnswers = 0;

        h = new Handler();
        pd = new FeedbackDialog(this);
        r1 =new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                    if(correctAnswers>totalCorrectAnswers){
                        startDragActivity();
                    }
                    else{
                        findViewById(answer).setVisibility(View.VISIBLE);
                    }
                }
            }
        };

        findViewById(R.id.back_button).setOnClickListener(this);
        findViewById(R.id.up_arrow).setOnClickListener(this);
        findViewById(R.id.down_arrow).setOnClickListener(this);

        answer = R.id.down_answer;

        findViewById(answer).setVisibility(View.VISIBLE);
        //new ShowcaseManager(this).showcaseBackButton();
        ShowcaseView showcaseView = new ShowcaseManager(this).showcaseVerticalActivity();
        showcaseView.setOnShowcaseEventListener(new VerticalShowcaseListener());
    }

    @Override
    protected void onDestroy() {
        h.removeCallbacks(r1);
        if (pd.isShowing() ) {
            pd.dismiss();
        }
        super.onDestroy();
    }

    @Override
    public void onClick(View v) {
        int click = v.getId();
        switch (click){
            case R.id.back_button:
                finish();
                break;
            case R.id.down_arrow:
                if(answer==R.id.down_answer){
                    pd.setGoodFeedback();
                    pd.show();
                    h.postDelayed(r1, 2000);
                    changeAnswer();
                }
                else{
                    pd.setBadFeedback();
                    pd.show();
                    h.postDelayed(r1, 2000);
                }
                break;
            case R.id.up_arrow:
                if(answer==R.id.up_answer){
                    pd.setGoodFeedback();
                    pd.show();
                    h.postDelayed(r1, 2000);
                    changeAnswer();
                }
                else{
                    pd.setBadFeedback();
                    pd.show();
                    h.postDelayed(r1, 2000);
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
                View.DragShadowBuilder myShadow = new MyDragShadowBuilder(leo, BitmapFactory.decodeResource(getResources(),R.drawable.adventurer));
                v.startDrag(dragData, myShadow, leo, 0);
                v.setVisibility(View.INVISIBLE);
                return true;
            }
        });

        findViewById(R.id.down_surface).setOnDragListener(new MyDragListener());
        findViewById(R.id.up_surface).setOnDragListener(new MyDragListener());
        ShowcaseView showcaseView = new ShowcaseManager(this).showcaseVerticalDrag();
        showcaseView.setOnShowcaseEventListener(new VerticalShowcaseListener());
        mDrag =MediaPlayer.create(this,R.raw.drag);
        mDrop =MediaPlayer.create(this,R.raw.drop);
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
                    Runnable r2;
                    if(v == findViewById(drag_answer)) {
                        view = (View) event.getLocalState();

                        ViewGroup owner = (ViewGroup) view.getParent();
                        owner.removeView(view);

                        container = (FrameLayout) v;
                        container.addView(view);
                        view.setX(event.getX());
                        view.setY(container.getHeight()-252);

                        r2 =new Runnable(){

                            @Override
                            public void run() {
                                if (pd.isShowing()) {
                                    pd.dismiss();
                                    changeDragAnswer(container, view);
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
                mDrag =MediaPlayer.create(this,R.raw.drag);
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

    private class VerticalShowcaseListener implements OnShowcaseEventListener{

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
