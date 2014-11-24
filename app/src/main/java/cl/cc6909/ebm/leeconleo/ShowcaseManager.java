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
    public ShowcaseView showcaseVerticalActivity(){
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
        return showcaseView;
    }
    public ShowcaseView showcaseVerticalDrag(){
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
        return showcaseView;
    }
    public ShowcaseView showcaseHorizontalTap(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Mueve a Leo")
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
        return showcaseView;
    }
    public ShowcaseView showcaseHorizontalDrag(){
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
        return showcaseView;
    }
    public ShowcaseView showcaseHorizontalTilt(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Mueve a Leo")
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
    public ShowcaseView showcasePlatform(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Evita los obstáculos")
                .setContentText("Desliza el dedo hacia arriba para que Leo salte")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.platform_swipe_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.platform_swipe_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

    public ShowcaseView showcaseBetween(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Arrastra el balón")
                .setContentText("Lleva la pelota a la posición requerida")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.between_drag_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.between_drag_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

    public ShowcaseView showcasePaint(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Pinta la letra")
                .setContentText("Selecciona un color y pinta la letra")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.paint_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.paint_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

    public ShowcaseView showcaseStitch(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Cose la letra")
                .setContentText("Aprieta los bloques y junta los dedos para coser la letra")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.stitch_pinch_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.stitch_pinch_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

    public ShowcaseView showcaseTap(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Descubre la letra")
                .setContentText("Remueve los bloques golpeándolos para descubrir la letra")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.tap_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.tap_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

    public ShowcaseView showcaseRecognition(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Selecciona la imagen")
                .setContentText("Selecciona la imagen correspondiente")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.tap_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.tap_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

    public ShowcaseView showcaseJoin(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Une la imagen a la letra")
                .setContentText("Arrastra el arnés hasta el gancho correspondiente")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.join_drag_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.join_drag_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

    public ShowcaseView showcaseWrap(){
        ShowcaseView showcaseView = new ShowcaseView.Builder(activity)
                //.setTarget(new ViewTarget(R.id.vertical_answer,activity))
                .setStyle(R.style.Custom_semi_transparent)
                .setContentTitle("Encierra la aparición de las letras")
                .setContentText("Arrastra el dedo alrededor de las letras correspondiente")
                .hideOnTouchOutside()
                .build();
        if(Build.VERSION.SDK_INT >= 16 ){
            showcaseView.setBackground(activity.getResources().getDrawable(R.drawable.wrap_animation));//minAPI=16
        }
        else{
            showcaseView.setBackgroundDrawable(activity.getResources().getDrawable(R.drawable.wrap_animation));//deprecated.
        }
        AnimationDrawable back = (AnimationDrawable) showcaseView.getBackground();
        back.start();
        return showcaseView;
    }

}
