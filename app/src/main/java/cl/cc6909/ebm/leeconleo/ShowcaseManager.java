package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.graphics.drawable.AnimationDrawable;
import android.os.Build;

import com.github.amlcurran.showcaseview.ShowcaseView;
import com.github.amlcurran.showcaseview.targets.ViewTarget;

public class ShowcaseManager {
    private final Activity activity;
    public ShowcaseManager(Activity activity) {
        this.activity = activity;
    }
    public void showcaseBackButton() {
        new ShowcaseView.Builder(activity)
                .setTarget(new ViewTarget(R.id.back_button,activity))
                .setContentTitle("Volver")
                .setContentText("Al presionar volverás al menú")
                .hideOnTouchOutside()
                .build();
    }
    public void showcaseVerticalActivity(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Respuestas")
                .setContentText("Selecciona la flecha correspondiente a la posición de Leo")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.vertical_tap_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.vertical_tap_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
    }
    public void showcaseVerticalDrag(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Arrastra a Leo")
                .setContentText("Mantén presionado a Leo y arrástralo hacia la posición mencionada")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.vertical_drag_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.vertical_drag_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
    }
    public void showcaseHorizontalTap(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Arrastra a Leo")
                .setContentText("Seleciona la flecha correspondiente a la posición mencionada")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.horizontal_tap_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.horizontal_tap_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
    }
    public void showcaseHorizontalDrag(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Arrastra a Leo")
                .setContentText("Mantén presionado a Leo y arrástralo hacia la posición mencionada")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.horizontal_drag_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.horizontal_drag_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
    }
    public ShowcaseView showcaseHorizontalTilt(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Arrastra a Leo")
                .setContentText("Inclina tu dispositivo hacia la posición requerida")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.horizontal_tilt_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.horizontal_tilt_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

}
