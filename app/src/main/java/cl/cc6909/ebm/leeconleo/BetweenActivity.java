package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.content.ClipData;
import android.content.ClipDescription;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.AnimationDrawable;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.view.DragEvent;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.ImageView;
import android.widget.TextView;

import com.github.amlcurran.showcaseview.OnShowcaseEventListener;
import com.github.amlcurran.showcaseview.ShowcaseView;

public class BetweenActivity extends Activity implements View.OnClickListener {
    private static final String IMAGE_TAG = "Ball tag";
    private FeedbackDialog pd;
    private Handler h;
    private Runnable r;
    private ImageView ball;
    private int answer, correctAnswers;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_between);
        correctAnswers=0;
        final ImageView leftTable = (ImageView) findViewById(R.id.leftTable);
        final ImageView rightTable = (ImageView) findViewById(R.id.rightTable);
        ViewTreeObserver vto = rightTable.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int height = findViewById(R.id.gameArea).getHeight()/2+10;
                rightTable.getLayoutParams().height = height;
                ViewTreeObserver obs = rightTable.getViewTreeObserver();

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                    obs.removeOnGlobalLayoutListener(this);
                } else {
                    obs.removeGlobalOnLayoutListener(this);
                }
            }

        });
        vto = leftTable.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                leftTable.getLayoutParams().height = findViewById(R.id.gameArea).getHeight()/2+10;
                ViewTreeObserver obs = leftTable.getViewTreeObserver();

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN)
                    obs.removeOnGlobalLayoutListener(this);
                else obs.removeGlobalOnLayoutListener(this);
            }

        });
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

        answer = R.id.center_surface;
        setDragTip(answer);
        ball = (ImageView) findViewById(R.id.draggable_ball);
        ball.setTag(IMAGE_TAG);
        ball.setOnLongClickListener( new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View v) {
                ClipData.Item item = new ClipData.Item((CharSequence) v.getTag());
                String[] mimeTypes = {ClipDescription.MIMETYPE_TEXT_PLAIN};
                ClipData dragData = new ClipData(v.getTag().toString(), mimeTypes, item);
                View.DragShadowBuilder myShadow = new MyDragShadowBuilder(ball, BitmapFactory.decodeResource(getResources(), R.drawable.basketball));
                v.startDrag(dragData, myShadow, ball, 0);
                v.setVisibility(View.GONE);
                return true;
            }
        });

        findViewById(R.id.back_button).setOnClickListener(this);
        findViewById(R.id.left_surface).setOnDragListener(new MyDragListener());
        findViewById(R.id.center_surface).setOnDragListener(new MyDragListener());
        findViewById(R.id.right_surface).setOnDragListener(new MyDragListener());
        ShowcaseView showcaseView = new ShowcaseManager(this).showcaseBetween();
        showcaseView.setOnShowcaseEventListener(new BetweenShowcaseListener());
    }

    private void setDragTip(int dragAnswer) {
        TextView tv = (TextView) findViewById(R.id.drag_tip);
        if(dragAnswer == R.id.center_surface){
            tv.setText(getString(R.string.between_tables));
        }
        else if(dragAnswer == R.id.left_surface){
            tv.setText(getString(R.string.over_left_table));
        }
        else if(dragAnswer == R.id.right_surface){
            tv.setText(getString(R.string.over_right_table));
        }
    }

    @Override
    public void onClick(View v) {
        int click = v.getId();
        switch (click) {
            case R.id.back_button:
                finish();
                break;
        }
    }

    class MyDragListener implements View.OnDragListener {
        View view;
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
                    if(v == findViewById(answer)) {
                        if(answer==R.id.center_surface) {
                            view = findViewById(R.id.center_ball);
                        }
                        else if(answer==R.id.left_surface) {
                            view = findViewById(R.id.left_ball);
                        }
                        else if(answer==R.id.right_surface) {
                            view = findViewById(R.id.right_ball);
                        }

                        r =new Runnable(){

                            @Override
                            public void run() {
                                if (pd.isShowing()) {
                                    pd.dismiss();
                                    changeDragAnswer(view);
                                }
                            }
                        };

                        pd.setGoodFeedback();
                        pd.show();
                        h.postDelayed(r, 2000);
                        view.setVisibility(View.VISIBLE);
                        return true;
                    } else {
                        pd.setBadFeedback();
                        pd.show();
                        r =new Runnable(){

                            @Override
                            public void run() {
                                if (pd.isShowing()) {
                                    pd.dismiss();
                                }
                            }
                        };
                        h.postDelayed(r, 2000);
                    }
                    return false;

                case DragEvent.ACTION_DRAG_ENDED:
                    if(!event.getResult()){
                        View view = (View) event.getLocalState();
                        view.setVisibility(View.VISIBLE);
                    }
                    v.setBackgroundColor(Color.TRANSPARENT);

                default:
                    break;
            }
            return true;
        }
    }
    private void changeDragAnswer(View view){
        view.setVisibility(View.GONE);
        correctAnswers++;
        double aux=Math.random()*3;
        if (aux<1) {
            answer = R.id.left_surface;
        }
        else if(aux>2){
            answer = R.id.right_surface;
        }
        else{
            answer = R.id.center_surface;
        }
        findViewById(R.id.draggable_ball).setVisibility(View.VISIBLE);
        setDragTip(answer);
    }

    private class BetweenShowcaseListener implements OnShowcaseEventListener{

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
