package cl.cc6909.ebm.leeconleo;

import android.app.Service;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Binder;
import android.os.IBinder;

public class BackgroundSound extends Service {
    private MediaPlayer mp;
    IBinder mBinder = new LocalBinder();
    public class LocalBinder extends Binder {
        public BackgroundSound getServerInstance() {
            return BackgroundSound.this;
        }
    }

    public BackgroundSound() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
    }
    public void onCreate()
    {
        mp = MediaPlayer.create(this, R.raw.running);
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

    public void volumeDown(){
        mp.setVolume(10,10);
    }
    public void volumeUp(){
        mp.setVolume(50,50);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        mp.start();
        return 1;
    }
}
