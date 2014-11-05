package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

import cl.cc6909.ebm.leeconleo.R;

public class LetterActivity extends Activity {
    private String letter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_letter);
        Intent intent = getIntent();
        letter = intent.getStringExtra("letter");
    }

    public void startIntroductionActivity(View view){
        Intent intent = new Intent(this, IntroductionActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }
    public void startPaintingActivity(View view){
        Intent intent = new Intent(this, PaintActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    public void startStitchActivity(View view){
        Intent intent = new Intent(this, StitchActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    public void startTapActivity(View view){
        Intent intent = new Intent(this, TapActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    public void startStartsWithActivity(View view){
        Intent intent = new Intent(this, StartsWithActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    public void startEndsWithActivity(View view){
        Intent intent = new Intent(this, EndsWithActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    public void startJoinStartsWithActivity(View view){
        Intent intent = new Intent(this, JoinStartsWithActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    public void startJoinEndsWithActivity(View view){
        Intent intent = new Intent(this, JoinEndsWithActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }


    public void startWrapActivity(View view){
        Intent intent = new Intent(this, WrapActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

}
