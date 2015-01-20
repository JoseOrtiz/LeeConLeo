package cl.cc6909.ebm.leeconleo;

import android.app.Service;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.IBinder;

public class BackgroundSound extends Service {
    private MediaPlayer mp;

    public BackgroundSound() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
    public void onCreate()
    {
        mp = MediaPlayer.create(this, R.raw.intro);
        mp.setLooping(true);
        mp.setVolume(50,50);
    }
    public void onStop()
    {
        mp.stop();
        mp.release();
    }

    public void onDestroy(){
        mp.stop();
        mp.release();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        mp.start();
        return 1;
    }
}
