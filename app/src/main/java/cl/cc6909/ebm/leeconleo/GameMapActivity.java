package cl.cc6909.ebm.leeconleo;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import cl.cc6909.ebm.leeconleo.letters.AutoResizeTextView;
import cl.cc6909.ebm.leeconleo.letters.LetterActivity;

public class GameMapActivity extends Activity {
    private String[] letters=new String[]{
            "ao","ai","au","ae",
            "oa","oi","ou","oe",
            "ia","io","iu","ie",
            "ua","uo","ui","ue",
            "ea","eo","ei","eu",
            "m","ma","mo","mi","mu","me",
            "p","pa","po","pi","pu","pe",
            "l","la","lo","li","lu","le",
            "d","da","do","di","du","de",
            "s","sa","so","si","su","se",
            "b","ba","bo","bi","bu","be",
            "c","ca","co","ci","cu","ce",
            "f","fa","fo","fi","fu","fe",
            "g","ga","go","gi","gu","ge",
            "h","ha","ho","hi","hu","he",
            "j","ja","jo","ji","ju","je",
            "k","ka","ko","ki","ku","ke",
            "n","na","no","ni","nu","ne",
            "r","ra","ro","ri","ru","re",
            "t","ta","to","ti","tu","te",
            "v","va","vo","vi","vu","ve",
            "w","wa","wo","wi","wu","we",
            "x","xa","xo","xi","xu","xe",
            "y","ya","yo","yi","yu","ye",
            "z","za","zo","zi","zu","ze",
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game_map);
        LinearLayout map = (LinearLayout) findViewById(R.id.linear_map);
        int i=1;
        boolean grow=true;
        for(String l:letters){
            LinearLayout parent = new LinearLayout(this);
            parent.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 50));
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT);
            params.weight=1;
            params.gravity= Gravity.CENTER_HORIZONTAL;
            for(int j=0;j<7;++j){
                RelativeLayout aux = new RelativeLayout(this);
                aux.setLayoutParams(params);
                if(j==i) {
                    ImageView image = new ImageView(this);
                    image.setImageResource(R.drawable.between_levels_icon);
                    image.setLayoutParams(new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
                    image.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    aux.addView(image);
                }
                parent.addView(aux);

            }
            map.addView(parent);
            parent = new LinearLayout(this);
            parent.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 50));
            if(grow) {
                i++;
            }else{
                i--;
            }
            for(int j=0;j<7;++j){
                RelativeLayout aux = new RelativeLayout(this);
                aux.setLayoutParams(params);
                if(j==i) {
                    ImageView image = new ImageView(this);
                    image.setImageResource(R.drawable.between_levels_icon);
                    image.setLayoutParams(new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
                    image.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    aux.addView(image);
                }
                parent.addView(aux);

            }
            map.addView(parent);
            parent = new LinearLayout(this);
            parent.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));
            if(grow) {
                i++;
            }else{
                i--;
            }
            for(int j=0;j<7;++j){
                RelativeLayout aux = new RelativeLayout(this);
                aux.setLayoutParams(params);
                if(grow && j==i-1){
                    AutoResizeTextView text = new AutoResizeTextView(this);
                    text.setText(l);
                    text.setLayoutParams(new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,60));
                    text.setTextSize(100f);
                    text.setGravity(Gravity.CENTER_HORIZONTAL);
                    aux.addView(text);
                }
                if(!grow && j==i+1) {
                    AutoResizeTextView text = new AutoResizeTextView(this);
                    text.setText(l);
                    text.setLayoutParams(new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, 60));
                    text.setTextSize(100f);
                    text.setGravity(Gravity.CENTER_HORIZONTAL);
                    aux.addView(text);
                }
                if(j==i) {
                    ImageButton image = new ImageButton(this);
                    image.setImageResource(R.drawable.level);
                    image.setLayoutParams(new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT));
                    image.setBackgroundColor(Color.TRANSPARENT);
                    image.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            startLetterActivity(v);
                        }
                    });
                    image.setTag(l);
                    aux.addView(image);
                }
                parent.addView(aux);
            }
            if(grow) {
                if(i==6) {
                    grow = false;
                    i=5;
                }
                else i++;
            }else{
                if(i==0) {
                    grow = true;
                    i=1;
                }
                else i--;
            }
            map.addView(parent);
        }
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
