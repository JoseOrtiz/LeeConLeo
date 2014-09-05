package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import cl.cc6909.ebm.leeconleo.letters.LetterActivity;

public class GameMapActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game_map);
    }

    public void startVerticalLevel(View view){
        Intent intent = new Intent(this, VerticalActivity.class);
        startActivity(intent);

    }

    public void startHorizontalLevel(View view){
        Intent intent = new Intent(this, HorizontalActivity.class);
        startActivity(intent);
    }

    public void startPlatformLevel(View view){
        Intent intent = new Intent(this, PlatformActivity.class);
        startActivity(intent);
    }

    public void startBetweenLevel(View view){
        Intent intent = new Intent(this, BetweenActivity.class);
        startActivity(intent);
    }

    public void startLetterActivity(View view){
        Intent intent = new Intent(this, LetterActivity.class);
        String tag = (String) view.getTag();
        intent.putExtra("letter",tag);
        startActivity(intent);
    }

}
