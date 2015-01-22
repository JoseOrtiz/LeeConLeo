package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.content.Intent;
import android.content.res.AssetManager;
import android.os.Bundle;
import android.view.View;

import java.io.IOException;

import cl.cc6909.ebm.leeconleo.R;

public class LetterActivity extends Activity {
    private String letter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_letter);
        Intent intent = getIntent();
        letter = intent.getStringExtra("letter");
        checkConditions();
    }

    private void checkConditions() {
        checkStitch();
        checkTap();
        checkStartsWith();
        checkEndsWith();
        checkJoinStartWith();
        checkJoinEndsWith();
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

    private void checkStitch() {
        AssetManager mg = getResources().getAssets();
        try {
            mg.open("stitch/"+letter.toUpperCase()+".xml");

        } catch (IOException ex) {
            findViewById(R.id.stitch_layout).setVisibility(View.GONE);
        }
    }

    public void startTapActivity(View view){
        Intent intent = new Intent(this, TapActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    private void checkTap() {
        AssetManager mg = getResources().getAssets();
        try {
            mg.open("tap/"+letter.toUpperCase()+".txt");

        } catch (IOException ex) {
            findViewById(R.id.tap_layout).setVisibility(View.GONE);
        }
    }

    public void startStartsWithActivity(View view){
        Intent intent = new Intent(this, StartsWithActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    private void checkStartsWith() {
        AssetManager mg = getResources().getAssets();
        try {
            mg.open("startsWith/"+letter.toUpperCase()+".txt");

        } catch (IOException ex) {
            findViewById(R.id.starts_with_layout).setVisibility(View.GONE);
        }
    }

    public void startEndsWithActivity(View view){
        Intent intent = new Intent(this, EndsWithActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    private void checkEndsWith() {
        AssetManager mg = getResources().getAssets();
        try {
            mg.open("endsWith/"+letter.toUpperCase()+".txt");

        } catch (IOException ex) {
            findViewById(R.id.ends_with_layout).setVisibility(View.GONE);
        }
    }

    public void startJoinStartsWithActivity(View view){
        Intent intent = new Intent(this, JoinStartsWithActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    private void checkJoinStartWith() {
        AssetManager mg = getResources().getAssets();
        try {
            mg.open("joinStartsWith/"+letter.toUpperCase()+".txt");

        } catch (IOException ex) {
            findViewById(R.id.join_starts_with_layout).setVisibility(View.GONE);
        }
    }

    public void startJoinEndsWithActivity(View view){
        Intent intent = new Intent(this, JoinEndsWithActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    private void checkJoinEndsWith() {
        AssetManager mg = getResources().getAssets();
        try {
            mg.open("joinEndsWith/"+letter.toUpperCase()+".txt");

        } catch (IOException ex) {
            findViewById(R.id.join_ends_with_layout).setVisibility(View.GONE);
        }
    }


    public void startWrapActivity(View view){
        Intent intent = new Intent(this, WrapActivity.class);
        intent.putExtra("letter",letter);
        startActivity(intent);
    }

    public void onBackButtonClicked(View view){
        finish();
    }

}
