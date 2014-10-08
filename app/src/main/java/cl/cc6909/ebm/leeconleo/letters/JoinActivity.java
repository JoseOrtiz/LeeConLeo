package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import cl.cc6909.ebm.leeconleo.R;

public class JoinActivity extends Activity {
    protected Image[] picture;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_join);

        picture = new Image[]{
                new Image("mono.png","pictures/",this),
                new Image("arbol.jpg","pictures/",this),
                new Image("casa.jpg","pictures/",this),
                new Image("perro.jpg","pictures/",this),
        };

        final LinearLayout answers = (LinearLayout) findViewById(R.id.answer_layout);
        final int[] width = {200};

        ViewTreeObserver vto = answers.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                for (int i = 0; i < answers.getChildCount(); ++i) {
                    RelativeLayout rl = (RelativeLayout) answers.getChildAt(i);
                    int size = rl.getHeight();
                    ImageView iv = (ImageView) rl.getChildAt(0);
                    iv.setImageDrawable(picture[i].getImage());
                    iv.setMaxHeight(size);
                    iv.setMaxWidth(size);
                    iv.getLayoutParams().height = size;
                    iv.getLayoutParams().width = size;
                    iv.setTag(picture[i].getName());
                    width[0] =size;
                }
            }
        });
        final RopeView rope = (RopeView) findViewById(R.id.rope_view);

        vto = rope.getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {

            @Override
            public void onGlobalLayout() {
                int width1 = rope.getWidth();
                rope.getLayoutParams().width = width1 - width[0];
                rope.setData(rope.getHeight());
            }
        });
    }

    public void onBackButtonClicked(View view){
        finish();
    }

}
