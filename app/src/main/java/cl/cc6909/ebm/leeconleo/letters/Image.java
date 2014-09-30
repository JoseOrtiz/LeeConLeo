package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.graphics.drawable.Drawable;

import java.io.IOException;
import java.io.InputStream;

public class Image {
    private String name;
    private Drawable image;
    public Image(String filename,String folder, Activity activity){
        this.name = filename.substring(0,filename.indexOf("."));
        InputStream is = null;
        try {
            is = activity.getResources().getAssets().open(folder+filename);
            image = Drawable.createFromStream(is,null);
        }catch (Exception e){

        }
        finally {
            try {
                is.close();
            } catch (Exception e) {

                e.printStackTrace();
            }
        }
    }

    public Drawable getImage() {
        return image;
    }

    public String getName() {
        return name;
    }
}
