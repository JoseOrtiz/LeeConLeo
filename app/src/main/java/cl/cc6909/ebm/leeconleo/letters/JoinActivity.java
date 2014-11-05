package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import cl.cc6909.ebm.leeconleo.FeedbackDialog;
import cl.cc6909.ebm.leeconleo.R;

public class JoinActivity extends Activity {
    protected Image[] picture;
    protected String letter;
    protected Handler h;
    protected FeedbackDialog pd;
    protected Runnable r;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_join);
        letter = getIntent().getStringExtra("letter");


        final LinearLayout answers = (LinearLayout) findViewById(R.id.answer_layout);
        final RopeView rope = (RopeView) findViewById(R.id.rope_view);
        rope.setActivity(this);

        h = new Handler();
        pd = new FeedbackDialog(this);
        r =new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                }
                rope.reset();
            }
        };

        ViewTreeObserver vto = answers.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int size = 200;
                for (int i = 0; i < answers.getChildCount(); ++i) {
                    RelativeLayout rl = (RelativeLayout) answers.getChildAt(i);
                    size = rl.getHeight();
                    ImageView iv = (ImageView) rl.getChildAt(0);
                    iv.setImageDrawable(picture[i].getImage());
                    iv.setMaxHeight(size);
                    iv.setMaxWidth(size);
                    iv.getLayoutParams().height = size;
                    iv.getLayoutParams().width = size;
                    iv.setTag(picture[i].getName());
                }
                int width = rope.getWidth();
                rope.getLayoutParams().width = width - size;
                rope.setData(rope.getHeight());
            }
        });
    }

    public void onBackButtonClicked(View view){
        finish();
    }

    public void checkAnswer(int answer){
    }

    protected void resetImages(){
        LinearLayout answers = (LinearLayout) findViewById(R.id.answer_layout);

        for (int i = 0; i < answers.getChildCount(); ++i) {
            RelativeLayout rl = (RelativeLayout) answers.getChildAt(i);
            ImageView iv = (ImageView) rl.getChildAt(0);
            iv.setImageDrawable(picture[i].getImage());
        }

    }

}
