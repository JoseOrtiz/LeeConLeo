package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.content.res.AssetFileDescriptor;
import android.graphics.drawable.AnimationDrawable;
import android.media.MediaPlayer;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.github.amlcurran.showcaseview.OnShowcaseEventListener;
import com.github.amlcurran.showcaseview.ShowcaseView;

import cl.cc6909.ebm.leeconleo.FeedbackDialog;
import cl.cc6909.ebm.leeconleo.R;
import cl.cc6909.ebm.leeconleo.ShowcaseManager;

public class JoinActivity extends Activity {
    protected Image[] picture;
    protected String letter="ma";
    protected Handler h;
    protected FeedbackDialog pd;
    protected Runnable r;
    protected Boolean finished;
    private MediaPlayer m;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_join);
        letter = getIntent().getStringExtra("letter");
        if(letter.equals("")){
            letter="ma";
        }


        final LinearLayout answers = (LinearLayout) findViewById(R.id.answer_layout);
        final RopeView rope = (RopeView) findViewById(R.id.rope_view);
        ((TextView)findViewById(R.id.letter_text)).setText(letter);
        rope.setActivity(this);

        h = new Handler();
        pd = new FeedbackDialog(this);
        r =new Runnable() {
            @Override
            public void run() {
                if (pd.isShowing()) {
                    pd.dismiss();
                }
                rope.restart();
                resetImages();
                if(finished){
                    finish();
                }
            }
        };
        finished=false;

        ViewTreeObserver vto = answers.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int size;
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
            }
        });
        vto = rope.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                int size = answers.getChildAt(0).getHeight();
                int width = rope.getWidth();
                rope.getLayoutParams().width = width - size;
                rope.setData(rope.getHeight());
                if (Build.VERSION.SDK_INT > Build.VERSION_CODES.ICE_CREAM_SANDWICH_MR1) {
                    rope.getViewTreeObserver().removeOnGlobalLayoutListener(this);
                } else {
                    rope.getViewTreeObserver().removeGlobalOnLayoutListener(this);
                }
            }

        });

        ShowcaseView showcaseView = new ShowcaseManager(this).showcaseJoin();
        showcaseView.setOnShowcaseEventListener(new JoinShowcaseListener());

    }

    public void onBackButtonClicked(View view){
        finish();
    }

    public void checkAnswer(int answer){
    }
    public void onImageClicked(View view){
        String name = (String) view.getTag();

        try {
            if (m.isPlaying()) {
                m.stop();
                m.release();
                m = new MediaPlayer();
            }

            AssetFileDescriptor descriptor = getAssets().openFd("picturesSpeech/"+name+".mp3");
            m.setDataSource(descriptor.getFileDescriptor(), descriptor.getStartOffset(), descriptor.getLength());
            descriptor.close();

            m.prepare();
            m.setVolume(1f, 1f);
            m.setLooping(true);
            m.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void resetImages(){
        LinearLayout answers = (LinearLayout) findViewById(R.id.answer_layout);

        for (int i = 0; i < answers.getChildCount(); ++i) {
            RelativeLayout rl = (RelativeLayout) answers.getChildAt(i);
            ImageView iv = (ImageView) rl.getChildAt(0);
            iv.setImageDrawable(picture[i].getImage());
        }

    }

    private class JoinShowcaseListener implements OnShowcaseEventListener{

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
