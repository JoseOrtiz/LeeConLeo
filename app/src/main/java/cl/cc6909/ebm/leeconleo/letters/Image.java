package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.graphics.drawable.Drawable;
import android.util.Log;

import java.io.IOException;
import java.io.InputStream;

public class Image {
    private final String folder;
    private final Activity activity;
    private final String filename;
    private String name;
    private Drawable image;
    public Image(String filename,String folder, Activity activity){
        this.name = filename.substring(0,filename.indexOf("."));
        this.filename=filename;
        this.folder = folder;
        this.activity=activity;
    }

    public Drawable getImage() {
        if(image==null) {
            InputStream is = null;
            try {
                is = activity.getResources().getAssets().open(folder + filename);
                image = Drawable.createFromStream(is, null);
            } catch (Exception e) {
                Log.i("filename", filename);

            } finally {
                try {
                    is.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return image;
    }

    public String getName() {
        return name;
    }
}
