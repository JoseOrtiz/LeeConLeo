package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.View;


public class MenuActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);
        Intent objIntent = new Intent(this, BackgroundSound.class);
        startService(objIntent);
    }

    public void startGame(View view){
        Intent intent = new Intent(this, GameMapActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
        startActivity(intent);

    }

    @Override
    protected void onDestroy() {
        Intent objIntent = new Intent(this, BackgroundSound.class);
        stopService(objIntent);
        super.onDestroy();
    }
}
